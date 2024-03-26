import 'package:call_log/call_log.dart';
import 'package:call_monitor/data_source/call_logs/call_logs.dart';
import 'package:call_monitor/database/model/track_group.dart';
import 'package:call_monitor/database/provider/track_group_database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/provider/contact_database_provider.dart';

final callLogsProvider = FutureProvider<List<CallLogEntry>>(
  (ref) async {
    Iterable<CallLogEntry> entries = await CallLogsDataSource().getCallLogs();
    return entries.toList();
  },
);

final callLogsByNumberProvider = FutureProvider.family<List<CallLogEntry>, String>(
  (ref, number) async {
    Iterable<CallLogEntry> entries = await CallLogsDataSource().getCallLogsByNumber(number);
    return entries.toList();
  },
);

final callLogsByIdProvider = FutureProvider.family<List<CallLogEntry>, int>(
  (ref, trackGroupId) async {
    final trackGroup = await ref.read(trackGroupDatabaseProvider.notifier).getTrackGroupById(trackGroupId);
    if (trackGroup == null) {
      return [];
    }
    final numbers = trackGroup.numberList();
    final res = await Future.wait(List.generate(
      numbers.length,
      (index) => CallLogsDataSource().getCallLogsByNumber(numbers[index]),
    ));
    return res.expand((i) => i).toList();
  },
);
