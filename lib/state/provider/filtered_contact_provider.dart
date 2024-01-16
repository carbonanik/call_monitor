import 'package:call_monitor/database/model/contact_database_model.dart';
import 'package:call_monitor/state/provider/all_contact_provider.dart';
import 'package:call_monitor/state/provider/contact_search_text_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filteredContactProvider = Provider<AsyncValue<List<ContactDatabaseModel>>>(
  (ref) {
    final text = ref.watch(contactSearchTextProvider);
    final allContactsAsyncValue = ref.watch(allContactProvider);

    return allContactsAsyncValue.when(
      data: (data) {
        return AsyncData(data.where((contact) {
          return contact.displayName.toLowerCase().contains(text.toLowerCase());
        }).toList());
      },
      error: (error, stackTrace) => AsyncError(error, stackTrace),
      loading: () => const AsyncLoading(),
    );
  },
);
