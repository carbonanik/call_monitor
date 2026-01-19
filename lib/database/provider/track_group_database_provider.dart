import 'package:call_monitor/database/drift_database.dart';
import 'package:call_monitor/database/track_group_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trackGroupDatabaseProvider =
    StateNotifierProvider<TrackGroupDatabase, AsyncValue<List<TrackGroup>>>(
  (ref) => TrackGroupDatabase(),
);

// final getDatabaseContactByIdProvider = FutureProvider.family<TrackGroup?, int>((ref, id) {
//   final contactDatabase = ref.read(trackGroupDatabaseProvider.notifier).getTrackGroupById(id);
//   return contactDatabase;
// });
