import 'package:isar/isar.dart';

part 'contact_database_model.g.dart';

@Collection()
class ContactDatabaseModel {
  Id id = Isar.autoIncrement;
  // @Index(unique: true)
  String contactId;
  String displayName;
  List<String> phoneNumbers;

  ContactDatabaseModel({
    required this.contactId,
    required this.displayName,
    required this.phoneNumbers,
  });

  @override
  String toString() {
    return 'ContactDatabaseModel('
        ' id: $id, '
        ' contactId: $contactId, '
        ' displayName: $displayName, '
        ' primaryPhoneNumber: $phoneNumbers, '
        ')';
  }
}
