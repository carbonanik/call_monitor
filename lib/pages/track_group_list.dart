import 'package:call_monitor/database/model/contact_database_model.dart';
import 'package:call_monitor/database/provider/contact_database_provider.dart';
import 'package:call_monitor/database/provider/track_group_database_provider.dart';
import 'package:call_monitor/pages/create_track_group.dart';
import 'package:call_monitor/pages/select_contacts_list_page.dart';
import 'package:call_monitor/pages/timeline_view_page.dart';
import 'package:call_monitor/state/provider/all_device_contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/model/track_group.dart';
import '../state/provider/selected_contact_provider.dart';

class TrackGroupList extends StatelessWidget {
  const TrackGroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            loading: (loading) => const Center(child: CircularProgressIndicator()),
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
    return Consumer(
      builder: (context, ref, child)  {
        final allContacts = ref.watch(allDeviceContactProvider);
        return FloatingActionButton(
          onPressed: () => _onAddPress(context, ref),
          child: const Icon(Icons.add),
        );
      }
    );
  }

  void _onAddPress(BuildContext context, WidgetRef ref) {
    ref.read(selectedContactProvider.notifier).clear();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateTrackGroup(),
      ),
    );
  }

  Widget _buildTrackItem(TrackGroup track, WidgetRef ref, BuildContext context) {
    final numbers = track.numberList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(track.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          children: List.generate(
            numbers.length,
            (index) => Text(numbers[index]),
          ),
        ),
        onTap: () {
          _onTrackTapped(context, track.id);
        },
      ),
    );
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
