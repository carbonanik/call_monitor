import 'package:call_monitor/component/day_card.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

enum TimelineStatus { completed, partial, empty }

class MyTimelineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final Widget child;
  final TimelineStatus status;

  const MyTimelineTile({
    this.isFirst = false,
    this.isLast = false,
    required this.child,
    this.status = TimelineStatus.empty,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color mainColor;
    Color backgroundColor;
    IconData iconData;

    switch (status) {
      case TimelineStatus.completed:
        mainColor = Colors.green;
        backgroundColor = Theme.of(context).colorScheme.primaryContainer;
        iconData = Icons.check;
        break;
      case TimelineStatus.partial:
        mainColor = Colors.amber;
        backgroundColor = Colors.amber.shade100;
        iconData = Icons.priority_high;
        break;
      case TimelineStatus.empty:
        mainColor = Colors.grey.shade300;
        backgroundColor = Colors.grey.shade300;
        iconData = Icons.close;
        break;
    }

    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(
        color: mainColor.withOpacity(0.5),
      ),
      indicatorStyle: IndicatorStyle(
        width: 40,
        color: mainColor,
        iconStyle: IconStyle(
          color: Colors.white,
          iconData: iconData,
        ),
      ),
      endChild: DayCard(
        color: backgroundColor,
        child: child,
      ),
    );
  }
}
