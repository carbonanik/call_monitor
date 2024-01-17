import 'package:call_monitor/database/model/contact_database_model.dart';
import 'package:call_monitor/database/provider/contact_database_provider.dart';
import 'package:call_monitor/util/contact_ext.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedContactNotifier extends StateNotifier<List<ContactDatabaseModel>> {
  final Ref _ref;

  SelectedContactNotifier({required Ref ref})
      : _ref = ref,
        super([]) {
    // ? INITIALLY LOAD CONTACT FROM DATABASE
    final data = _ref.read(contactDatabaseProvider);
    if (data is AsyncData) {
      addMultiple(data.value ?? []);
    }
  }

  // ? ADD CONTACT TO SELECTED LIST
  void addContact(ContactDatabaseModel contact) {
    state = [...state, contact];
  }

  // ? REMOVE CONTACT FROM SELECTED LIST
  void removeContact(ContactDatabaseModel contact) {
    state = state.where((c) => c != contact).toList();
  }

  // ? TOGGLE IF CONTACT IS IN SELECTED LIST
  void toggle(Contact contact) {
    final selectedContact = state.where((element) => element.contactId == contact.id).firstOrNull;
    if (selectedContact != null) {
      removeContact(selectedContact);
    } else {
      final contactInDatabase = _ref
          .read(contactDatabaseProvider)
          .whenData((value) => value.where((element) => element.contactId == contact.id).firstOrNull)
          .valueOrNull;
      addContact(contactInDatabase ?? contact.toDatabaseModel());
    }
  }

  // ? CLEAR ALL SELECTED CONTACT
  void clear() {
    state = [];
  }

  // ? ADD MULTIPLE CONTACT TO SELECTED LIST
  void addMultiple(List<ContactDatabaseModel> contacts) {
    if (contacts.isEmpty) return;
    clear();
    state = contacts;
  }
}
