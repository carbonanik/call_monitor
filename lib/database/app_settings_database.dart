import 'package:call_monitor/database/database.dart';
import 'package:call_monitor/database/model/app_settings.dart';
import 'package:isar/isar.dart';

class AppSettingsDatabase {
  final isar = IsarDatabase.isar;

  // save first date of the app startup
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  // get first date of app startup
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }
}
