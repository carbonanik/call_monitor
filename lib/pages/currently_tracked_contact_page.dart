import 'package:call_monitor/database/model/contact_database_model.dart';
import 'package:call_monitor/database/provider/contact_database_provider.dart';
import 'package:call_monitor/pages/select_contacts_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentlyTrackedContactPage extends StatelessWidget {
  const CurrentlyTrackedContactPage({super.key});

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
          final asyncValue = ref.watch(contactDatabaseProvider);
          return asyncValue.map(
            data: (callLogData) => _buildList(callLogData, ref),
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

  Widget _buildList(AsyncData<List<ContactDatabaseModel>> callLogData, WidgetRef ref) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final contact = callLogData.value[index];
        return _buildContactItem(contact, ref, context);
      },
      itemCount: callLogData.value.length,
    );
  }

  Widget _buildFloatingAction(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _onAddPress(context),
      child: const Icon(Icons.add),
    );
  }

  void _onAddPress(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SelectContactListPage(),
      ),
    );
  }

  Widget _buildContactItem(ContactDatabaseModel contact, WidgetRef ref, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(contact.displayName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(contact.primaryPhoneNumber),
      ),
    );
  }
}
