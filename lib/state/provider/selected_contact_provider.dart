import 'package:call_monitor/database/model/contact_database_model.dart';
import 'package:call_monitor/state/notifier/selected_contact_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedContactProvider = StateNotifierProvider<SelectedContactNotifier, List<ContactDatabaseModel>>((ref) {
  return SelectedContactNotifier(ref: ref);
});
