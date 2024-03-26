import 'package:isar/isar.dart';

import 'contact_database_model.dart';

part 'history.g.dart';

@Collection()
class History {
  Id id = Isar.autoIncrement;
  late DateTime date;
  late int duration;
  late int continuation;
}
