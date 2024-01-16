import 'package:flutter_contacts/flutter_contacts.dart';

class ReadContactDataSource {
  Future<List<Contact>> readAllContacts() async {
    if (await FlutterContacts.requestPermission()) {
      List<Contact> contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true
      );
      return contacts;
    }
    return [];
  }

  Future<Contact?> getFullContact(String id) async {
    Contact? contact = await FlutterContacts.getContact(id);
    return contact;
  }

  // Future<List<Contact>> readAllContactsFullyFetched() async {
  //   // Get all contacts (fully fetched)
  //   List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
  //   return contacts;
  // }


// // Get contact with specific ID (fully fetched)
//   Contact contact = await
//
//   FlutterContacts.getContact(contacts.first.id);
//
// // Insert new contact
//   final newContact = Contact()
//   ..name.first = 'John'
//   ..name.last = 'Smith'
//   ..phones = [Phone('555-123-4567')];
//   await newContact.insert();
//
// // Update contact
//   contact.name.first = 'Bob';
//   await contact.update();
//
// // Delete contact
//   await contact.delete();
//
// // Open external contact app to view/edit/pick/insert contacts.
//   await FlutterContacts.openExternalView(contact.id);
//   await FlutterContacts.openExternalEdit(contact.id);
//   final contact = await FlutterContacts.openExternalPick();
//   final contact = await FlutterContacts.openExternalInsert();
//
// // Listen to contact database changes
//   FlutterContacts.addListener(() => print('Contact DB changed'));
//
// // Create a new group (iOS) / label (Android).
//   await FlutterContacts.insertGroup(Group('', 'Coworkers'));
//
// // Export contact to vCard
//   String vCard = contact.toVCard();
//
// // Import contact from vCard
//   contact = Contact.fromVCard('BEGIN:VCARD\n'
//   'VERSION:3.0\n'
//   'N:;Joe;;;\n'
//   'TEL;TYPE=HOME:123456\n'
//   'END:VCARD
//
//   '
//
//   );
}
