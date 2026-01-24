import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class TrackedContacts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phoneNumber => text().unique()();
  TextColumn get nickname => text().nullable()();
  IntColumn get frequencyDays => integer().withDefault(const Constant(7))();
  DateTimeColumn get lastCalled => dateTime().nullable()();
  BoolColumn get remindersEnabled =>
      boolean().withDefault(const Constant(true))();
  DateTimeColumn get lastNotified => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [TrackedContacts])
class AppDatabase extends _$AppDatabase {
  // AppDatabase() : super(_openConnection());

  AppDatabase._internal() : super(_openConnection());

  static final AppDatabase instance = AppDatabase._internal();

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          await m.deleteTable('tracked_contacts');
          await m.createTable(trackedContacts);
        }
        if (from < 3) {
          await m.addColumn(trackedContacts, trackedContacts.lastNotified);
        }
      },
    );
  }

  // CRUD operations
  Future<List<TrackedContact>> getAllTrackedContacts() =>
      select(trackedContacts).get();
  Stream<List<TrackedContact>> watchAllTrackedContacts() =>
      select(trackedContacts).watch();
  Future<int> addTrackedContact(TrackedContactsCompanion contact) =>
      into(trackedContacts).insert(contact, mode: InsertMode.insertOrReplace);
  Future<bool> updateTrackedContact(TrackedContact contact) =>
      update(trackedContacts).replace(contact);
  Future<int> deleteTrackedContact(int id) =>
      (delete(trackedContacts)..where((t) => t.id.equals(id))).go();

  Future<void> resetLastNotified(int contactId) {
    return (update(trackedContacts)..where((t) => t.id.equals(contactId)))
        .write(const TrackedContactsCompanion(lastNotified: Value.absent()));
  }

  Future<void> deleteAllData() => delete(trackedContacts).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'just_call.sqlite'));
    return NativeDatabase(file);
  });
}
