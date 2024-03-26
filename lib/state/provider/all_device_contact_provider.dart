import 'package:call_monitor/state/notifier/all_contact_notifier.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allDeviceContactProvider = StateNotifierProvider<AllContactNotifier, AsyncValue<List<Contact>>>(
  (ref) => AllContactNotifier(ref: ref),
);
