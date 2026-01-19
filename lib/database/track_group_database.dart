import 'package:call_monitor/database/database_manager.dart';
import 'package:call_monitor/database/drift_database.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrackGroupDatabase extends StateNotifier<AsyncValue<List<TrackGroup>>> {
  TrackGroupDatabase() : super(const AsyncData([])) {
    readTrackGroup();
  }

  final db = DatabaseManager.database;

  // ? C R U D -- T R A C K G R O U P

  Future<void> addTrackGroupWithContact(
      TrackGroup trackGroup, List<Contact> contacts) async {
    await db.transaction(() async {
      // Ensure contacts are in the database first
      for (final contact in contacts) {
        await db
            .into(db.contacts)
            .insertOnConflictUpdate(ContactsCompanion.insert(
              contactId: contact.contactId,
              displayName: contact.displayName,
              phoneNumbers: contact.phoneNumbers,
            ));
      }

      // Create the track group
      final trackGroupId =
          await db.into(db.trackGroups).insert(TrackGroupsCompanion.insert(
                name: trackGroup.name,
                frequency: Value(trackGroup.frequency),
              ));

      // Link contacts to the track group
      for (final contact in contacts) {
        // We need the internal ID of the contact. Since we inserted it above,
        // we might need to fetch it if we don't have it.
        // For simplicity, let's assume the contact objects passed in already have IDs
        // OR we fetch them by contactId.
        final dbContact = await (db.select(db.contacts)
              ..where((t) => t.contactId.equals(contact.contactId)))
            .getSingle();

        await db
            .into(db.trackGroupContacts)
            .insert(TrackGroupContactsCompanion.insert(
              trackGroupId: trackGroupId,
              contactId: dbContact.id,
            ));
      }
    });
    readTrackGroup();
  }

  // R E A D -- read saved track group from database
  Future<void> readTrackGroup() async {
    state = const AsyncLoading();
    try {
      final tracks = await db.getAllTrackGroups();
      state = AsyncData(tracks);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<TrackGroup?> getTrackGroupById(int id) async {
    return await (db.select(db.trackGroups)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  // U P D A T E -- add contact to track group
  Future<void> addContactToTrackGroup(
      int trackGroupId, int contactInternalId) async {
    await db.addContactToTrackGroup(trackGroupId, contactInternalId);
    readTrackGroup();
  }

  Future<void> updateFrequency(int trackGroupId, int frequency) async {
    await (db.update(db.trackGroups)..where((t) => t.id.equals(trackGroupId)))
        .write(TrackGroupsCompanion(frequency: Value(frequency)));
    readTrackGroup();
  }
}
