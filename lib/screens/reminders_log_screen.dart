import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/database_provider.dart';
import '../core/theme.dart';
import 'package:intl/intl.dart';

class RemindersLogScreen extends ConsumerWidget {
  const RemindersLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsAsync = ref.watch(trackedContactsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Care History')),
      body: contactsAsync.when(
        data: (contacts) {
          // Filter contacts who have been notified at least once
          final notifiedContacts =
              contacts.where((c) => c.lastNotified != null).toList();

          if (notifiedContacts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.notifications_none_rounded,
                      size: 64, color: AppTheme.surfaceColor),
                  const SizedBox(height: 16),
                  Text(
                    'No nudges yet.',
                    style: AppTheme.lightTheme.textTheme.titleLarge
                        ?.copyWith(color: AppTheme.secondaryTextColor),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48),
                    child: Text(
                      'When your relationships need a little attention, we’ll gently remind you here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppTheme.secondaryTextColor),
                    ),
                  ),
                ],
              ),
            );
          }

          // Sort by latest notification
          notifiedContacts
              .sort((a, b) => b.lastNotified!.compareTo(a.lastNotified!));

          return ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: notifiedContacts.length,
            itemBuilder: (context, index) {
              final contact = notifiedContacts[index];
              final dateStr =
                  DateFormat('MMM d, h:mm a').format(contact.lastNotified!);

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                      child: const Icon(Icons.notifications_active_rounded,
                          color: AppTheme.primaryColor, size: 20),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reminded you to call ${contact.nickname ?? contact.name}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            dateStr,
                            style: const TextStyle(
                                color: AppTheme.secondaryTextColor,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
