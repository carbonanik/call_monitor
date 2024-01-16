import 'package:call_monitor/database/contact_database.dart';
import 'package:call_monitor/pages/contacts_list_page.dart';
import 'package:call_monitor/pages/currently_tracked_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize database
  await ContactDatabase.initialize();
  await ContactDatabase().saveFirstLaunchDate();
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
      home: const ContactListPage(),
    );
  }
}
