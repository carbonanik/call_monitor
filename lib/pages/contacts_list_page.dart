import 'package:call_monitor/database/model/contact_database_model.dart';
import 'package:call_monitor/database/provider/contact_database_provider.dart';
import 'package:call_monitor/state/provider/all_contact_with_is_selected_mix_provider.dart';
import 'package:call_monitor/state/provider/contact_search_text_provider.dart';
import 'package:call_monitor/state/provider/selected_contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(builder: (context, ref, child) {
          return TextField(
            controller: searchController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  searchController.clear();
                  ref.read(contactSearchTextProvider.notifier).state = '';
                },
                icon: const Icon(Icons.clear),
              ),
            ),
            onChanged: (value) {
              ref.read(contactSearchTextProvider.notifier).state = value;
            },
          );
        }),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final asyncValue = ref.watch(filteredContactWithIsSelectedMixProvider);
                return asyncValue.map(
                  data: (callLogData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final contact = callLogData.value[index].contact;
                        final isSelected = callLogData.value[index].isSelected;
                        return _buildSelectableContactItem(contact, isSelected, ref);
                      },
                      itemCount: callLogData.value.length,
                    );
                  },
                  error: (error) => const Center(child: Text("ERROR")),
                  loading: (loading) => const Center(child: CircularProgressIndicator()),
                );
              },
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: _buildFunctionButtons(),
            ),
          ],
        ),
      ),
    );
  }

  void _onSelectAllPressed(WidgetRef ref) {
    final asyncValue = ref.read(filteredContactWithIsSelectedMixProvider);

    asyncValue.whenData((value) {
      ref.read(selectedContactProvider.notifier).addMultiple(
            value.map((e) => e.contact).toList(),
          );
    });
  }

  void _onClearPressed(WidgetRef ref) {
    ref.read(selectedContactProvider.notifier).clear();
  }

  void _onSavePressed(WidgetRef ref) {
    final contacts = ref.read(selectedContactProvider);
    ref.read(contactDatabaseProvider.notifier).addMultipleDatabaseContact(contacts);
  }

  void _onContactItemTapped(bool isSelected, ContactDatabaseModel contact, WidgetRef ref) {
    if (isSelected) {
      ref.read(selectedContactProvider.notifier).removeContact(contact);
    } else {
      ref.read(selectedContactProvider.notifier).addContact(contact);
    }
  }

  Consumer _buildFunctionButtons() {
    return Consumer(builder: (context, ref, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _onSelectAllPressed(ref),
            heroTag: "selectAll",
            child: const Icon(Icons.checklist_sharp),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => _onClearPressed(ref),
            heroTag: "clear",
            child: const Icon(Icons.clear_all),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => _onSavePressed(ref),
            heroTag: "save",
            child: const Icon(Icons.save),
          ),
        ],
      );
    });
  }

  ListTile _buildSelectableContactItem(ContactDatabaseModel contact, bool isSelected, WidgetRef ref) {
    return ListTile(
      title: Text(contact.displayName),
      subtitle: Text(
        contact.primaryPhoneNumber,
      ),
      leading: isSelected
          ? const Icon(Icons.check_box_rounded, color: Colors.green)
          : const Icon(Icons.check_box_outline_blank),
      onTap: () => _onContactItemTapped(isSelected, contact, ref),
    );
  }
}
