import 'package:call_monitor/database/model/contact_database_model.dart';
import 'package:call_monitor/database/provider/contact_database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedContactNotifier extends StateNotifier<List<ContactDatabaseModel>> {
  final Ref _ref;

  SelectedContactNotifier({required Ref ref})
      : _ref = ref,
        super([]) {
    // final data = _ref.read(contactDatabaseProvider);
    // print(data);
    // if (data is AsyncData) {
    //   addMultiple(data.value ?? []);
    // }
  }

  void addContact(ContactDatabaseModel contact) {
    state = [...state, contact];
  }

  void removeContact(ContactDatabaseModel contact) {
    state = state.where((c) => c != contact).toList();
  }

  void clear() {
    state = [];
  }

  void addMultiple(List<ContactDatabaseModel> contacts) {
    if (contacts.isEmpty) return;
    clear();
    state = contacts;
  }
}
