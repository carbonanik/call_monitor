import 'package:call_monitor/database/model/contact_database_model.dart';
import 'package:call_monitor/database/model/track_group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import 'database.dart';

class TrackGroupDatabase extends StateNotifier<AsyncValue<List<TrackGroup>>> {
  TrackGroupDatabase() : super(const AsyncData([])) {
    readTrackGroup();
  }

  final Isar isar = IsarDatabase.isar;

  // ? C R U D -- T R A C K G R O U P

  // C R E A T E -- add a new track group
  // Future<void> addTrackGroup(TrackGroup trackGroup) async {
  //   await isar.writeTxn(() => isar.trackGroups.put(trackGroup));
  //   readTrackGroup();
  // }

  Future<void> addTrackGroupWithContact(TrackGroup trackGroup, List<ContactDatabaseModel> contacts) async {
    trackGroup.contacts.addAll(contacts);
    // contacts.map((e) {
    //   isar.contactDatabaseModels.where().contactIdEqualTo(e.contactId).findFirst();
    // });
    print(trackGroup.contacts.length);
    await isar.writeTxn(() async {
      await isar.contactDatabaseModels.putAll(contacts);
      await isar.trackGroups.put(trackGroup);
      trackGroup.contacts.save();
      readTrackGroup();
    });
    readTrackGroup();
  }

  // R E A D -- read saved track group from database
  Future<void> readTrackGroup() async {
    state = const AsyncLoading();
    final tracks = await isar.trackGroups.where().findAll();
    state = AsyncData(tracks);
  }

  Future<TrackGroup?> getTrackGroupById(int id) async {
    final contact = await isar.trackGroups.where().idEqualTo(id).findFirst();
    return contact;
  }

  // U P D A T E -- add contact to track group
  Future<void> addContactToTrackGroup(TrackGroup trackGroup, ContactDatabaseModel contact) async {
    trackGroup.contacts.add(contact);
    await isar.writeTxn(() => isar.trackGroups.put(trackGroup));
  }
}
