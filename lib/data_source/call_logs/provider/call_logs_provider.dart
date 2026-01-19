import 'package:call_log/call_log.dart';
import 'package:call_monitor/data_source/call_logs/call_logs.dart';
import 'package:call_monitor/database/provider/track_group_database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final callLogsProvider = FutureProvider<List<CallLogEntry>>(
  (ref) async {
    final entries = await CallLogsDataSource().getCallLogs();
    return entries.toList();
  },
);

final callLogsByNumberProvider =
    FutureProvider.family<List<CallLogEntry>, String>(
  (ref, number) async {
    final entries = await CallLogsDataSource().getCallLogsByNumber(number);
    return entries.toList();
  },
);

final callLogsByTrackGroupIdProvider =
    FutureProvider.family<List<CallLogEntry>, int>(
  (ref, trackGroupId) async {
    final notifier = ref.read(trackGroupDatabaseProvider.notifier);
    final trackGroup = await notifier.getTrackGroupById(trackGroupId);
    if (trackGroup == null) {
      return [];
    }

    final contacts = await notifier.db.getContactsForTrackGroup(trackGroupId);
    final numbers = contacts.expand((c) => c.phoneNumbers).toList();

    final res = await Future.wait(numbers.map(
      (number) => CallLogsDataSource().getCallLogsByNumber(number),
    ));
    return res.expand((i) => i).toList();
  },
);
