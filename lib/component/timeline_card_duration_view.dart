import 'package:flutter/material.dart';

class TimelineCardDurationView extends StatelessWidget {
  final Duration duration;

  const TimelineCardDurationView({
    super.key,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    // final duration = _calculateDuration(logs);
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
        ),
        children: [
          if (duration.inHours != 0)
            TextSpan(
              children: [
                _buildNumber("${duration.inHours}"),
                _buildLabel(" h  "),
              ],
            ),
          if (duration.inMinutes != 0)
            TextSpan(
              children: [
                _buildNumber("${duration.inMinutes % 60}"),
                _buildLabel(" m  "),
              ],
            ),
          if (duration.inSeconds != 0)
            TextSpan(
              children: [
                _buildNumber("${duration.inSeconds % 60}"),
                _buildLabel(" s"),
              ],
            ),
        ],
      ),
    );
  }

  TextSpan _buildNumber(String number) {
    return TextSpan(
      text: number,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextSpan _buildLabel(String label) {
    return TextSpan(
      text: label,
    );
  }
}
