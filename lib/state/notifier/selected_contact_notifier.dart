import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedContactNotifier extends StateNotifier<List<Contact>> {
  SelectedContactNotifier({required Ref ref}) : super([]);

  // ? ADD CONTACT TO SELECTED LIST
  void addContact(Contact contact) {
    state = [...state, contact];
  }

  // ? REMOVE CONTACT FROM SELECTED LIST
  void removeContact(Contact contact) {
    state = state.where((c) => c != contact).toList();
  }

  // ? TOGGLE IF CONTACT IS IN SELECTED LIST
  void toggle(Contact contact) {
    final selectedContact = state.where((element) => element.id == contact.id).firstOrNull;
    if (selectedContact != null) {
      removeContact(selectedContact);
    } else {
      addContact(contact);
    }
  }

  // ? CLEAR ALL SELECTED CONTACT
  void clear() {
    state = [];
  }

  // ? ADD MULTIPLE CONTACT TO SELECTED LIST
  void addMultiple(List<Contact> contacts) {
    if (contacts.isEmpty) return;
    clear();
    state = contacts;
  }
}
