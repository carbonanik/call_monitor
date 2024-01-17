import 'package:call_monitor/database/provider/contact_database_provider.dart';
import 'package:call_monitor/state/model/contact_with_is_selected.dart';
import 'package:call_monitor/state/provider/all_contact_with_is_selected_mix_provider.dart';
import 'package:call_monitor/state/provider/contact_search_text_provider.dart';
import 'package:call_monitor/state/provider/selected_contact_provider.dart';
import 'package:call_monitor/util/contact_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final showSearchBarProvider = StateProvider<bool>((ref) => false);

class SelectContactListPage extends StatefulWidget {
  const SelectContactListPage({super.key});

  @override
  State<SelectContactListPage> createState() => _SelectContactListPageState();
}

class _SelectContactListPageState extends State<SelectContactListPage> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _body(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      actions: [
        Consumer(
          builder: (context, ref, child) {
            final showSearchBar = ref.watch(showSearchBarProvider);
            return IconButton(
              onPressed: () {
                ref.read(showSearchBarProvider.notifier).state = !showSearchBar;
              },
              icon: const Icon(Icons.search),
            );
          },
        )
      ],
      title: _buildAppBarTitle(),
    );
  }

  Widget _buildAppBarTitle() {
    return Consumer(builder: (context, ref, child) {
      final showSearchBar = ref.watch(showSearchBarProvider);
      return showSearchBar
          ? TextField(
              controller: searchController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => _onClearTap(ref),
                  icon: const Icon(Icons.clear),
                ),
              ),
              onChanged: (value) {
                ref.read(contactSearchTextProvider.notifier).state = value;
              },
            )
          : const Text("Select Contact");
    });
  }

  void _onClearTap(WidgetRef ref) {
    searchController.clear();
    ref.read(contactSearchTextProvider.notifier).state = '';
  }

  Widget _body() {
    return SafeArea(
      child: Stack(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final asyncValue = ref.watch(filteredContactWithIsSelectedMixProvider);
              return asyncValue.map(
                data: (callLogData) => _buildSelectList(callLogData, ref),
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
    );
  }

  Widget _buildSelectList(AsyncData<List<ContactWithIsSelected>> callLogData, WidgetRef ref) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final contact = callLogData.value[index].contact;
        final isSelected = callLogData.value[index].isSelected;
        return _buildSelectableContactItem(contact, isSelected, ref);
      },
      itemCount: callLogData.value.length,
    );
  }

  void _onSelectAllPressed(WidgetRef ref) {
    final asyncValue = ref.read(filteredContactWithIsSelectedMixProvider);

    asyncValue.whenData((value) {
      ref.read(selectedContactProvider.notifier).addMultiple(
            value.map((e) => e.contact.toDatabaseModel()).toList(),
          );
    });
  }

  void _onClearPressed(WidgetRef ref) {
    ref.read(selectedContactProvider.notifier).clear();
  }

  void _onSavePressed(WidgetRef ref) {
    /// ? GET ALL CONTACT CURRENTLY SELECTED
    final selectedContact = ref.read(selectedContactProvider);

    /// ? GET ALL CONTACT CURRENTLY IN DATABASE
    final databaseContacts = ref.read(contactDatabaseProvider).valueOrNull;

    /// ? CONTACT THAT IS SELECTED BUT NOT IN DATABASE
    /// we have to save the newly selected to database
    final contactsToAdd = selectedContact
        .where(
          (selected) => !(databaseContacts
                  ?.where(
                    (fromDatabase) => selected.contactId == fromDatabase.contactId,
                  )
                  .isNotEmpty ??
              false),
        )
        .toList();
    print("add -> ${contactsToAdd.map((e) => e.displayName)}");

    /// ? CONTACT THAT IS IN DATABASE BUT NOT SELECTED
    /// we have to remove the deselected from database
    final contactsToRemove = databaseContacts
            ?.where(
              (fromDatabase) => !selectedContact
                  .where(
                    (selected) => fromDatabase.contactId == selected.contactId,
                  )
                  .isNotEmpty,
            )
            .toList() ??
        [];
    print("remove -> ${contactsToRemove.map((e) => e.displayName)}");

    /// ? SAVE TO DATABASE
    if (contactsToAdd.isNotEmpty) {
      ref.read(contactDatabaseProvider.notifier).addMultipleDatabaseContact(contactsToAdd);
    }

    /// ? REMOVE FROM DATABASE
    if (contactsToRemove.isNotEmpty) {
      ref.read(contactDatabaseProvider.notifier).deleteMultipleContact(contactsToRemove.map((e) => e.id).toList());
    }
  }

  void _onContactItemTapped(Contact contact, WidgetRef ref) {
    ref.read(selectedContactProvider.notifier).toggle(contact);
  }

  Widget _buildFunctionButtons() {
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

  Widget _buildSelectableContactItem(Contact contact, bool isSelected, WidgetRef ref) {
    return ListTile(
      title: Text(contact.displayName),
      subtitle: Text(
        contact.phones.firstOrNull?.number ?? 'XXX',
      ),
      leading: isSelected
          ? const Icon(Icons.check_box_rounded, color: Colors.green)
          : const Icon(Icons.check_box_outline_blank),
      onTap: () => _onContactItemTapped(contact, ref),
    );
  }
}
