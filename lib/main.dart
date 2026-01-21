import 'package:call_monitor/services/background_service.dart';
import 'package:call_monitor/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:call_monitor/pages/track_group_list.dart';
import 'package:call_monitor/database/app_settings_database.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Background Services
  await BackgroundService().init();

  // Initialize Notification Service
  await NotificationService().init(navigatorKey);

  // initialize settings (Drift is lazy-initialized on first use)
  await AppSettingsDatabase().saveFirstLaunchDate();
  runApp(const ProviderScope(child: MyApp()));
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
