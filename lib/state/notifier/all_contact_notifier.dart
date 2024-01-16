import 'package:call_monitor/data_source/contatcs/provider/read_contact_provider.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllContactNotifier extends StateNotifier<AsyncValue<List<Contact>>> {
  final Ref _ref;

  AllContactNotifier({required Ref ref})
      : _ref = ref,
        super(const AsyncData([])) {
    // ? INITIALLY LOAD ALL CONTACT
    readAllContacts();
  }

  // ? READ ALL CONTACT FROM DEVICE AS ASYNC_VALUE
  void readAllContacts() async {
    state = const AsyncLoading();
    try {
      final data = await _ref.read(readContactProvider.future);
      state = AsyncData(data);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
