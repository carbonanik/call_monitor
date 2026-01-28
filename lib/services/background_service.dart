import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';
import 'package:drift/drift.dart' as drift;
import '../database/database.dart';
import 'call_log_service.dart';
import 'notification_service.dart';
import 'notification_schedule_preferences.dart';

const syncTask = "com.justcall.sync_and_notify";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final db = AppDatabase.instance;
    try {
      // Load custom schedule from preferences
      final morningWindow =
          await NotificationSchedulePreferences.getMorningWindow();
      final daytimeWindow =
          await NotificationSchedulePreferences.getDaytimeWindow();
      final eveningWindow =
          await NotificationSchedulePreferences.getEveningWindow();

      final schedule = NotificationSchedule(
        morning: TimeWindow(
          morningWindow.startHour,
          morningWindow.startMinute,
          morningWindow.endHour,
          morningWindow.endMinute,
        ),
        daytime: TimeWindow(
          daytimeWindow.startHour,
          daytimeWindow.startMinute,
          daytimeWindow.endHour,
          daytimeWindow.endMinute,
        ),
        evening: TimeWindow(
          eveningWindow.startHour,
          eveningWindow.startMinute,
          eveningWindow.endHour,
          eveningWindow.endMinute,
        ),
      );

      final orchestrator = NotificationOrchestrator(
        db: db,
        notificationService: NotificationService(db),
        callLogService: CallLogService(db),
        schedule: schedule,
      );

      await orchestrator.runDailyCheck();
      return Future.value(true);
    } catch (e) {
      debugPrint("Workmanager: Error in background task: $e");
      return Future.value(false);
      // Workmanager: Error in background task: PlatformException(PermissionHandler.PermissionManager, Unable to detect current Android Activity., null, null)
      // This error will be thrown when the app is not in the foreground and the background task is trying to request permissions.
      // If permission already granted, no error will be thrown.
    }
  });
}

class NotificationOrchestrator {
  final AppDatabase db;
  final NotificationService notificationService;
  final CallLogService callLogService;
  final NotificationSchedule schedule;

  final int maxDailyNudges;

  NotificationOrchestrator({
    required this.db,
    required this.notificationService,
    required this.callLogService,
    this.maxDailyNudges = 3,
    this.schedule = const NotificationSchedule(),
  });

  Future<void> runDailyCheck() async {
    await callLogService.syncCallLogs();
    await notificationService.init();

    final now = DateTime.now();
    final stats = await _getTodayStats(now);

    await _handleMorningSummary(now, stats);
    await _handleDaytimeNudge(now, stats);
    await _handleEveningReflection(now, stats);
  }

  Future<NotificationStat> _getTodayStats(DateTime now) async {
    return await db.getStatsForDate(now) ??
        NotificationStat(
          date: DateTime(now.year, now.month, now.day),
          morningSent: false,
          dayNudgesCount: 0,
          eveningSent: false,
        );
  }

  Future<void> _handleMorningSummary(
      DateTime now, NotificationStat stats) async {
    if (stats.morningSent) return;
    if (!schedule.morning.contains(now)) return;

    final overdue = await _getOverdueContacts(now);
    if (overdue.isNotEmpty) {
      await notificationService.showMorningSummary(overdue);
      await _updateStats(stats.date, morningSent: true);
    }
  }

  Future<void> _handleDaytimeNudge(DateTime now, NotificationStat stats) async {
    if (stats.dayNudgesCount >= maxDailyNudges || !stats.morningSent) return;
    if (!schedule.daytime.contains(now)) return;

    if (await db.hasUserMadeCallsToday()) {
      // Mark as done (max out the count) for today to prevent multiple checks
      await _updateStats(stats.date, dayNudgesCount: maxDailyNudges);
      return;
    }

    if (Random().nextBool()) {
      final target = await _pickRandomNudgeTarget(now);
      if (target != null) {
        await notificationService.showDaytimeNudge(target, now);
        await _updateStats(stats.date,
            dayNudgesCount: stats.dayNudgesCount + 1);
      }
    }
  }

  Future<void> _handleEveningReflection(
      DateTime now, NotificationStat stats) async {
    if (stats.eveningSent || !schedule.evening.contains(now)) return;

    final hasCalledToday = await db.hasUserMadeCallsToday();
    await notificationService.showEveningReflection(hasCalledToday);
    await _updateStats(stats.date, eveningSent: true);
  }

  Future<List<TrackedContact>> _getOverdueContacts(DateTime now) async {
    final contacts = await db.getAllTrackedContacts();
    return contacts.where((c) {
      if (!c.remindersEnabled) return false;
      final daysSince =
          c.lastCalled != null ? now.difference(c.lastCalled!).inDays : 999;
      return daysSince >= c.frequencyDays;
    }).toList();
  }

  Future<TrackedContact?> _pickRandomNudgeTarget(DateTime now) async {
    final contacts = await db.getAllTrackedContacts();
    final candidates = contacts.where((c) {
      if (!c.remindersEnabled) return false;
      final daysSince =
          c.lastCalled != null ? now.difference(c.lastCalled!).inDays : 999;
      return daysSince >= c.frequencyDays || daysSince > 3;
    }).toList();

    if (candidates.isEmpty) return null;
    return candidates[Random().nextInt(candidates.length)];
  }

  Future<void> _updateStats(DateTime date,
      {bool? morningSent, int? dayNudgesCount, bool? eveningSent}) async {
    await db.upsertStats(NotificationStatsCompanion(
      date: drift.Value(date),
      morningSent: morningSent != null
          ? drift.Value(morningSent)
          : const drift.Value.absent(),
      dayNudgesCount: dayNudgesCount != null
          ? drift.Value(dayNudgesCount)
          : const drift.Value.absent(),
      eveningSent: eveningSent != null
          ? drift.Value(eveningSent)
          : const drift.Value.absent(),
    ));
  }
}

class TimeWindow {
  final int startHour;
  final int startMinute;
  final int endHour;
  final int endMinute;

  const TimeWindow(
      this.startHour, this.startMinute, this.endHour, this.endMinute);

  bool contains(DateTime time) {
    final start = startHour * 60 + startMinute;
    final end = endHour * 60 + endMinute;
    final currentTime = time.hour * 60 + time.minute;
    return currentTime >= start && currentTime <= end;
  }
}

class NotificationSchedule {
  final TimeWindow morning;
  final TimeWindow daytime;
  final TimeWindow evening;

  const NotificationSchedule({
    this.morning = const TimeWindow(8, 30, 9, 30),
    this.daytime = const TimeWindow(11, 0, 18, 0),
    this.evening = const TimeWindow(20, 0, 21, 0),
  });
}

class BackgroundService {
  static Future<void> init() async {
    await Workmanager().initialize(callbackDispatcher);
    await Workmanager().registerPeriodicTask(
      "1",
      syncTask,
      frequency: const Duration(minutes: 30),
      constraints: Constraints(
        requiresBatteryNotLow: true,
      ),
    );
  }
}
