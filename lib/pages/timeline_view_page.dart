import 'package:call_log/call_log.dart';
import 'package:call_monitor/component/my_timeline_tile.dart';
import 'package:call_monitor/component/timeline_card_date_view.dart';
import 'package:call_monitor/component/timeline_card_duration_view.dart';
import 'package:call_monitor/data_source/call_logs/provider/call_logs_provider.dart';
import 'package:call_monitor/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svg_flutter/svg.dart';

class TimelineViewPage extends StatelessWidget {
  final int trackGroupId;

  const TimelineViewPage({required this.trackGroupId, super.key});

  void handleClick(String value, BuildContext context) {
    switch (value) {
      case 'Set frequency':
        setFrequency(context);
        break;
    }
  }

  void setFrequency(BuildContext context) async {
    final frequencyController = TextEditingController();
    final String? frequency = await showDialog<String>(
      context: context,
      builder: (context) {
        return  setFrequencyDialog(frequencyController, context);
      },
    );

    if (frequency != null) {

    }
  }

  AlertDialog setFrequencyDialog(TextEditingController frequencyController, BuildContext context) {
    return AlertDialog(
        title: const Text('Set frequency in days'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: 'Frequency',
          ),
          controller: frequencyController,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, frequencyController.text);
            },
            child: const Text('Save'),
          )
        ]
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calender Activity'),
        actions: [
          _buildMenuOptions(context),
        ],
      ),
      body: Consumer(builder: (context, ref, child) {
        final logsAsyncValue = ref.watch(callLogsByIdProvider(trackGroupId));

        return logsAsyncValue.maybeWhen(data: (logs) {
          /// ? get oldest log
          final oldestDate = DateTime.fromMillisecondsSinceEpoch(logs.lastOrNull?.timestamp ?? 0);
          final today = DateTime.now();

          /// ? generate list of days from oldest to today
          final List<DateTime> listDays = logs.lastOrNull != null
              ? List.generate(
                  today.difference(oldestDate).inDays + 1,
                  (index) => today.subtract(Duration(days: index)),
                )
              : [];

          return listDays.isNotEmpty
              ? ListView.builder(
                  reverse: true,
                  itemCount: listDays.length,
                  itemBuilder: (context, index) {
                    /// ? filter logs by date
                    /// ? gets all logs for the day ${listDays[index]}
                    final logInSameDay = logs.where((element) {
                      final logDate = DateTime.fromMillisecondsSinceEpoch(element.timestamp ?? 0);
                      return isSameDay(logDate, listDays[index]);
                    }).toList();

                    /// ? calculate duration
                    final duration = _calculateDuration(logInSameDay);

                    final isCompleted = duration.inSeconds > 0;

                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: MyTimelineTile(
                        isLast: index == 0,
                        isFirst: index == listDays.length - 1,
                        isCompleted: isCompleted,
                        child: _buildCardDetails(listDays, index, isCompleted, duration),
                      ),
                    );
                  },
                )
              : Center(
                  child: SvgPicture.asset(
                    Assets.images.pulseAlert,
                    width: 200,
                    height: 200,
                    colorFilter: ColorFilter.mode(Colors.grey.shade400, BlendMode.srcIn),
                  ),
                );
        }, orElse: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
      }),
    );
  }

  PopupMenuButton<String> _buildMenuOptions(BuildContext context) {
    return PopupMenuButton<String>(
          onSelected:(value) =>  handleClick(value, context),
          itemBuilder: (BuildContext context) {
            return {
              'Set frequency',
            }.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        );
  }

  Widget _buildCardDetails(List<DateTime> listDays, int index, bool isCompleted, Duration duration) {
    return Row(
      children: [
        TimelineCardDateView(date: listDays[index], isCompleted: isCompleted),
        const Spacer(),
        isCompleted
            ? TimelineCardDurationView(
                duration: duration,
              )
            : Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Icon(
                  Icons.sentiment_dissatisfied,
                  size: 60,
                  color: Colors.grey.shade400,
                ),
              ),
      ],
    );
  }
}

Duration _calculateDuration(List<CallLogEntry> logs) {
  return Duration(
    seconds: logs.map((e) => e.duration ?? 0).fold(
          0,
          (previousValue, element) => previousValue + element,
        ),
  );
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.day == date2.day && date1.month == date2.month && date1.year == date2.year;
}

Icon iconFromCallType(CallType callType) {
  switch (callType) {
    case CallType.incoming:
      return const Icon(
        Icons.call_received,
        size: 14,
      );
    case CallType.outgoing:
      return const Icon(
        Icons.call_made,
        size: 14,
      );
    case CallType.missed:
      return const Icon(
        Icons.call_missed,
        size: 14,
      );
    case CallType.rejected:
      return const Icon(
        Icons.close,
        size: 14,
      );
    default:
      return const Icon(
        Icons.call,
        size: 14,
      );
  }
}
