import 'package:call_monitor/components/gradient_button.dart';
import 'package:call_monitor/components/gradient_avater.dart';
import 'package:call_monitor/gen/assets.gen.dart';
import 'package:call_monitor/screens/contact_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme.dart';
import '../providers/database_provider.dart';
import '../database/database.dart';
import 'package:call_monitor/services/notification_service.dart';
import 'package:drift/drift.dart' as drift;
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
    final notificationService = NotificationService(db);

    // Request notification permission for Android 13+
    await notificationService.requestPermission();

    ref.invalidate(trackedContactsStreamProvider);
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
            Assets.images.logoTextAlpha.image(
              width: 100,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync_rounded),
            onPressed: onSync,
            tooltip: 'Refresh',
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
                    GradientButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/select-contacts'),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      isFullWidth: false,
                      text: 'Add someone you care about',
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

class ContactListItem extends ConsumerStatefulWidget {
  final TrackedContact contact;

  const ContactListItem({super.key, required this.contact});

  @override
  ConsumerState<ContactListItem> createState() => _ContactListItemState();
}

class _ContactListItemState extends ConsumerState<ContactListItem> {
  final List<Map<String, dynamic>> _frequencyOptions = [
    {'label': 'Everyday', 'days': 1},
    {'label': 'Every 3 days', 'days': 3},
    {'label': 'Weekly', 'days': 7},
    {'label': 'Every 2 weeks', 'days': 14},
    {'label': 'Monthly', 'days': 30},
  ];

