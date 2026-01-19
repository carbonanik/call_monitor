import 'package:call_monitor/database/drift_database.dart' as db;
import 'package:flutter_contacts/flutter_contacts.dart' as fc;

extension ContactExt on fc.Contact {
  db.Contact toDatabaseModel() {
    return db.Contact(
      id: 0,
      contactId: id,
      displayName: displayName,
      phoneNumbers: phones.map((e) => e.number).toList(),
    );
  }
}
