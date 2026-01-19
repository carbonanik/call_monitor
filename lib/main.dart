import 'package:call_monitor/database/app_settings_database.dart';
import 'package:call_monitor/pages/track_group_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:workmanager/workmanager.dart';
import 'package:call_monitor/data_source/call_logs/call_logs.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  // initialize settings (Drift is lazy-initialized on first use)
  await AppSettingsDatabase().saveFirstLaunchDate();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TrackGroupList(),
    );
  }
}
