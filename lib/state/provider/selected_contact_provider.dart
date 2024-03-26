import 'package:call_monitor/state/notifier/selected_contact_notifier.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedContactProvider = StateNotifierProvider<SelectedContactNotifier, List<Contact>>((ref) {
  return SelectedContactNotifier(ref: ref);
});
