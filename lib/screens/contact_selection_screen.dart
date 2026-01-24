import 'package:call_monitor/components/list_avater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme.dart';
import 'package:call_monitor/components/gradient_button.dart';
import 'frequency_selection_screen.dart';

class ContactSelectionScreen extends ConsumerStatefulWidget {
  const ContactSelectionScreen({super.key});

  @override
  ConsumerState<ContactSelectionScreen> createState() =>
      _ContactSelectionScreenState();
}

class _ContactSelectionScreenState
    extends ConsumerState<ContactSelectionScreen> {
  List<Contact> _contacts = [];
  final List<Contact> _selectedContacts = [];
  bool _isLoading = false;
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    setState(() => _isLoading = true);
    if (await FlutterContacts.requestPermission()) {
      final contacts = await FlutterContacts.getContacts(withProperties: true);
      setState(() {
        _contacts = contacts;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
      // Handle permission denied
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Permission to access contacts was denied')),
        );
      }
    }
  }

  void _toggleContact(Contact contact) {
    setState(() {
      if (_selectedContacts.contains(contact)) {
        _selectedContacts.remove(contact);
      } else {
        _selectedContacts.add(contact);
      }
    });
  }

  void _goToFrequencySelection() {
    if (_selectedContacts.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FrequencySelectionScreen(
          selectedContacts: _selectedContacts,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Who matters?'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search contacts',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = "";
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppTheme.surfaceColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Builder(
                    builder: (context) {
                      final filteredContacts = _contacts.where((contact) {
                        return contact.displayName
                            .toLowerCase()
                            .contains(_searchQuery);
                      }).toList();

                      if (filteredContacts.isEmpty && _searchQuery.isNotEmpty) {
                        return const Center(child: Text("No contacts found"));
                      }

                      return ListView.builder(
                        itemCount: filteredContacts.length,
                        itemBuilder: (context, index) {
                          final contact = filteredContacts[index];
                          final isSelected =
                              _selectedContacts.contains(contact);
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: ListTile(
                              selected: isSelected,
                              selectedTileColor:
                                  AppTheme.primaryColor.withValues(alpha: 0.1),
                              selectedColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: isSelected
                                      ? AppTheme.primaryColor
                                          .withValues(alpha: 0.4)
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              leading:
                                  ListAvatar(displayName: contact.displayName),
                              title: Text(contact.displayName),
                              subtitle: Text(contact.phones.isNotEmpty
                                  ? contact.phones.first.number
                                  : 'No number'),
                              trailing: Checkbox(
                                value: isSelected,
                                onChanged: (_) => _toggleContact(contact),
                                activeColor: AppTheme.primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                              onTap: () => _toggleContact(contact),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  '“You’re choosing to care. We’ll help you remember.”',
                  style: AppTheme.lightTheme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                GradientButton(
                  onPressed: _selectedContacts.isEmpty
                      ? null
                      : _goToFrequencySelection,
                  text: 'Continue',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
