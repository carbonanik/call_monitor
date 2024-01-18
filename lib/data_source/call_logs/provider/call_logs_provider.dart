import 'package:call_log/call_log.dart';
import 'package:call_monitor/data_source/call_logs/call_logs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
