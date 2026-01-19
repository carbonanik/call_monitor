import 'package:call_monitor/component/frequency.dart';
import 'package:flutter/material.dart';

class FrequencySelectionDialog extends StatelessWidget {
  final MonitoringFrequency initialFrequency;

  const FrequencySelectionDialog({
    super.key,
    required this.initialFrequency,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Select Frequency'),
      children: MonitoringFrequency.values.map((frequency) {
        return SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, frequency);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                if (frequency == initialFrequency)
                  const Icon(Icons.check, color: Colors.blue)
                else
                  const SizedBox(width: 24),
                const SizedBox(width: 12),
                Text(frequency.label),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