  void _showEditModal(BuildContext context) {
    final contact = widget.contact;
    final nicknameController = TextEditingController(text: contact.nickname);
    int selectedFrequency = contact.frequencyDays;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Edit contact',
                      style: AppTheme.lightTheme.textTheme.titleLarge),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nicknameController,
                decoration: InputDecoration(
                  labelText: 'Nickname',
                  hintText: 'e.g. Mom, Bestie...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text('Reminder Frequency',
                  style: AppTheme.lightTheme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _frequencyOptions.map((opt) {
                  final isSelected = selectedFrequency == opt['days'];
                  return ChoiceChip(
                    label: Text(opt['label']),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setModalState(() => selectedFrequency = opt['days']);
                      }
                    },
                    selectedColor: AppTheme.primaryColor.withValues(alpha: 0.2),
                    checkmarkColor: AppTheme.primaryColor,
                    labelStyle: TextStyle(
                      color:
                          isSelected ? AppTheme.primaryColor : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () async {
                        final confirmed = await _confirmDelete(context);
                        if (confirmed == true && mounted) {
                          Navigator.pop(context); // Close modal
                          final db = ref.read(databaseProvider);
                          await db.deleteTrackedContact(contact.id);
                        }
                      },
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Remove'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: GradientButton(
                      text: 'Save changes',
                      onPressed: () async {
                        final db = ref.read(databaseProvider);
                        await db.updateTrackedContact(
                          contact.copyWith(
                            nickname:
                                drift.Value(nicknameController.text.trim()),
                            frequencyDays: selectedFrequency,
                          ),
                        );
                        if (mounted) Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Contact?'),
        content: Text(
            'Are you sure you want to stop tracking calls for ${widget.contact.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final contact = widget.contact;
    final displayName =
        (contact.nickname != null && contact.nickname!.isNotEmpty)
            ? contact.nickname!
            : contact.name;
    final lastCalled = contact.lastCalled;
    final now = DateTime.now();
    int daysSince;

    if (lastCalled == null) {
      daysSince = 999;
    } else {
      final difference = now.difference(lastCalled);
      daysSince = difference.inDays;
    }

    final isOverdue = daysSince >= contact.frequencyDays;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // color: AppTheme.surfaceColor,
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: isOverdue
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.black.withValues(alpha: 0.08)),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.accentColor.withValues(alpha: 0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      )
                    : BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.black.withValues(alpha: 0.08)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                child: GradientAvatar(displayName: displayName),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    if (contact.nickname != null &&
                        contact.nickname!.isNotEmpty)
                      Text(
                        contact.name,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.secondaryTextColor
                              .withValues(alpha: 0.8),
                        ),
                      ),
                    Text(
                      'Last called: ${daysSince == 999 ? "Never" : (daysSince == 0 ? "Today" : (daysSince == 1 ? "Yesterday" : "$daysSince days ago"))}',
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              StatusBadge(isTime: isOverdue),
              IconButton(
                onPressed: () => _showEditModal(context),
                icon: const Icon(Icons.more_vert, size: 20),
                color: AppTheme.secondaryTextColor,
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: IconButton.filledTonal(
                  style: IconButton.styleFrom(
                    backgroundColor:
                        AppTheme.primaryColor.withValues(alpha: 0.1),
                    foregroundColor: AppTheme.primaryColor,
                  ),
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Already Talked?'),
                        content: Text('Did you call ${contact.name} today?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Mark called'),
                          ),
                        ],
                      ),
                    );

                    if (confirmed == true) {
                      final db = ref.read(databaseProvider);
                      await db.updateTrackedContact(
                        contact.copyWith(
                            lastCalled: drift.Value(DateTime.now())),
                      );
                    }
                  },
                  icon: const Row(
                    children: [
                      Icon(Icons.check_rounded),
                      SizedBox(width: 8),
                      Text(
                        'Already Talked',
                        style: TextStyle(color: AppTheme.primaryColor),
                      ),
                    ],
                  ),
                  tooltip: 'Already Talked',
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: IconButton.filled(
                  onPressed: () async {
                    final phone =
                        contact.phoneNumber.replaceAll(RegExp(r'\s+'), '');
                    final uri = Uri.parse(
                      phone.startsWith('+') ? 'tel:$phone' : 'tel:+$phone',
                    );

                    try {
                      // Launch dialer
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );

                      // Mark as called immediately (manual tracking approach)
                      final db = ref.read(databaseProvider);
                      await db.updateTrackedContact(
                        contact.copyWith(
                            lastCalled: drift.Value(DateTime.now())),
                      );
                    } catch (e) {
                      print('Failed to launch dialer: $e');
                    }
                  },
                  icon: const Row(
                    children: [
                      SizedBox(width: 8),
                      Icon(Icons.call),
                      SizedBox(width: 8),
                      Text(
                        'Call',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  tooltip: 'Call',
                ),
              ),
              // Expanded(
              //   child: OutlinedButton.icon(
              //     onPressed: () async {
              //       final confirmed = await showDialog<bool>(
              //         context: context,
              //         builder: (context) => AlertDialog(
              //           title: const Text('Confirm Interaction'),
              //           content: Text(
              //               'Are you sure you want to mark your interaction with $displayName as done?'),
              //           actions: [
              //             TextButton(
              //               onPressed: () => Navigator.of(context).pop(false),
              //               child: const Text('Cancel'),
              //             ),
              //             TextButton(
              //               onPressed: () => Navigator.of(context).pop(true),
              //               child: const Text('Confirm'),
              //             ),
              //           ],
              //         ),
              //       );

              //       if (confirmed == true) {
              //         final db = ref.read(databaseProvider);
              //         await db.updateTrackedContact(
              //           contact.copyWith(
              //               lastCalled: drift.Value(DateTime.now())),
              //         );
              //       }
              //     },
              //     icon: const Icon(Icons.done_all, size: 18),
              //     label: const Text('Mark called'),
              //     style: OutlinedButton.styleFrom(
              //       foregroundColor: AppTheme.primaryColor,
              //       side: const BorderSide(color: AppTheme.primaryColor),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(width: 12),
              // Expanded(
              //   child: ElevatedButton.icon(
              //     onPressed: () async {
              //       final phone =
              //           contact.phoneNumber.replaceAll(RegExp(r'\D'), '');
              //       final uri = Uri.parse('tel:$phone');

              //       try {
              //         await launchUrl(
              //           uri,
              //           mode: LaunchMode.externalApplication,
              //         );
              //       } catch (e) {
              //         debugPrint('Failed to launch dialer: $e');
              //       }
              //     },
              //     icon: const Icon(Icons.call, size: 18),
              //     label: const Text('Call now'),
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: AppTheme.primaryColor,
              //       foregroundColor: Colors.white,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //     ),
              //   ),
              // ),
            ],
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
            ? AppTheme.accentColor.withValues(alpha: 0.1)
            : AppTheme.primaryColor.withValues(alpha: 0.1),
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
