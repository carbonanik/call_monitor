import 'package:call_monitor/data_source/contatcs/read_contact_data_source.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final readContactProvider = FutureProvider.autoDispose<List<Contact>>((ref) async {
  final contacts = await ReadContactDataSource().readAllContacts();
  return contacts;
});

final getFullContactByIdProvider = FutureProvider.autoDispose.family<Contact?, String>((ref, id) async {
  final contact = await ReadContactDataSource().getFullContact(id);
  return contact;
});
