import 'package:call_monitor/pages/select_contacts_list_page.dart';
import 'package:call_monitor/util/contact_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/model/track_group.dart';
import '../database/provider/track_group_database_provider.dart';
import '../state/provider/selected_contact_provider.dart';

class CreateTrackGroup extends ConsumerStatefulWidget {
  const CreateTrackGroup({super.key});

  @override
  ConsumerState<CreateTrackGroup> createState() => _CreateTrackGroupState();
}

class _CreateTrackGroupState extends ConsumerState<CreateTrackGroup> {
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _frequencyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool autoGenerateName = true;

  @override
  Widget build(BuildContext context) {
    ref.listen(selectedContactProvider, (previous, next) {
      if (autoGenerateName) {
        // autoGenerateName = false;
        _groupNameController.text = next.map((e) => e.displayName).join(', ');
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Track Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: _groupNameController,
                  decoration: const InputDecoration(
                    labelText: 'Group Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    autoGenerateName = false;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a group name';
                    }
                    return null;
                  }),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _frequencyController,
                decoration: const InputDecoration(
                  labelText: 'Frequency',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectContactListPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                child: const Text('Select Contact'),
              ),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final selectedContacts = ref.watch(selectedContactProvider);
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final contact = selectedContacts[index];
                        return ListTile(
                          title: Text(contact.displayName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              contact.phones.length,
                              (index) => Text(contact.phones[index].number),
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => ref.read(selectedContactProvider.notifier).toggle(contact),
                          ),
                          onTap: () {},
                        );
                      },
                      itemCount: selectedContacts.length,
                    );
                  },
                ),
              ),
              // const Spacer(),
              Consumer(
                builder: (context, ref, child) {
                  final selectedContacts = ref.watch(selectedContactProvider);
                  // if (autoGenerateName && selectedContacts.isNotEmpty) {
                  //   _groupNameController.text = selectedContacts.map((e) => e.displayName).join(', ');
                  // }
                  return ElevatedButton(
                    onPressed: selectedContacts.isEmpty
                        ? null
                        : () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            // Save track group
                            final trackGroup = TrackGroup()
                              ..name = _groupNameController.text
                              ..frequency = int.tryParse(_frequencyController.text) ?? 0;
                            // trackGroup.contacts.addAll(selectedContacts.map((e) => e.toDatabaseModel()));
                            await ref.read(trackGroupDatabaseProvider.notifier).addTrackGroupWithContact(
                                  trackGroup,
                                  selectedContacts.map((e) => e.toDatabaseModel()).toList(),
                                );
                            // show confirmation
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Track group saved'),
                              ),
                            );
                            Navigator.pop(context);
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text('Save'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
