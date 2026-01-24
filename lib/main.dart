import 'package:call_monitor/screens/about_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/contact_selection_screen.dart';
import 'screens/manage_reminders_screen.dart';
import 'services/background_service.dart';
import 'services/notification_service.dart';
import 'database/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize background services
  await BackgroundService.init();

  // Initialize notification service for actions
  await NotificationService(AppDatabase.instance).init();

  runApp(
    const ProviderScope(
      child: JustCallApp(),
    ),
  );
}

class JustCallApp extends StatelessWidget {
  const JustCallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Just Call',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/home': (context) => const HomeScreen(),
        '/select-contacts': (context) => const ContactSelectionScreen(),
        '/manage-reminders': (context) => const ManageRemindersScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
