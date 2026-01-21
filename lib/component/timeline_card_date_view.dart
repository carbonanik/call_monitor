import 'package:call_monitor/component/my_timeline_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimelineCardDateView extends StatelessWidget {
  final DateTime date;
  final TimelineStatus status;

  const TimelineCardDateView({
    super.key,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor;
    switch (status) {
      case TimelineStatus.completed:
        textColor = Colors.black;
        break;
      case TimelineStatus.partial:
        textColor = Colors.amber.shade900;
        break;
      case TimelineStatus.empty:
        textColor = Colors.grey;
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          DateFormat.E().format(date),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        Text(
          date.day.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        Text(
          DateFormat("MMM, yy").format(date),
          style: TextStyle(
            fontSize: 12,
            color: textColor,
          ),
        )
      ],
    );
  }
}
