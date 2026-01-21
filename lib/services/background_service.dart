import 'package:call_log/call_log.dart';
import 'package:call_monitor/component/communication_status.dart';
import 'package:call_monitor/database/database_manager.dart';
import 'package:call_monitor/services/notification_service.dart';
import 'package:call_monitor/util/monitor_service.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundService {
  static final BackgroundService _instance = BackgroundService._internal();
  factory BackgroundService() => _instance;
  BackgroundService._internal();

  Future<void> init() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    await Workmanager().registerPeriodicTask(
      "call_monitor_task",
      "callMonitorTask",
      initialDelay: const Duration(minutes: 1),
      frequency: const Duration(minutes: 15),
      constraints: Constraints(
        networkType: NetworkType.notRequired,
        requiresBatteryNotLow: true,
      ),
    );
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((dynamic task, dynamic inputData) async {
    print('Background Services are Working!');
    try {
      final db = DatabaseManager.database;
      final groups = await db.getAllTrackGroups();
      int notificationsSent = 0;

      for (final group in groups) {
        if (notificationsSent >= 1) break;

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

            final startOfToday = DateTime(now.year, now.month, now.day);
            final alreadyNotifiedToday =
                lastTime != null && lastTime.isAfter(startOfToday);

            if (!alreadyNotifiedToday) {
              final hour = now.hour;
              final isSafeWindow = hour >= 8 && hour <= 21;

              if (isSafeWindow) {
                await NotificationService().showNotification(group);
                await db.updateLastNotificationTime(group.id, now);
                notificationsSent++;
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
