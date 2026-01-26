import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/database_provider.dart';
import '../core/theme.dart';

class ManageRemindersScreen extends ConsumerWidget {
  const ManageRemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsAsync = ref.watch(trackedContactsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Reminders')),
      body: contactsAsync.when(
        data: (contacts) => ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return ListTile(
              leading: CircleAvatar(
                  backgroundColor: AppTheme.surfaceColor,
                  child: Text(contact.name[0])),
              title: Text(contact.name),
              subtitle: Text('Reminding every ${contact.frequencyDays} days'),
              trailing: Switch(
                value: contact.remindersEnabled,
                onChanged: (val) {
                  ref.read(databaseProvider).updateTrackedContact(
                        contact.copyWith(remindersEnabled: val),
                      );
                },
                activeThumbColor: AppTheme.primaryColor,
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
