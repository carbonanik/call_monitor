import 'package:flutter_contacts/flutter_contacts.dart';

/* *
* Represents a contact with a boolean indicating whether it is selected or not.
* */

class ContactWithIsSelected {
  final Contact contact;
  final bool isSelected;

  ContactWithIsSelected(this.contact, this.isSelected);

  @override
  String toString() {
    return 'ContactWithIsSelected{contact: $contact, isSelected: $isSelected}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return contact == (other as ContactWithIsSelected).contact && isSelected == (other).isSelected;
  }

  @override
  int get hashCode => contact.hashCode ^ isSelected.hashCode;
}
