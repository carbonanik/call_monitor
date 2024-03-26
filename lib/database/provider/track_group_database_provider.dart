import 'package:call_monitor/database/contact_database.dart';
import 'package:call_monitor/database/model/contact_database_model.dart';
import 'package:call_monitor/database/model/track_group.dart';
import 'package:call_monitor/database/track_group_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trackGroupDatabaseProvider = StateNotifierProvider<TrackGroupDatabase, AsyncValue<List<TrackGroup>>>(
  (ref) => TrackGroupDatabase(),
);

// final getDatabaseContactByIdProvider = FutureProvider.family<TrackGroup?, int>((ref, id) {
//   final contactDatabase = ref.read(trackGroupDatabaseProvider.notifier).getTrackGroupById(id);
//   return contactDatabase;
// });