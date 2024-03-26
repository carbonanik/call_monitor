import 'package:isar/isar.dart';

import 'contact_database_model.dart';
import 'history.dart';

part 'track_group.g.dart';

@Collection()
class TrackGroup {
  Id id = Isar.autoIncrement;
  late String name;
  late int frequency = 0;
  final contacts = IsarLinks<ContactDatabaseModel>();
  final history = IsarLinks<History>();
}

extension TrackGroupExt on TrackGroup {
  List<String> numberList() {
    return contacts.map((e) => e.phoneNumbers).expand((i) => i).toList();
  }
}
