import 'package:flutter/material.dart';

enum CommunicationStatus {
  good,
  warning,
  overdue;

  Color get color {
    switch (this) {
      case CommunicationStatus.good:
        return Colors.green;
      case CommunicationStatus.warning:
        return Colors.orange;
      case CommunicationStatus.overdue:
        return Colors.red;
    }
  }

  String get label {
    switch (this) {
      case CommunicationStatus.good:
        return 'Good';
      case CommunicationStatus.warning:
        return 'Warning';
      case CommunicationStatus.overdue:
        return 'Overdue';
    }
  }
}
