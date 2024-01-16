import 'package:isar/isar.dart';

part 'app_settings.g.dart';

@Collection()
class AppSettings {
  Id id = Isar.autoIncrement;
  DateTime? firstLaunchDate;
}

// run cmd: dart run build_runner build --delete-conflicting-outputs
