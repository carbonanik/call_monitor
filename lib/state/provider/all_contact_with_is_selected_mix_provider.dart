import 'package:call_monitor/state/model/contact_with_is_selected.dart';
import 'package:call_monitor/state/provider/all_device_contact_provider.dart';
import 'package:call_monitor/state/provider/contact_search_text_provider.dart';
import 'package:call_monitor/state/provider/selected_contact_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filteredContactWithIsSelectedMixProvider = Provider<AsyncValue<List<ContactWithIsSelected>>>(
  (ref) {
    // ? GET SEARCH TEXT
    final text = ref.watch(contactSearchTextProvider);
    // ? GET ALL CONTACT AS ASYNC_VALUE
    final allContactsAsyncValue = ref.watch(allDeviceContactProvider);
    // ? GET SELECTED CONTACT
    final selectedContacts = ref.watch(selectedContactProvider);

    // ? FILTER CONTACT
    return allContactsAsyncValue.when(
      data: (data) {
        return AsyncData(
          data.where((contact) {
            // ? FILTER BY SEARCH TEXT
            return contact.displayName.toLowerCase().contains(text.toLowerCase());
          }).map((contact) {
            // ? CHECK IF CONTACT IS SELECTED
            final isSelected = selectedContacts.where((selected) => selected.id == contact.id).isNotEmpty;
            // ? RETURN CONTACT_WITH_IS_SELECTED
            return ContactWithIsSelected(contact, isSelected);
          }).toList(),
        );
      },
      error: (error, stackTrace) => AsyncError(error, stackTrace),
      loading: () => const AsyncLoading(),
    );
  },
);
