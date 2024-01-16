import 'package:call_monitor/database/model/contact_database_model.dart';

class ContactWithIsSelected {
  final ContactDatabaseModel contact;
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
