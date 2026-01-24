import 'package:call_monitor/components/list_avater.dart';
import 'package:call_monitor/gen/assets.gen.dart';
import 'package:call_monitor/screens/contact_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme.dart';
import '../providers/database_provider.dart';
import '../database/database.dart';
import '../services/call_log_service.dart';
import '../services/notification_service.dart';
import 'settings_screen.dart';
import 'reminders_log_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Trigger sync on startup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncLogs();
    });
  }

  Future<void> _syncLogs() async {
    final db = ref.read(databaseProvider);
    final callLogService = CallLogService(db);
    final notificationService = NotificationService(db);

    // Request notification permission for Android 13+
    await notificationService.requestPermission();

    await callLogService.syncCallLogs();

    // After syncing, check if any notifications should be triggered
    // final contacts = await db.getAllTrackedContacts();
    // await notificationService.checkAndNotify(contacts);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeContent(onSync: _syncLogs),
      const RemindersLogScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.secondaryTextColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active), label: 'Reminders'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class HomeContent extends ConsumerWidget {
  final Future<void> Function() onSync;
  const HomeContent({super.key, required this.onSync});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsAsync = ref.watch(trackedContactsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.images.logoText.image(
              width: 100,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync_rounded),
            onPressed: onSync,
            tooltip: 'Sync Call Logs',
          ),
          IconButton(
            icon: const Icon(Icons.person_add),
            tooltip: 'Add Contact',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => const ContactSelectionScreen()),
              );
            },
          ),
        ],
      ),
      body: contactsAsync.when(
        data: (contacts) {
          if (contacts.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(60.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No one added yet.',
                        style: AppTheme.lightTheme.textTheme.titleLarge),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/select-contacts'),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12)),
                      child: const Text('Add someone you care about'),
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: contacts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 24.0),
                  child: HeaderSection(),
                );
              }
              final contact = contacts[index - 1];
              return ContactListItem(contact: contact);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Stay connected',
            style: AppTheme.lightTheme.textTheme.displayLarge
                ?.copyWith(fontSize: 28)),
        const SizedBox(height: 8),
        Text(
          'Remember to call your loved ones when a week goes by in silence.',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class ContactListItem extends StatelessWidget {
  final TrackedContact contact;

  const ContactListItem({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    final lastCalled = contact.lastCalled;
    final now = DateTime.now();
    int daysSince;

    if (lastCalled == null) {
      daysSince = 999;
    } else {
      // Calculate days difference accurately
      final difference = now.difference(lastCalled);
      daysSince = difference.inDays;
    }

    final isOverdue = daysSince >= contact.frequencyDays;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ListAvatar(displayName: contact.name),
          // CircleAvatar(
          //   radius: 28,
          //   backgroundColor: Colors.white,
          //   child: Text(contact.name[0],
          //       style:
          //           const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          // ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'Last called: ${daysSince == 999 ? "Never" : (daysSince == 0 ? "Today" : (daysSince == 1 ? "Yesterday" : "$daysSince days ago"))}',
                  style: AppTheme.lightTheme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          if (isOverdue)
            const StatusBadge(isTime: true)
          else
            const StatusBadge(isTime: false),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () async {
              final phone = contact.phoneNumber.replaceAll(RegExp(r'\s+'), '');
              final uri = Uri.parse(
                phone.startsWith('+') ? 'tel:$phone' : 'tel:+$phone',
              );

              try {
                await launchUrl(
                  uri,
                  mode: LaunchMode.externalApplication,
                );
              } catch (e) {
                print('Failed to launch dialer: $e');
              }
            },
            icon: const Icon(Icons.call),
          ),
        ],
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final bool isTime;
  const StatusBadge({super.key, required this.isTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isTime
            ? AppTheme.accentColor.withOpacity(0.1)
            : AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isTime ? Icons.warning_amber_rounded : Icons.check_circle_outline,
            size: 14,
            color: isTime ? AppTheme.accentColor : AppTheme.primaryColor,
          ),
          const SizedBox(width: 4),
          Text(
            isTime ? "It's time" : "You're good",
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isTime ? AppTheme.accentColor : AppTheme.primaryColor),
          ),
        ],
      ),
    );
  }
}
