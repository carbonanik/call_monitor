import 'package:isar/isar.dart';

part 'contact_database_model.g.dart';

@Collection()
class ContactDatabaseModel {
  Id id = Isar.autoIncrement;
  String contactId;
  String displayName;
  String primaryPhoneNumber;

  ContactDatabaseModel({
    required this.contactId,
    required this.displayName,
    required this.primaryPhoneNumber,
  });

  @override
  String toString() {
    return 'ContactDatabaseModel(id: $id, contactId: $contactId, displayName: $displayName, primaryPhoneNumber: $primaryPhoneNumber)';
  }
}
