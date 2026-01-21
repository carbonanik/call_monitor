import 'package:call_monitor/database/app_settings_database.dart';
import 'package:call_monitor/pages/track_group_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:workmanager/workmanager.dart';
import 'package:call_monitor/data_source/call_logs/call_logs.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:call_monitor/pages/timeline_view_page.dart';
import 'package:call_monitor/database/database_manager.dart';
import 'package:url_launcher/url_launcher.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize WorkManager
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  await Workmanager()
      .registerPeriodicTask("call_monitor_task", "callMonitorTask",
          initialDelay: const Duration(minutes: 1),
          frequency: const Duration(minutes: 15),
          constraints: Constraints(
            networkType: NetworkType.notRequired,
            requiresBatteryNotLow: true,
          ));

  // Initialize Local Notifications
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: _handleNotificationResponse,
  );

  // Handle Cold Start
  final notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    final response = notificationAppLaunchDetails!.notificationResponse;
    if (response != null) {
      // Small delay to ensure navigator is ready
      Future.delayed(const Duration(milliseconds: 500), () {
        _handleNotificationResponse(response);
      });
    }
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  // initialize settings (Drift is lazy-initialized on first use)
  await AppSettingsDatabase().saveFirstLaunchDate();
  runApp(const ProviderScope(child: MyApp()));
}

void _handleNotificationResponse(NotificationResponse response) async {
  final payload = response.payload;
  if (payload == null) return;
  final trackGroupId = int.tryParse(payload);
  if (trackGroupId == null) return;

  // Ensure navigator is ready
  if (navigatorKey.currentState == null) {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  if (response.actionId == 'CALL_NOW') {
    final db = DatabaseManager.database;
    final contacts = await db.getContactsForTrackGroup(trackGroupId);
    final numbers = contacts.expand((c) => c.phoneNumbers).toList();

    if (numbers.isNotEmpty) {
      if (numbers.length == 1) {
        final url = Uri.parse('tel:${numbers.first}');
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        }
      } else {
        // Multiple numbers, go to view
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (_) => TimelineViewPage(trackGroupId: trackGroupId),
          ),
        );
      }
    }
  } else {
    // Default or VIEW_TIMELINE
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => TimelineViewPage(trackGroupId: trackGroupId),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Call Monitor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TrackGroupList(),
    );
  }
}
