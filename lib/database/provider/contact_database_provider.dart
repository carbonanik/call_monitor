import 'package:call_monitor/database/contact_database.dart';
import 'package:call_monitor/database/drift_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactDatabaseProvider =
    StateNotifierProvider<ContactDatabase, AsyncValue<List<Contact>>>(
  (ref) => ContactDatabase(),
);

final getDatabaseContactByIdProvider =
    FutureProvider.family<Contact?, int>((ref, id) {
  final contactDatabase =
      ref.read(contactDatabaseProvider.notifier).getDatabaseContactById(id);
  return contactDatabase;
});
