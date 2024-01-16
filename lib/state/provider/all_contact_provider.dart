import 'package:call_monitor/database/model/contact_database_model.dart';
import 'package:call_monitor/state/notifier/all_contact_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allContactProvider = StateNotifierProvider<AllContactNotifier, AsyncValue<List<ContactDatabaseModel>>>(
  (ref) => AllContactNotifier(ref: ref),
);
