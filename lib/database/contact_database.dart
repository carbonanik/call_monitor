import 'package:call_monitor/database/database_manager.dart';
import 'package:call_monitor/database/drift_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactDatabase extends StateNotifier<AsyncValue<List<Contact>>> {
  ContactDatabase() : super(const AsyncData([])) {
    readDatabaseContact();
  }

  final db = DatabaseManager.database;

  /// ? C R U D -- C O N T A C T

  // C R E A T E -- add a new contact
  Future<void> addDatabaseContact(Contact contact) async {
    await db.insertContact(ContactsCompanion.insert(
      contactId: contact.contactId,
      displayName: contact.displayName,
      phoneNumbers: contact.phoneNumbers,
    ));
    readDatabaseContact();
  }

  // C R E A T E -- add multiple contacts
  Future<void> addMultipleDatabaseContact(List<Contact> contacts) async {
    await db.insertMultipleContacts(contacts
        .map((c) => ContactsCompanion.insert(
              contactId: c.contactId,
              displayName: c.displayName,
              phoneNumbers: c.phoneNumbers,
            ))
        .toList());
    readDatabaseContact();
  }

  // R E A D -- read saved contact form database
  Future<void> readDatabaseContact() async {
    state = const AsyncLoading();
    try {
      final contactsList = await db.getAllContacts();
      state = AsyncData(contactsList);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<Contact?> getDatabaseContactById(int id) async {
    return await db.getContactById(id);
  }

  // D E L E T E -- delete contact
  Future<void> deleteContact(int id) async {
    await db.deleteContact(id);
    readDatabaseContact();
  }

  // D E L E T E -- delete multiple contacts
  Future<void> deleteMultipleContact(List<int> ids) async {
    await db.deleteMultipleContacts(ids);
    readDatabaseContact();
  }
}
