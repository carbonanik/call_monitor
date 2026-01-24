import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme.dart';
import 'package:call_monitor/components/gradient_button.dart';
import '../database/database.dart';
import '../providers/database_provider.dart';
import 'package:drift/drift.dart' as drift;

class FrequencySelectionScreen extends ConsumerStatefulWidget {
  final List<Contact> selectedContacts;

  const FrequencySelectionScreen({super.key, required this.selectedContacts});

  @override
  ConsumerState<FrequencySelectionScreen> createState() =>
      _FrequencySelectionScreenState();
}

class _FrequencySelectionScreenState
    extends ConsumerState<FrequencySelectionScreen> {
  // Map to store selected frequency for each contact index
  final Map<int, int> _selectedFrequencies = {};
  bool _isSaving = false;

  final List<Map<String, dynamic>> _options = [
    {'label': 'Everyday', 'days': 1},
    {'label': 'Every 3 days', 'days': 3},
    {'label': 'Weekly', 'days': 7},
    {'label': 'Every 2 weeks', 'days': 14},
    {'label': 'Monthly', 'days': 30},
  ];

  @override
  void initState() {
    super.initState();
    // Default to Weekly (7 days) for all selected contacts
    for (int i = 0; i < widget.selectedContacts.length; i++) {
      _selectedFrequencies[i] = 7;
    }
  }

  Future<void> _saveAndFinish() async {
    if (_isSaving || !mounted) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final db = ref.read(databaseProvider);

      for (int i = 0; i < widget.selectedContacts.length; i++) {
        final contact = widget.selectedContacts[i];
        final frequency = _selectedFrequencies[i] ?? 7;

        final name = contact.displayName;
        final rawPhone =
            contact.phones.isNotEmpty ? contact.phones.first.number : '';
        // Normalize number to ensure unique constraint works reliably
        final phone = rawPhone.replaceAll(RegExp(r'\D'), '');

        await db.addTrackedContact(
          TrackedContactsCompanion(
            name: drift.Value(name),
            phoneNumber: drift.Value(phone),
            frequencyDays: drift.Value(frequency),
            lastCalled: const drift.Value.absent(),
          ),
        );
      }

      if (mounted) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving contacts: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Reminder Frequency'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: widget.selectedContacts.length,
              itemBuilder: (context, index) {
                final contact = widget.selectedContacts[index];
                return _ContactFrequencyCard(
                  contact: contact,
                  selectedDays: _selectedFrequencies[index] ?? 7,
                  options: _options,
                  onChanged: (days) {
                    setState(() {
                      _selectedFrequencies[index] = days;
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: GradientButton(
              onPressed: _isSaving ? null : _saveAndFinish,
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactFrequencyCard extends StatelessWidget {
  final Contact contact;
  final int selectedDays;
  final List<Map<String, dynamic>> options;
  final ValueChanged<int> onChanged;

  const _ContactFrequencyCard({
    required this.contact,
    required this.selectedDays,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // ListAvatar(contact: contact),
              CircleAvatar(
                backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                child: Text(
                  contact.displayName.isNotEmpty ? contact.displayName[0] : '?',
                  style: const TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.displayName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    'Reminding ${selectedDays == 7 ? "Weekly" : "Every $selectedDays days"}',
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...options.map((opt) {
            final isSelected = selectedDays == opt['days'];
            return GestureDetector(
              onTap: () => onChanged(opt['days']),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        isSelected ? AppTheme.primaryColor : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      opt['label'],
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected
                            ? AppTheme.primaryColor
                            : AppTheme.textColor,
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle,
                          color: AppTheme.primaryColor, size: 20),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
