// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:drift/drift.dart' as drift;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/widgets.dart';
import '../database/database.dart';

class NotificationConstants {
  static const String reminderChannelId = 'reminders_channel';
  static const String summaryChannelId = 'daily_summary_channel';
  static const String reflectionChannelId = 'daily_reflection_channel';

  static const int summaryId = 1000;
  static const int reflectionId = 1001;

  static const Color brandColor = Color(0xFF28A745);
}

class NotificationContent {
  static final Map<String, List<String>> _warmMessages = {
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

  static String getMessage(String category, String name) {
    final messages = _warmMessages[category] ?? _warmMessages['soft']!;
    final message = messages[Random().nextInt(messages.length)];
    return message.replaceAll('%name%', name);
  }

  static String getCategory(int daysSince, int frequencyDays) {
    final overdueLevel = daysSince - frequencyDays;
    if (overdueLevel > 7) return 'serious';
    if (overdueLevel > 2) return 'overdue';
    return 'soft';
  }

  static List<String> getDaytimeMessages(String name) => [
        "You have a quiet moment. Maybe check in with $name 📞",
        "Thinking of $name? One minute is enough.",
        "Just a gentle check-in with $name.",
      ];
}

class NotificationService {
  final AppDatabase db;
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static NotificationService? _instance;

  factory NotificationService(AppDatabase db) {
    _instance ??= NotificationService._internal(db);
    return _instance!;
  }

  NotificationService._internal(this.db);

  Future<void> init() async {
    const androidInit =
        AndroidInitializationSettings('@drawable/ic_notification');
    const initSettings = InitializationSettings(android: androidInit);

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: notificationTapHandler,
      onDidReceiveBackgroundNotificationResponse: notificationTapHandler,
    );

    // Check if app was launched from a notification
    final launchDetails =
        await _notifications.getNotificationAppLaunchDetails();

    if (launchDetails?.didNotificationLaunchApp ?? false) {
      if (launchDetails?.notificationResponse != null) {
        notificationTapHandler(launchDetails!.notificationResponse!);
      }
    }
  }

  Future<void> showMorningSummary(List<TrackedContact> overdue) async {
    if (overdue.isEmpty) return;

    final androidDetails = AndroidNotificationDetails(
      NotificationConstants.summaryChannelId,
      'Daily Summaries',
      channelDescription: 'Morning overview of people to call',
      importance: Importance.high,
      priority: Priority.high,
      color: NotificationConstants.brandColor,
    );

    await _notifications.show(
      NotificationConstants.summaryId,
      'Today’s connections',
      '${overdue.length} people you care about could use a quick call today',
      NotificationDetails(android: androidDetails),
    );
  }

  Future<void> showDaytimeNudge(TrackedContact contact, DateTime now) async {
    // final displayName = contact.nickname ?? contact.name;
    // final messages = NotificationContent.getDaytimeMessages(displayName);
    // final message = messages[Random().nextInt(messages.length)];
    final lastCalled = contact.lastCalled;
    final daysSince =
        lastCalled != null ? now.difference(lastCalled).inDays : 999;
    await _showNotification(contact, daysSince);
  }

  Future<void> showEveningReflection(bool userCalledToday) async {
    final title = userCalledToday ? "Nice work today ❤️" : "Just Call";
    final body = userCalledToday
        ? "Staying connected matters. You made a difference."
        : "Even a small hello can mean a lot. Tomorrow is a new chance ✨";

    final androidDetails = AndroidNotificationDetails(
      NotificationConstants.reflectionChannelId,
      'Daily Reflections',
      channelDescription: 'Evening inspiration',
      importance: Importance.low,
      priority: Priority.low,
      color: NotificationConstants.brandColor,
    );

    await _notifications.show(
      NotificationConstants.reflectionId,
      title,
      body,
      NotificationDetails(android: androidDetails),
    );
  }

  Future<void> requestPermission() async {
    await Permission.notification.request();
  }

  Future<void> sendTestNotification() async {
    final testContact = TrackedContact(
      id: 9999,
      name: "Sample Person",
      nickname: "Abbu",
      phoneNumber: "123456789",
      frequencyDays: 7,
      remindersEnabled: true,
      lastCalled: DateTime.now().subtract(const Duration(days: 10)),
      createdAt: DateTime.now(),
    );
    await _showNotification(testContact, 14, updateDb: false);
  }

  Future<void> _showNotification(TrackedContact contact, int daysSince,
      {bool updateDb = true, String? customMessage}) async {
    final displayName = contact.nickname ?? contact.name;
    final category =
        NotificationContent.getCategory(daysSince, contact.frequencyDays);
    final message =
        customMessage ?? NotificationContent.getMessage(category, displayName);

    final androidDetails = AndroidNotificationDetails(
      NotificationConstants.reminderChannelId,
      'Reminders',
      channelDescription: 'Gentle relationship reminders',
      importance: Importance.high,
      priority: Priority.high,
      color: NotificationConstants.brandColor,
      actions: [
        const AndroidNotificationAction(
          'call_action',
          'Call Now',
          showsUserInterface: true,
          icon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        ),
        const AndroidNotificationAction(
          'snooze_action',
          'Snooze',
          showsUserInterface: false,
          cancelNotification: true,
        ),
      ],
    );

    await _notifications.show(
      contact.id,
      'Remember $displayName',
      message,
      NotificationDetails(android: androidDetails),
      payload: contact.phoneNumber,
    );

    if (updateDb) {
      await db.updateTrackedContact(
        contact.copyWith(lastNotified: drift.Value(DateTime.now())),
      );
    }
  }

  // Legacy/Test support
  Future<void> checkAndNotify(List<TrackedContact> contacts) async {
    final now = DateTime.now();
    for (var contact in contacts) {
      if (!contact.remindersEnabled) continue;
      if (_alreadyNotifiedToday(contact, now)) continue;

      final lastCalled = contact.lastCalled;
      final daysSince =
          lastCalled != null ? now.difference(lastCalled).inDays : 999;

      if (daysSince >= contact.frequencyDays) {
        await _showNotification(contact, daysSince);
      }
    }
  }

  bool _alreadyNotifiedToday(TrackedContact contact, DateTime now) {
    if (contact.lastNotified == null) return false;
    return contact.lastNotified!.year == now.year &&
        contact.lastNotified!.month == now.month &&
        contact.lastNotified!.day == now.day;
  }
}

@pragma('vm:entry-point')
void notificationTapHandler(NotificationResponse response) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (response.payload == null) return;

  if (response.actionId == 'call_action' || response.actionId == null) {
    _launchDialer(response.payload!);
  }
}

void _launchDialer(String phoneNumber) async {
  final phone = phoneNumber.replaceAll(RegExp(r'\s+'), '');
  final uri = Uri.parse(phone.startsWith('+') ? 'tel:$phone' : 'tel:+$phone');
  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    debugPrint('Failed to launch dialer: $e');
  }
}
