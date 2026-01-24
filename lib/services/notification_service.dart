import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';
import 'package:drift/drift.dart' as drift;
import 'package:permission_handler/permission_handler.dart';
import '../database/database.dart';

class NotificationService {
  final AppDatabase db;
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  NotificationService(this.db);

  // Categorized messages for better UX
  final Map<String, List<String>> _warmMessages = {
    'soft': [
      "Just a gentle check-in.",
      "A small call can mean a lot.",
      "Thinking of %name%? One minute is enough.",
    ],
    'overdue': [
      "You said %name% matters. Just one call.",
      "It's been a while. %name% would love to hear from you.",
      "You care. Let them feel it.",
    ],
    'serious': [
      "Connection takes intention. One quick call?",
      "The people who matter deserve a minute. Call %name%?",
      "Value your connections. Don't let too much time pass.",
    ]
  };

  Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );
  }

  Future<void> requestPermission() async {
    final status = await Permission.notification.request();
    if (status.isDenied) {
      // Permission was denied
    }
  }

  // Handle actions like "Call Now"
  static void _onNotificationResponse(NotificationResponse response) async {
    if (response.payload == null) return;

    if (response.actionId == 'call_action') {
      final url = 'tel:${response.payload}';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      }
    } else if (response.actionId == 'snooze_action') {
      // In a real app, we'd schedule a reminder for 4 hours later
      // For MVP, we can just leave this as a placeholder or dismiss
      // dismiss
    }
  }

  Future<void> checkAndNotify(List<TrackedContact> contacts) async {
    final now = DateTime.now();
    // Warm timing: 9 AM to 9 PM
    if (now.hour >= 21 || now.hour < 8) return;

    for (var contact in contacts) {
      if (!contact.remindersEnabled) continue;

      // Rule: Max 1 notification per contact per day
      if (contact.lastNotified != null) {
        final lastNotifiedDate = DateTime(contact.lastNotified!.year,
            contact.lastNotified!.month, contact.lastNotified!.day);
        final today = DateTime(now.year, now.month, now.day);
        if (lastNotifiedDate.isAtSameMomentAs(today)) continue;
      }

      final lastCalled = contact.lastCalled;
      final daysSince =
          lastCalled != null ? now.difference(lastCalled).inDays : 999;

      if (daysSince >= contact.frequencyDays) {
        await _showNotification(contact, daysSince);
      }
    }
  }

  Future<void> sendTestNotification() async {
    final testContact = TrackedContact(
      id: 9999,
      name: "Sample Person",
      nickname: "Abbu",
      phoneNumber: "123456789",
      frequencyDays: 7,
      remindersEnabled: true,
      createdAt: DateTime.now(),
    );
    await _showNotification(testContact, 14, updateDb: false);
  }

  Future<void> _showNotification(TrackedContact contact, int daysSince,
      {bool updateDb = true}) async {
    final random = Random();
    final overdueLevel = daysSince - contact.frequencyDays;

    String category = 'soft';
    if (overdueLevel > 7) {
      category = 'serious';
    } else if (overdueLevel > 2) {
      category = 'overdue';
    }

    final messages = _warmMessages[category]!;
    String message = messages[random.nextInt(messages.length)];

    final displayName = contact.nickname ?? contact.name;
    message = message.replaceAll('%name%', displayName);

    final androidDetails = AndroidNotificationDetails(
      'reminders_channel',
      'Reminders',
      channelDescription: 'Gentle relationship reminders',
      importance: Importance.high,
      priority: Priority.high,
      color: const Color(0xFF28A745),
      actions: [
        AndroidNotificationAction(
          'call_action',
          'Call Now',
          showsUserInterface: true,
          icon: DrawableResourceAndroidBitmap(
              '@mipmap/ic_launcher'), // Placeholder for call icon
        ),
        AndroidNotificationAction(
          'snooze_action',
          'Snooze',
          showsUserInterface: false,
        ),
      ],
    );

    final details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      contact.id,
      'Remember $displayName',
      message,
      details,
      payload: contact.phoneNumber,
    );

    // Update lastNotified
    if (updateDb) {
      await db.updateTrackedContact(
        contact.copyWith(lastNotified: drift.Value(DateTime.now())),
      );
    }
  }
}
