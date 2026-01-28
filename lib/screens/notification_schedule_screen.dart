import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../services/notification_schedule_preferences.dart';

class NotificationScheduleScreen extends StatefulWidget {
  const NotificationScheduleScreen({super.key});

  @override
  State<NotificationScheduleScreen> createState() =>
      _NotificationScheduleScreenState();
}

class _NotificationScheduleScreenState
    extends State<NotificationScheduleScreen> {
  TimeWindowData? _morningWindow;
  TimeWindowData? _daytimeWindow;
  TimeWindowData? _eveningWindow;
  bool _isLoading = true;
  bool _is24HourFormat = false;

  @override
  void initState() {
    super.initState();
    _loadSchedules();
  }

  Future<void> _loadSchedules() async {
    final morning = await NotificationSchedulePreferences.getMorningWindow();
    final daytime = await NotificationSchedulePreferences.getDaytimeWindow();
    final evening = await NotificationSchedulePreferences.getEveningWindow();

    setState(() {
      _morningWindow = morning;
      _daytimeWindow = daytime;
      _eveningWindow = evening;
      _isLoading = false;
    });
  }

  Future<void> _pickTime({
    required String title,
    required TimeWindowData currentWindow,
    required bool isStartTime,
    required Function(TimeWindowData) onSaved,
  }) async {
    final initialTime = TimeOfDay(
      hour: isStartTime ? currentWindow.startHour : currentWindow.endHour,
      minute: isStartTime ? currentWindow.startMinute : currentWindow.endMinute,
    );

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      final newWindow = TimeWindowData(
        startHour: isStartTime ? pickedTime.hour : currentWindow.startHour,
        startMinute:
            isStartTime ? pickedTime.minute : currentWindow.startMinute,
        endHour: !isStartTime ? pickedTime.hour : currentWindow.endHour,
        endMinute: !isStartTime ? pickedTime.minute : currentWindow.endMinute,
      );

      // Validate that start time is before end time
      final startMinutes = newWindow.startHour * 60 + newWindow.startMinute;
      final endMinutes = newWindow.endHour * 60 + newWindow.endMinute;

      if (startMinutes >= endMinutes) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Start time must be before end time'),
              backgroundColor: AppTheme.accentColor,
            ),
          );
        }
        return;
      }

      await onSaved(newWindow);
      await _loadSchedules();
    }
  }

  Future<void> _resetToDefaults() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset to defaults?'),
        content: const Text(
            'This will reset all notification times to their default values.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Reset',
                style: TextStyle(color: AppTheme.accentColor)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await NotificationSchedulePreferences.resetToDefaults();
      await _loadSchedules();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reset to default times')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.restore),
            onPressed: _resetToDefaults,
            tooltip: 'Reset to defaults',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildInfoCard(),
          const SizedBox(height: 24),
          _buildTimeWindowSection(
            title: 'Morning Summary',
            description: 'Get a gentle overview of who to call today',
            icon: Icons.wb_sunny_outlined,
            window: _morningWindow!,
            onSave: (window) async {
              await NotificationSchedulePreferences.setMorningWindow(
                startHour: window.startHour,
                startMinute: window.startMinute,
                endHour: window.endHour,
                endMinute: window.endMinute,
              );
            },
          ),
          const SizedBox(height: 16),
          _buildTimeWindowSection(
            title: 'Daytime Nudges',
            description: 'Occasional reminders throughout the day',
            icon: Icons.phone_outlined,
            window: _daytimeWindow!,
            onSave: (window) async {
              await NotificationSchedulePreferences.setDaytimeWindow(
                startHour: window.startHour,
                startMinute: window.startMinute,
                endHour: window.endHour,
                endMinute: window.endMinute,
              );
            },
          ),
          const SizedBox(height: 16),
          _buildTimeWindowSection(
            title: 'Evening Reflection',
            description: 'End the day with calm reflection',
            icon: Icons.nightlight_outlined,
            window: _eveningWindow!,
            onSave: (window) async {
              await NotificationSchedulePreferences.setEveningWindow(
                startHour: window.startHour,
                startMinute: window.startMinute,
                endHour: window.endHour,
                endMinute: window.endMinute,
              );
            },
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('24-Hour Format'),
            value: _is24HourFormat,
            onChanged: (value) async {
              setState(() {
                _is24HourFormat = value;
              });
              _is24HourFormat = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryColor.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: AppTheme.primaryColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Set time windows for when you want to receive notifications',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeWindowSection({
    required String title,
    required String description,
    required IconData icon,
    required TimeWindowData window,
    required Function(TimeWindowData) onSave,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppTheme.primaryColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.textColor.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildTimeButton(
                  label: 'Start',
                  time: _is24HourFormat
                      ? window.startTimeString
                      : window.startTimeStringAmPm,
                  onTap: () => _pickTime(
                    title: 'Select start time',
                    currentWindow: window,
                    isStartTime: true,
                    onSaved: onSave,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.arrow_forward,
                  color: AppTheme.secondaryTextColor, size: 20),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTimeButton(
                  label: 'End',
                  time: _is24HourFormat
                      ? window.endTimeString
                      : window.endTimeStringAmPm,
                  onTap: () => _pickTime(
                    title: 'Select end time',
                    currentWindow: window,
                    isStartTime: false,
                    onSaved: onSave,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeButton({
    required String label,
    required String time,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.primaryColor.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.textColor.withValues(alpha: 0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
