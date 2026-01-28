import 'package:call_monitor/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme.dart';
import '../providers/database_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSectionHeader('Notifications'),
          _buildListTile(
            context,
            icon: Icons.schedule_outlined,
            title: 'Notification Schedule',
            subtitle: 'Customize when you receive reminders',
            onTap: () {
              Navigator.of(context).pushNamed('/notification-schedule');
            },
          ),
          const SizedBox(height: 32),
          _buildSectionHeader('Management'),
          _buildListTile(
            context,
            icon: Icons.notifications_none_rounded,
            title: 'Manage Reminders',
            onTap: () {
              Navigator.of(context).pushNamed('/manage-reminders');
            },
          ),
          // for testing purposes
          if (false)
            // ignore: dead_code
            _buildListTile(
              context,
              icon: Icons.bug_report_outlined,
              title: 'Send Test Notification',
              onTap: () async {
                final db = ref.read(databaseProvider);
                await NotificationService(db).sendTestNotification();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Test notification sent!')),
                  );
                }
              },
            ),
          _buildListTile(
            context,
            icon: Icons.delete_outline_rounded,
            title: 'Delete All Data',
            textColor: AppTheme.accentColor,
            onTap: () async {
              final confirm = await _showDeleteDialog(context);
              if (confirm == true) {
                await ref.read(databaseProvider).deleteAllData();
                if (context.mounted) {
                  Navigator.of(context).pushReplacementNamed('/');
                }
              }
            },
          ),
          const SizedBox(height: 32),
          _buildSectionHeader('Privacy'),
          _buildInfoRow(
              Icons.security, 'Just Call does not access your messages'),
          _buildInfoRow(
              Icons.phone_android, 'Call history stays on your phone'),
          _buildInfoRow(Icons.notifications_paused_outlined,
              'You can turn reminders off anytime'),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Privacy Statement',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  '“Your data never leaves your phone. We only use Call Log permissions to help you remember the people who matter. Nothing more.”',
                  style: AppTheme.lightTheme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSectionHeader('Support'),
          _buildListTile(
            context,
            icon: Icons.info_outline,
            title: 'About Just Call',
            onTap: () {
              Navigator.of(context).pushNamed('/about');
            },
          ),
          _buildListTile(
            context,
            icon: Icons.report_problem_outlined,
            title: 'Report a Problem',
            onTap: () {
              launchUrl(
                Uri.parse(
                  'mailto:sheikhanikbd@gmail.com?subject=Just Call App Feedback',
                ),
              );
            },
          ),
          _buildListTile(
            context,
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () {
              launchUrl(
                Uri.parse(
                    'https://docs.google.com/forms/d/e/1FAIpQLSfhTYnco6UuMitLYWlkAxNc-4VuWmQXLl1D1xzvXs-O7rNuYQ/viewform?usp=dialog'),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox();
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading:
                    const Icon(Icons.info, color: AppTheme.secondaryTextColor),
                title: Text(
                  'Version ${snapshot.data!.version}',
                  style: const TextStyle(
                    color: AppTheme.secondaryTextColor,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: AppTheme.secondaryTextColor),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: textColor ?? AppTheme.textColor),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? AppTheme.textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.textColor.withValues(alpha: 0.6),
              ),
            )
          : null,
      trailing:
          const Icon(Icons.chevron_right, color: AppTheme.secondaryTextColor),
      onTap: onTap,
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppTheme.primaryColor),
          const SizedBox(width: 12),
          Expanded(
              child:
                  Text(text, style: AppTheme.lightTheme.textTheme.bodyMedium)),
        ],
      ),
    );
  }

  Future<bool?> _showDeleteDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete all data?'),
        content: const Text(
            'This will remove all your tracked contacts and reminders permanently.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete',
                style: TextStyle(color: AppTheme.accentColor)),
          ),
        ],
      ),
    );
  }
}
