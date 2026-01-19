import 'package:call_log/call_log.dart';
import 'package:call_monitor/component/communication_status.dart';
import 'package:call_monitor/component/frequency.dart';
import 'package:call_monitor/database/drift_database.dart';

class MonitorService {
  /// Checks the communication status for a given [TrackGroup] based on [logs].
  ///
  /// [logs] should be a list of call logs relevant to the contacts in the group.
  static CommunicationStatus checkStatus(
      TrackGroup group, List<CallLogEntry> logs) {
    if (logs.isEmpty) {
      return CommunicationStatus.overdue;
    }

    // Sort logs by timestamp descending to get the latest call
    logs.sort((a, b) => (b.timestamp ?? 0).compareTo(a.timestamp ?? 0));
    final lastCallTime =
        DateTime.fromMillisecondsSinceEpoch(logs.first.timestamp ?? 0);

    final frequency = MonitoringFrequency.fromInt(group.frequency);
    final now = DateTime.now();
    final difference = now.difference(lastCallTime);

    // Warning threshold: 80% of the frequency duration
    final warningThreshold =
        Duration(hours: (frequency.days * 24 * 0.8).round());
    final overdueThreshold = Duration(days: frequency.days);

    if (difference > overdueThreshold) {
      return CommunicationStatus.overdue;
    } else if (difference > warningThreshold) {
      return CommunicationStatus.warning;
    } else {
      return CommunicationStatus.good;
    }
  }
}
