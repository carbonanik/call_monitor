import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';
import 'package:drift/drift.dart' as drift;
import '../database/database.dart';
import 'call_log_service.dart';
import 'notification_service.dart';

const syncTask = "com.justcall.sync_and_notify";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final db = AppDatabase.instance;
    try {
      final orchestrator = NotificationOrchestrator(
        db: db,
        notificationService: NotificationService(db),
        callLogService: CallLogService(db),
      );

      await orchestrator.runDailyCheck();
      return Future.value(true);
    } catch (e) {
      debugPrint("Workmanager: Error in background task: $e");
      return Future.value(false);
    }
  });
}

class NotificationOrchestrator {
  final AppDatabase db;
  final NotificationService notificationService;
  final CallLogService callLogService;

  NotificationOrchestrator({
    required this.db,
    required this.notificationService,
    required this.callLogService,
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
          dayNudgeSent: false,
          eveningSent: false,
        );
  }

  Future<void> _handleMorningSummary(
      DateTime now, NotificationStat stats) async {
    if (stats.morningSent) return;
    if (!_isInWindow(now, 8, 30, 9, 30)) return;

    final overdue = await _getOverdueContacts(now);
    if (overdue.isNotEmpty) {
      await notificationService.showMorningSummary(overdue);
      await _updateStats(stats.date, morningSent: true);
    }
  }

  Future<void> _handleDaytimeNudge(DateTime now, NotificationStat stats) async {
    if (stats.dayNudgeSent || !stats.morningSent) return;
    if (!_isInWindow(now, 11, 0, 18, 0)) return;

    if (await db.hasUserMadeCallsToday()) {
      // Mark as done for today anyway to prevent multiple checks
      await _updateStats(stats.date, dayNudgeSent: true);
      return;
    }

    if (Random().nextBool()) {
      final target = await _pickRandomNudgeTarget(now);
      if (target != null) {
        await notificationService.showDaytimeNudge(target);
      }
    }
    await _updateStats(stats.date, dayNudgeSent: true);
  }

  Future<void> _handleEveningReflection(
      DateTime now, NotificationStat stats) async {
    if (stats.eveningSent || !_isInWindow(now, 20, 0, 21, 0)) return;

    final hasCalledToday = await db.hasUserMadeCallsToday();
    await notificationService.showEveningReflection(hasCalledToday);
    await _updateStats(stats.date, eveningSent: true);
  }

  bool _isInWindow(DateTime now, int startH, int startM, int endH, int endM) {
    final start = startH * 60 + startM;
    final end = endH * 60 + endM;
    final currentTime = now.hour * 60 + now.minute;
    return currentTime >= start && currentTime <= end;
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
      {bool? morningSent, bool? dayNudgeSent, bool? eveningSent}) async {
    await db.upsertStats(NotificationStatsCompanion(
      date: drift.Value(date),
      morningSent: morningSent != null
          ? drift.Value(morningSent)
          : const drift.Value.absent(),
      dayNudgeSent: dayNudgeSent != null
          ? drift.Value(dayNudgeSent)
          : const drift.Value.absent(),
      eveningSent: eveningSent != null
          ? drift.Value(eveningSent)
          : const drift.Value.absent(),
    ));
  }
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
