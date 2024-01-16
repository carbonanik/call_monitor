import 'package:call_monitor/database/model/contact_database_model.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

extension ContactExt on Contact {
   ContactDatabaseModel toDatabaseModel() {
    return ContactDatabaseModel(
      contactId: id,
      displayName: displayName,
      primaryPhoneNumber: phones.firstOrNull?.number ?? '',
    );
  }
}