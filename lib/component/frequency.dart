enum MonitoringFrequency {
  daily,
  weekly,
  monthly;

  int get days {
    switch (this) {
      case MonitoringFrequency.daily:
        return 1;
      case MonitoringFrequency.weekly:
        return 7;
      case MonitoringFrequency.monthly:
        return 30;
    }
  }

  String get label {
    switch (this) {
      case MonitoringFrequency.daily:
        return 'Daily';
      case MonitoringFrequency.weekly:
        return 'Weekly';
      case MonitoringFrequency.monthly:
        return 'Monthly';
    }
  }

  static MonitoringFrequency fromInt(int value) {
    if (value >= 0 && value < MonitoringFrequency.values.length) {
      return MonitoringFrequency.values[value];
    }
    return MonitoringFrequency.daily;
  }
}
