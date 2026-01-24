import 'package:workmanager/workmanager.dart';
import '../database/database.dart';
import 'call_log_service.dart';
import 'notification_service.dart';

const syncTask = "com.justcall.sync_and_notify";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Add logging for verification
    print("Workmanager: Starting background task - $task");

    final db = AppDatabase.instance;
    final callLogService = CallLogService(db);
    final notificationService = NotificationService(db);

    try {
      await callLogService.syncCallLogs();
      final contacts = await db.getAllTrackedContacts();
      await notificationService.init();
      await notificationService.checkAndNotify(contacts);
      print("Workmanager: Background task completed successfully");
    } catch (e) {
      print("Workmanager: Error in background task: $e");
    } finally {
      await db.close();
    }

    return Future.value(true);
  });
}

class BackgroundService {
  static Future<void> init() async {
    // Set isInDebugMode to true to see a local notification when the task runs
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    await Workmanager().registerPeriodicTask(
      "1",
      syncTask,
      frequency: const Duration(minutes: 15), // Check every 4 hours
      initialDelay: const Duration(minutes: 1),
      constraints: Constraints(
        requiresBatteryNotLow: true,
      ),
    );
  }
}
