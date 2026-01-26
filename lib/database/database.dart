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

class NotificationStats extends Table {
  DateTimeColumn get date => dateTime()();
  BoolColumn get morningSent => boolean().withDefault(const Constant(false))();
  IntColumn get dayNudgesCount => integer().withDefault(const Constant(0))();
  BoolColumn get eveningSent => boolean().withDefault(const Constant(false))();
  TextColumn get nudgedContactIds => text().nullable()(); // JSON list of IDs

  @override
  Set<Column> get primaryKey => {date};
}

@DriftDatabase(tables: [TrackedContacts, NotificationStats])
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal() : super(_openConnection());

  static final AppDatabase instance = AppDatabase._internal();

  @override
  int get schemaVersion => 5;

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
        if (from < 4) {
          await m.createTable(notificationStats);
        }
        if (from < 5) {
          await m.addColumn(
              notificationStats, notificationStats.dayNudgesCount);
          // Optional: Migration logic to drop `dayNudgeSent` not strictly supported by drift's `addColumn`,
          // usually we treat it as adding a new column. Deleting columns is harder in sqlite.
          // We can just ignore the old column.
        }
      },
    );
  }

  // CRUD operations for TrackedContacts
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

  // Notification Stats operations
  Future<NotificationStat?> getStatsForDate(DateTime date) {
    final midnight = DateTime(date.year, date.month, date.day);
    return (select(notificationStats)..where((t) => t.date.equals(midnight)))
        .getSingleOrNull();
  }

  Future<void> upsertStats(NotificationStatsCompanion stats) async {
    await into(notificationStats).insertOnConflictUpdate(stats);
  }

  Future<bool> hasUserMadeCallsToday() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final query = select(trackedContacts)
      ..where((t) => t.lastCalled.isBiggerOrEqualValue(today));
    final results = await query.get();
    return results.isNotEmpty;
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
