import 'package:call_monitor/component/day_card.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimelineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final Widget child;
  final bool isCompleted;

  const MyTimelineTile({
    this.isFirst = false,
    this.isLast = false,
    required this.child,
    this.isCompleted = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(
        color: isCompleted ? Colors.green.shade300 : Colors.grey.shade300,
      ),
      indicatorStyle: IndicatorStyle(
        width: 40,
        color: isCompleted ? Colors.green : Colors.grey.shade300,
        iconStyle: IconStyle(
          color: Colors.white,
          iconData: isCompleted ? Icons.check : Icons.close,
        ),
      ),
      endChild: DayCard(
        color: isCompleted ? Theme.of(context).colorScheme.primaryContainer : Colors.grey.shade300,
        child: child,
      ),
    );
  }
}
