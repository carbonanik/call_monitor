import 'package:flutter/material.dart';

class DayCard extends StatelessWidget {

  final Widget child;
  final Color color;
  const DayCard({
    required this.child,
    this.color = Colors.white,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
