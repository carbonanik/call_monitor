import 'package:isar/isar.dart';


part 'history.g.dart';

@Collection()
class History {
  Id id = Isar.autoIncrement;
  late DateTime date;
  late int duration;
  late int continuation;
}
