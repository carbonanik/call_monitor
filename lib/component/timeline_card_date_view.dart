import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimelineCardDateView extends StatelessWidget {
  final DateTime date;
  final bool isCompleted;

  const TimelineCardDateView({
    super.key,
    required this.date,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          DateFormat.E().format(date),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isCompleted ? Colors.black : Colors.grey,
          ),
        ),
        Text(
          date.day.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isCompleted ? Colors.black : Colors.grey,
          ),
        ),
        Text(
          DateFormat("MMM, yy").format(date),
          style: TextStyle(
            fontSize: 12,
            color: isCompleted ? Colors.black : Colors.grey,
          ),
        )
      ],
    );
  }
}
