import 'package:call_monitor/data_source/contatcs/provider/read_contact_provider.dart';
import 'package:call_monitor/database/model/contact_database_model.dart';
import 'package:call_monitor/util/contact_ext.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllContactNotifier extends StateNotifier<AsyncValue<List<ContactDatabaseModel>>> {
  final Ref _ref;

  AllContactNotifier({required Ref ref})
      : _ref = ref,
        super(const AsyncData([])) {
    readAllContacts();
  }

  void readAllContacts() async {
    state = const AsyncLoading();
    try {
      final data = await _ref.read(readContactProvider.future);
      state = AsyncData(data.map((e) => e.toDatabaseModel()).toList());
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
