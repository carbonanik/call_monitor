import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'drift_database.g.dart';

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    return (json.decode(fromDb) as List).map((e) => e as String).toList();
  }

  @override
  String toSql(List<String> value) {
    return json.encode(value);
  }
}

class AppSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get firstLaunchDate => dateTime().nullable()();
}

class Contacts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get contactId => text()();
  TextColumn get displayName => text()();
  TextColumn get phoneNumbers => text().map(const StringListConverter())();
}

class TrackGroups extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get frequency => integer().withDefault(const Constant(0))();
}

class Histories extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  IntColumn get duration => integer()();
  IntColumn get continuation => integer()();
}

// Join Table for TrackGroups <-> Contacts (Many-to-Many)
class TrackGroupContacts extends Table {
  IntColumn get trackGroupId =>
      integer().references(TrackGroups, #id, onDelete: KeyAction.cascade)();
  IntColumn get contactId =>
      integer().references(Contacts, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {trackGroupId, contactId};
}

// Join Table for TrackGroups <-> Histories
class TrackGroupHistories extends Table {
  IntColumn get trackGroupId =>
      integer().references(TrackGroups, #id, onDelete: KeyAction.cascade)();
  IntColumn get historyId =>
      integer().references(Histories, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {trackGroupId, historyId};
}

@DriftDatabase(tables: [
  AppSettings,
  Contacts,
  TrackGroups,
  Histories,
  TrackGroupContacts,
  TrackGroupHistories,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Contact operations
  Future<List<Contact>> getAllContacts() => select(contacts).get();
  Future<int> insertContact(ContactsCompanion contact) =>
      into(contacts).insert(contact);
  Future<void> insertMultipleContacts(
      List<ContactsCompanion> contactsList) async {
    await batch((batch) {
      batch.insertAll(contacts, contactsList);
    });
  }

  Future<void> deleteContact(int id) =>
      (delete(contacts)..where((t) => t.id.equals(id))).go();
  Future<void> deleteMultipleContacts(List<int> ids) =>
      (delete(contacts)..where((t) => t.id.isIn(ids))).go();
  Future<Contact?> getContactById(int id) =>
      (select(contacts)..where((t) => t.id.equals(id))).getSingleOrNull();

  // Settings operations
  Future<AppSetting?> getSettings() => select(appSettings).getSingleOrNull();
  Future<int> insertSettings(AppSettingsCompanion settings) =>
      into(appSettings).insert(settings);

  // TrackGroup operations
  Future<List<TrackGroup>> getAllTrackGroups() => select(trackGroups).get();

  Future<int> createTrackGroup(
      TrackGroupsCompanion trackGroup, List<int> contactIds) async {
    return transaction(() async {
      final id = await into(trackGroups).insert(trackGroup);
      for (final contactId in contactIds) {
        await into(trackGroupContacts)
            .insert(TrackGroupContactsCompanion.insert(
          trackGroupId: id,
          contactId: contactId,
        ));
      }
      return id;
    });
  }

  Future<void> addContactToTrackGroup(int trackGroupId, int contactId) {
    return into(trackGroupContacts).insert(TrackGroupContactsCompanion.insert(
      trackGroupId: trackGroupId,
      contactId: contactId,
    ));
  }

  Future<List<Contact>> getContactsForTrackGroup(int trackGroupId) async {
    final query = select(contacts).join([
      innerJoin(trackGroupContacts,
          trackGroupContacts.contactId.equalsExp(contacts.id)),
    ])
      ..where(trackGroupContacts.trackGroupId.equals(trackGroupId));

    final rows = await query.get();
    return rows.map((row) => row.readTable(contacts)).toList();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
