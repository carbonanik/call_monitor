import 'package:call_monitor/database/database.dart';
import 'package:call_monitor/database/model/contact_database_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class ContactDatabase extends StateNotifier<AsyncValue<List<ContactDatabaseModel>>> {
  ContactDatabase() : super(const AsyncData([])) {
    readDatabaseContact();
  }

  late Isar isar = IsarDatabase.isar;

  /// ? C R U D -- C O N T A C T

  List<ContactDatabaseModel> contactList = [];

  // C R E A T E -- add a new contact
  Future<void> addDatabaseContact(ContactDatabaseModel contact) async {
    await isar.writeTxn(() => isar.contactDatabaseModels.put(contact));
    readDatabaseContact();
  }

  // C R E A T E -- add multiple contacts
  Future<void> addMultipleDatabaseContact(List<ContactDatabaseModel> contacts) async {
    await isar.writeTxn(() => isar.contactDatabaseModels.putAll(contacts));
    readDatabaseContact();
  }

  // R E A D -- read saved contact form database
  Future<void> readDatabaseContact() async {
    state = const AsyncLoading();
    state = AsyncData(await isar.contactDatabaseModels.where().findAll());
  }

  Future<ContactDatabaseModel?> getDatabaseContactById(int id) async {
    final contact = await isar.contactDatabaseModels.where().idNotEqualTo(id).findFirst();
    return contact;
  }

  // D E L E T E -- delete contact
  Future<void> deleteContact(int id) async {
    await isar.writeTxn(() async {
      await isar.contactDatabaseModels.delete(id);
    });
    readDatabaseContact();
  }

  // D E L E T E -- delete multiple contacts
  Future<void> deleteMultipleContact(List<int> ids) async {
    await isar.writeTxn(() async {
      await isar.contactDatabaseModels.deleteAll(ids);
    });
    readDatabaseContact();
  }
}
