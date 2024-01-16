import 'package:call_monitor/state/model/contact_with_is_selected.dart';
import 'package:call_monitor/state/provider/all_contact_provider.dart';
import 'package:call_monitor/state/provider/contact_search_text_provider.dart';
import 'package:call_monitor/state/provider/selected_contact_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filteredContactWithIsSelectedMixProvider = Provider<AsyncValue<List<ContactWithIsSelected>>>(
  (ref) {
    final text = ref.watch(contactSearchTextProvider);
    final allContactsAsyncValue = ref.watch(allContactProvider);
    final selectedContacts = ref.watch(selectedContactProvider);

    return allContactsAsyncValue.when(
      data: (data) {
        return AsyncData(
          data.where((contact) {
            return contact.displayName.toLowerCase().contains(text.toLowerCase());
          }).map((c) {
            final isSelected = selectedContacts.contains(c);
            return ContactWithIsSelected(c, isSelected);
          }).toList(),
        );
      },
      error: (error, stackTrace) => AsyncError(error, stackTrace),
      loading: () => const AsyncLoading(),
    );
  },
);
