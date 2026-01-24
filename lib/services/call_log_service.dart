import 'package:call_log/call_log.dart';
import 'package:permission_handler/permission_handler.dart';
import '../database/database.dart';
import 'package:drift/drift.dart' as drift;

class CallLogService {
  final AppDatabase db;

  CallLogService(this.db);

  Future<void> syncCallLogs() async {
    // On Android, READ_CALL_LOG is often granted via Permission.phone
    // or specifically Permission.callLog in newer permission_handler versions.
    // Let's check for phone first as it's common.
    var status = await Permission.phone.status;
    if (!status.isGranted) {
      status = await Permission.phone.request();
    }

    // We also need READ_CONTACTS sometimes for normalization,
    // but the manifest already has READ_CALL_LOG.

    if (!status.isGranted) return;

    final contacts = await db.getAllTrackedContacts();
    if (contacts.isEmpty) return;

    // Fetch call logs from the last 90 days for better history
    final now = DateTime.now();
    final fromDate =
        now.subtract(const Duration(days: 90)).millisecondsSinceEpoch;

    final Iterable<CallLogEntry> entries = await CallLog.query(
      dateFrom: fromDate,
      type: CallType.outgoing,
    );

    for (var contact in contacts) {
      final relevantEntries = entries.where((e) {
        if (e.number == null) return false;

        // Normalize numbers: remove all non-digits
        final logNum = e.number!.replaceAll(RegExp(r'\D'), '');
        final contactNum = contact.phoneNumber.replaceAll(RegExp(r'\D'), '');

        if (logNum.isEmpty || contactNum.isEmpty) return false;

        // Match if one contains the other (e.g. log has country code, contact doesn't)
        // Usually matching the last 10 digits is safer for mobile numbers
        if (logNum.length >= 10 && contactNum.length >= 10) {
          return logNum
                  .endsWith(contactNum.substring(contactNum.length - 10)) ||
              contactNum.endsWith(logNum.substring(logNum.length - 10));
        }

        return logNum == contactNum;
      }).toList();

      if (relevantEntries.isNotEmpty) {
        relevantEntries.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
        final latestCall = DateTime.fromMillisecondsSinceEpoch(
            relevantEntries.first.timestamp!);

        if (contact.lastCalled == null ||
            latestCall.isAfter(contact.lastCalled!)) {
          await db.updateTrackedContact(
            contact.copyWith(lastCalled: drift.Value(latestCall)),
          );
        }
      }
    }
  }
}
