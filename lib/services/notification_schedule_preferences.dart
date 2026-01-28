import 'package:shared_preferences/shared_preferences.dart';

class NotificationSchedulePreferences {
  static const String _morningStartHourKey = 'morning_start_hour';
  static const String _morningStartMinuteKey = 'morning_start_minute';
  static const String _morningEndHourKey = 'morning_end_hour';
  static const String _morningEndMinuteKey = 'morning_end_minute';

  static const String _daytimeStartHourKey = 'daytime_start_hour';
  static const String _daytimeStartMinuteKey = 'daytime_start_minute';
  static const String _daytimeEndHourKey = 'daytime_end_hour';
  static const String _daytimeEndMinuteKey = 'daytime_end_minute';

  static const String _eveningStartHourKey = 'evening_start_hour';
  static const String _eveningStartMinuteKey = 'evening_start_minute';
  static const String _eveningEndHourKey = 'evening_end_hour';
  static const String _eveningEndMinuteKey = 'evening_end_minute';

  // Default values
  static const int _defaultMorningStartHour = 8;
  static const int _defaultMorningStartMinute = 30;
  static const int _defaultMorningEndHour = 9;
  static const int _defaultMorningEndMinute = 30;

  static const int _defaultDaytimeStartHour = 11;
  static const int _defaultDaytimeStartMinute = 0;
  static const int _defaultDaytimeEndHour = 18;
  static const int _defaultDaytimeEndMinute = 0;

  static const int _defaultEveningStartHour = 20;
  static const int _defaultEveningStartMinute = 0;
  static const int _defaultEveningEndHour = 21;
  static const int _defaultEveningEndMinute = 0;

  /// Save morning notification time window
  static Future<void> setMorningWindow({
    required int startHour,
    required int startMinute,
    required int endHour,
    required int endMinute,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_morningStartHourKey, startHour);
    await prefs.setInt(_morningStartMinuteKey, startMinute);
    await prefs.setInt(_morningEndHourKey, endHour);
    await prefs.setInt(_morningEndMinuteKey, endMinute);
  }

  /// Save daytime notification time window
  static Future<void> setDaytimeWindow({
    required int startHour,
    required int startMinute,
    required int endHour,
    required int endMinute,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_daytimeStartHourKey, startHour);
    await prefs.setInt(_daytimeStartMinuteKey, startMinute);
    await prefs.setInt(_daytimeEndHourKey, endHour);
    await prefs.setInt(_daytimeEndMinuteKey, endMinute);
  }

  /// Save evening notification time window
  static Future<void> setEveningWindow({
    required int startHour,
    required int startMinute,
    required int endHour,
    required int endMinute,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_eveningStartHourKey, startHour);
    await prefs.setInt(_eveningStartMinuteKey, startMinute);
    await prefs.setInt(_eveningEndHourKey, endHour);
    await prefs.setInt(_eveningEndMinuteKey, endMinute);
  }

  /// Get morning notification time window
  static Future<TimeWindowData> getMorningWindow() async {
    final prefs = await SharedPreferences.getInstance();
    return TimeWindowData(
      startHour: prefs.getInt(_morningStartHourKey) ?? _defaultMorningStartHour,
      startMinute:
          prefs.getInt(_morningStartMinuteKey) ?? _defaultMorningStartMinute,
      endHour: prefs.getInt(_morningEndHourKey) ?? _defaultMorningEndHour,
      endMinute: prefs.getInt(_morningEndMinuteKey) ?? _defaultMorningEndMinute,
    );
  }

  /// Get daytime notification time window
  static Future<TimeWindowData> getDaytimeWindow() async {
    final prefs = await SharedPreferences.getInstance();
    return TimeWindowData(
      startHour: prefs.getInt(_daytimeStartHourKey) ?? _defaultDaytimeStartHour,
      startMinute:
          prefs.getInt(_daytimeStartMinuteKey) ?? _defaultDaytimeStartMinute,
      endHour: prefs.getInt(_daytimeEndHourKey) ?? _defaultDaytimeEndHour,
      endMinute: prefs.getInt(_daytimeEndMinuteKey) ?? _defaultDaytimeEndMinute,
    );
  }

  /// Get evening notification time window
  static Future<TimeWindowData> getEveningWindow() async {
    final prefs = await SharedPreferences.getInstance();
    return TimeWindowData(
      startHour: prefs.getInt(_eveningStartHourKey) ?? _defaultEveningStartHour,
      startMinute:
          prefs.getInt(_eveningStartMinuteKey) ?? _defaultEveningStartMinute,
      endHour: prefs.getInt(_eveningEndHourKey) ?? _defaultEveningEndHour,
      endMinute: prefs.getInt(_eveningEndMinuteKey) ?? _defaultEveningEndMinute,
    );
  }

  /// Reset all notification schedules to defaults
  static Future<void> resetToDefaults() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_morningStartHourKey);
    await prefs.remove(_morningStartMinuteKey);
    await prefs.remove(_morningEndHourKey);
    await prefs.remove(_morningEndMinuteKey);
    await prefs.remove(_daytimeStartHourKey);
    await prefs.remove(_daytimeStartMinuteKey);
    await prefs.remove(_daytimeEndHourKey);
    await prefs.remove(_daytimeEndMinuteKey);
    await prefs.remove(_eveningStartHourKey);
    await prefs.remove(_eveningStartMinuteKey);
    await prefs.remove(_eveningEndHourKey);
    await prefs.remove(_eveningEndMinuteKey);
  }
}

/// Data class to hold time window information
class TimeWindowData {
  final int startHour;
  final int startMinute;
  final int endHour;
  final int endMinute;

  TimeWindowData({
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
  });

  String get startTimeString =>
      '${startHour.toString().padLeft(2, '0')}:${startMinute.toString().padLeft(2, '0')}';

  String get endTimeString =>
      '${endHour.toString().padLeft(2, '0')}:${endMinute.toString().padLeft(2, '0')}';

  String get startTimeStringAmPm {
    final hour =
        startHour == 0 ? 12 : (startHour > 12 ? startHour - 12 : startHour);
    final period = startHour >= 12 ? 'PM' : 'AM';
    return '${hour.toString().padLeft(2, '0')}:${startMinute.toString().padLeft(2, '0')} $period';
  }

  String get endTimeStringAmPm {
    final hour = endHour == 0 ? 12 : (endHour > 12 ? endHour - 12 : endHour);
    final period = endHour >= 12 ? 'PM' : 'AM';
    return '${hour.toString().padLeft(2, '0')}:${endMinute.toString().padLeft(2, '0')} $period';
  }
}
