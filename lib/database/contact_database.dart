import 'package:call_monitor/database/model/app_settings.dart';
import 'package:call_monitor/database/model/contact_database_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class ContactDatabase extends StateNotifier<AsyncValue<List<ContactDatabaseModel>>> {

  ContactDatabase() : super(const AsyncData([])){
    readDatabaseContact();
  }

  static late Isar isar;

  /// ? S E T U P

  // I N I T I A L I Z E -- D A T A B A S E
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [ContactDatabaseModelSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

  // save first date of the app startup
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  // get first date of app startup
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

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

  //U P D A T E -- edit contact
  //Future<void> updateContact(int id, DatabaseContact contact) async {
  //  await isar.writeTxn(() async {
  //    await isar.databaseContacts.put(contact);
  //  });
  //  readDatabaseContact();
  //}
}
