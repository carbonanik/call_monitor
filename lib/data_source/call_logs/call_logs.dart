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

// void callbackDispatcher() {
//   Workmanager().executeTask((dynamic task, dynamic inputData) async {
//     print('Background Services are Working!');
//     try {
//       final Iterable<CallLogEntry> cLog = await CallLog.get();
//       print('Queried call log entries');
//       for (CallLogEntry entry in cLog) {
//         print('-------------------------------------');
//         print('F. NUMBER  : ${entry.formattedNumber}');
//         print('C.M. NUMBER: ${entry.cachedMatchedNumber}');
//         print('NUMBER     : ${entry.number}');
//         print('NAME       : ${entry.name}');
//         print('TYPE       : ${entry.callType}');
//         print('DATE       : ${DateTime.fromMillisecondsSinceEpoch(entry.timestamp ?? 0)}');
//         print('DURATION   : ${entry.duration}');
//         print('ACCOUNT ID : ${entry.phoneAccountId}');
//         print('ACCOUNT ID : ${entry.phoneAccountId}');
//         print('SIM NAME   : ${entry.simDisplayName}');
//         print('-------------------------------------');
//       }
//       return true;
//     } on PlatformException catch (e, s) {
//       print(e);
//       print(s);
//       return true;
//     }
//   });
// }

// QUERY CALL LOG (ALL PARAMS ARE OPTIONAL)

// static Future<Iterable<CallLogEntry>> queryCallLog() async {
//   Iterable<CallLogEntry> entries = await CallLog.query();
//   return entries;
// }
//
// var now = DateTime.now();
// int from = now.subtract(Duration(days: 60)).millisecondsSinceEpoch;
// int to = now.subtract(Duration(days: 30)).millisecondsSinceEpoch;
// Iterable<CallLogEntry> entries = await CallLog.query(
//   dateFrom: from,
//   dateTo: to,
//   durationFrom: 0,
//   durationTo: 60,
//   name: 'John Doe',
//   number: '901700000',
//   type: CallType.incoming,
// );
}
