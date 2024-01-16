import 'package:call_monitor/database/model/contact_database_model.dart';
import 'package:call_monitor/database/provider/contact_database_provider.dart';
import 'package:call_monitor/pages/contacts_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentlyTrackedContactPage extends StatelessWidget {
  const CurrentlyTrackedContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ContactListPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final asyncValue = ref.watch(contactDatabaseProvider);
            return asyncValue.map(
              data: (callLogData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final contact = callLogData.value[index];
                    return _buildContactItem(contact, ref);
                  },
                  itemCount: callLogData.value.length,
                );
              },
              error: (error) => const Center(child: Text("ERROR")),
              loading: (loading) => const Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
  }

  ListTile _buildContactItem(ContactDatabaseModel contact, WidgetRef ref) {
    return ListTile(
      title: Text(contact.displayName),
      subtitle: Text(
        contact.primaryPhoneNumber,
      ),
    );
  }
}
