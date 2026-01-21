import 'package:call_log/call_log.dart';

class CallLogsDataSource {
  Future<List<CallLogEntry>> getCallLogs() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    return entries.toList();
  }

  Future<List<CallLogEntry>> getCallLogsByNumber(String number) async {
    final to = DateTime.now();
    final from = to.subtract(const Duration(days: 30));
    Iterable<CallLogEntry> entries = await CallLog.query(
      dateFrom: from.millisecondsSinceEpoch,
      dateTo: to.millisecondsSinceEpoch,
      number: number,
    );
    return entries.toList();
  }

  Future<List<CallLogEntry>> getCallLogsByNumbers(List<String> numbers) async {
    final to = DateTime.now();
    final from = to.subtract(const Duration(days: 30));
    List<CallLogEntry> entries = [];
    for (var number in numbers) {
      final logs = await CallLog.query(
        dateFrom: from.millisecondsSinceEpoch,
        dateTo: to.millisecondsSinceEpoch,
        number: number,
      );
      entries.addAll(logs);
    }
    return entries;
  }
}
