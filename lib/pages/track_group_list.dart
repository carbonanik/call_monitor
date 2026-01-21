import 'package:call_monitor/database/provider/track_group_database_provider.dart';
import 'package:call_monitor/pages/create_track_group.dart';
import 'package:call_monitor/pages/timeline_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:call_monitor/database/drift_database.dart';
import '../state/provider/selected_contact_provider.dart';
import 'package:call_monitor/util/monitor_service.dart';
import 'package:call_monitor/data_source/call_logs/call_logs.dart';
import 'package:call_log/call_log.dart';

class TrackGroupList extends StatelessWidget {
  const TrackGroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 48,
            ),
            const SizedBox(width: 12),
            const Text(
              'Call Monitor',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingAction(context),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Consumer(
        builder: (context, ref, child) {
          final asyncValue = ref.watch(trackGroupDatabaseProvider);
          // final contacts = ref.watch(allDeviceContactProvider);
          return asyncValue.map(
            data: (tracks) => _buildList(tracks, ref),
            error: (error) => _buildListError(),
            loading: (loading) =>
                const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget _buildListError() {
    return const Center(
      child: Text(
        "ERROR",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
    );
  }

  Widget _buildList(AsyncData<List<TrackGroup>> tracks, WidgetRef ref) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final track = tracks.value[index];
        return _buildTrackItem(track, ref, context);
      },
      itemCount: tracks.value.length,
    );
  }

  Widget _buildFloatingAction(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      // final allContacts = ref.watch(allDeviceContactProvider); // Removed unused
      return FloatingActionButton(
        onPressed: () => _onAddPress(context, ref),
        child: const Icon(Icons.add),
      );
    });
  }

  void _onAddPress(BuildContext context, WidgetRef ref) {
    // NotificationService().showFakeNotification();
    // return;
    ref.read(selectedContactProvider.notifier).clear();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateTrackGroup(),
      ),
    );
  }

  Widget _buildTrackItem(
      TrackGroup track, WidgetRef ref, BuildContext context) {
    // In Drift, relationships require a join or separate fetch.
    // For simplicity in this view, we'll use a FutureBuilder or similar if we want to show numbers here.
    // However, looking at the previous implementation, it used track.numberList().
    // We'll update DatabaseManager to include a helper for this or use a Provider.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: FutureBuilder<List<Contact>>(
        future: ref
            .read(trackGroupDatabaseProvider.notifier)
            .db
            .getContactsForTrackGroup(track.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox.shrink();
          final contacts = snapshot.data!;
          final numbers = contacts.expand((c) => c.phoneNumbers).toList();

          return FutureBuilder<List<CallLogEntry>>(
              future: CallLogsDataSource().getCallLogsByNumbers(numbers),
              builder: (context, logSnapshot) {
                Color statusColor = Colors.grey;
                if (logSnapshot.hasData) {
                  final status =
                      MonitorService.checkStatus(track, logSnapshot.data!);
                  statusColor = status.color;
                }

                return ListTile(
                  tileColor: Theme.of(context).colorScheme.primaryContainer,
                  leading: CircleAvatar(
                    backgroundColor: statusColor,
                    radius: 10,
                  ),
                  title: Text(track.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: numbers.map((n) => Text(n)).toList(),
                  ),
                  onTap: () {
                    _onTrackTapped(context, track.id);
                  },
                );
              });
        },
      ),
    ); // Padding
  }

  void _onTrackTapped(BuildContext context, int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TimelineViewPage(trackGroupId: id),
      ),
    );
  }
}
