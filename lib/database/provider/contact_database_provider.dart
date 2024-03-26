import 'package:call_monitor/database/contact_database.dart';
import 'package:call_monitor/database/model/contact_database_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactDatabaseProvider = StateNotifierProvider<ContactDatabase, AsyncValue<List<ContactDatabaseModel>>>(
  (ref) => ContactDatabase(),
);

final getDatabaseContactByIdProvider = FutureProvider.family<ContactDatabaseModel?, int>((ref, id) {
  final contactDatabase = ref.read(contactDatabaseProvider.notifier).getDatabaseContactById(id);
  return contactDatabase;
});