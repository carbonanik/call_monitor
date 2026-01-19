// import 'dart:ui'; // Removed
import 'package:call_log/call_log.dart';
import 'package:workmanager/workmanager.dart';
import 'package:call_monitor/database/drift_database.dart';
import 'package:call_monitor/util/monitor_service.dart';
import 'package:call_monitor/component/communication_status.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CallLogsDataSource {
  Future<List<CallLogEntry>> getCallLogs() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    return entries.toList();
  }

  Future<List<CallLogEntry>> getCallLogsByNumber(String number) async {
    final to = DateTime.now();
    final from = to.subtract(const Duration(days: 30));
    Iterable<CallLogEntry> entries = await CallLog.query(
      dateFrom: from.millisecondsSinceEpoch,
      dateTo: to.millisecondsSinceEpoch,
      number: number,
    );
    return entries.toList();
  }

  Future<List<CallLogEntry>> getCallLogsByNumbers(List<String> numbers) async {
    final to = DateTime.now();
    final from = to.subtract(const Duration(days: 30));
    List<CallLogEntry> entries = [];
    for (var number in numbers) {
      final logs = await CallLog.query(
        dateFrom: from.millisecondsSinceEpoch,
        dateTo: to.millisecondsSinceEpoch,
        number: number,
      );
      entries.addAll(logs);
    }
    return entries;
  }

  /* methods moved outside */
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((dynamic task, dynamic inputData) async {
    print('Background Services are Working!');
    try {
      // Initialize Database
      final db = AppDatabase();
      final groups = await db.getAllTrackGroups();

      for (final group in groups) {
        final contacts = await db.getContactsForTrackGroup(group.id);
        final numbers = contacts.expand((c) => c.phoneNumbers).toList();

        if (numbers.isNotEmpty) {
          final to = DateTime.now();
          final from = to.subtract(const Duration(days: 30));

          Iterable<CallLogEntry> entries = [];
          for (var number in numbers) {
            var logs = await CallLog.query(
              dateFrom: from.millisecondsSinceEpoch,
              dateTo: to.millisecondsSinceEpoch,
              number: number,
            );
            entries = entries.followedBy(logs);
          }

          final status = MonitorService.checkStatus(group, entries.toList());

          if (status == CommunicationStatus.overdue) {
            final now = DateTime.now();
            final lastTime = group.lastNotificationTime;

            // Frequency Cap: Max 1 per day
            final alreadyNotifiedToday =
                lastTime != null && now.difference(lastTime).inHours < 24;

            if (!alreadyNotifiedToday) {
              // Smart Timing: Check safe window (e.g. 8 AM - 9 PM) unless in debug
              // For simplicity, let's assume valid time for now or we can check hour
              final hour = now.hour;
              final isSafeWindow = hour >= 8 && hour <= 21;

              if (isSafeWindow) {
                await _showNotification(group);
                await db.updateLastNotificationTime(group.id, now);
              }
            }
          }
        }
      }

      return true;
    } catch (e, s) {
      print(e);
      print(s);
      return true;
    }
  });
}

Future<void> _showNotification(TrackGroup group) async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const androidDetails = AndroidNotificationDetails(
    'call_monitor_channel',
    'Call Monitor Reminders',
    channelDescription: 'Reminders for overdue calls',
    importance: Importance.max,
    priority: Priority.high,
    actions: <AndroidNotificationAction>[
      AndroidNotificationAction('CALL_NOW', 'Call Now'),
      AndroidNotificationAction('VIEW_TIMELINE', 'View Timeline'),
    ],
  );
  const details = NotificationDetails(android: androidDetails);

  // Personalized Text
  String body = 'It\'s time to call ${group.name}!';
  if (group.frequency == 0) {
    // Daily
    body = 'Haven\'t spoken today? Give ${group.name} a call! 🌙';
  } else if (group.frequency == 1) {
    // Weekly
    body = 'It\'s been a while! Catch up with ${group.name} this weekend. ❤️';
  }

  await flutterLocalNotificationsPlugin.show(
    group.id,
    'Time to connect with ${group.name}',
    body,
    details,
    payload: group.id.toString(),
  );
}

// QUERY CALL LOG (ALL PARAMS ARE OPTIONAL)

// static Future<Iterable<CallLogEntry>> queryCallLog() async {
//   Iterable<CallLogEntry> entries = await CallLog.query();
//   return entries;
// }
//
// var now = DateTime.now();
// int from = now.subtract(Duration(days: 60)).millisecondsSinceEpoch;
// int to = now.subtract(Duration(days: 30)).millisecondsSinceEpoch;
// Iterable<CallLogEntry> entries = await CallLog.query(
//   dateFrom: from,
//   dateTo: to,
//   durationFrom: 0,
//   durationTo: 60,
//   name: 'John Doe',
//   number: '901700000',
//   type: CallType.incoming,
// );
// } // Removed extra brace
