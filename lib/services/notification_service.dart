import 'package:call_monitor/database/database_manager.dart';
import 'package:call_monitor/database/drift_database.dart';
import 'package:call_monitor/pages/timeline_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  GlobalKey<NavigatorState>? _navigatorKey;

  Future<void> init(GlobalKey<NavigatorState> navigatorKey) async {
    _navigatorKey = navigatorKey;

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _handleNotificationResponse,
    );

    // Handle Cold Start
    final launchDetails =
        await _notificationsPlugin.getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      final response = launchDetails!.notificationResponse;
      if (response != null) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _handleNotificationResponse(response);
        });
      }
    }

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  void _handleNotificationResponse(NotificationResponse response) async {
    final payload = response.payload;
    if (payload == null) return;
    final trackGroupId = int.tryParse(payload);
    if (trackGroupId == null) return;

    // Ensure navigator is ready
    if (_navigatorKey?.currentState == null) {
      await Future.delayed(const Duration(milliseconds: 500));
    }

    if (response.actionId == 'CALL_NOW') {
      final db = DatabaseManager.database;
      final contacts = await db.getContactsForTrackGroup(trackGroupId);
      final numbers = contacts.expand((c) => c.phoneNumbers).toList();

      if (numbers.isNotEmpty) {
        if (numbers.length == 1) {
          final sanitizedNumber =
              numbers.first.replaceAll(RegExp(r'\s+|-'), '');
          final url = Uri.parse('tel:$sanitizedNumber');
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          }
        } else {
          final trackGroup = await db.getTrackGroupById(trackGroupId);
          _showNumberSelectionDialog(trackGroup?.name ?? 'Contact', numbers);
        }
      }
    } else {
      _navigatorKey?.currentState?.push(
        MaterialPageRoute(
          builder: (_) => TimelineViewPage(trackGroupId: trackGroupId),
        ),
      );
    }
  }

  void _showNumberSelectionDialog(String name, List<String> numbers) {
    final context = _navigatorKey?.currentContext;
    if (context == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Call $name'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: numbers.map((number) {
            return ListTile(
              leading: const Icon(Icons.phone),
              title: Text(number),
              onTap: () async {
                Navigator.pop(context);
                final sanitizedNumber = number.replaceAll(RegExp(r'\s+|-'), '');
                final url = Uri.parse('tel:$sanitizedNumber');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> showNotification(TrackGroup group) async {
    const androidDetails = AndroidNotificationDetails(
      'call_monitor_channel',
      'Call Monitor Reminders',
      channelDescription: 'Reminders for overdue calls',
      importance: Importance.max,
      priority: Priority.high,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction('CALL_NOW', 'Call Now',
            showsUserInterface: true),
        AndroidNotificationAction('VIEW_TIMELINE', 'View Timeline',
            showsUserInterface: true),
      ],
    );
    const details = NotificationDetails(android: androidDetails);

    String body = 'It\'s time to call ${group.name}!';
    if (group.frequency == 1) {
      body = 'Haven\'t spoken today? Give ${group.name} a call! 🌙';
    } else if (group.frequency == 2) {
      body = 'It\'s been a while! Catch up with ${group.name} this weekend. ❤️';
    }

    await _notificationsPlugin.show(
      group.id,
      'Time to connect with ${group.name}',
      body,
      details,
      payload: group.id.toString(),
    );
  }

  Future<void> showFakeNotification() async {
    await showNotification(
        const TrackGroup(id: 1, name: 'Fake Group', frequency: 1));
  }
}
