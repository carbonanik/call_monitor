import 'package:call_monitor/database/database_manager.dart';
import 'package:call_monitor/database/drift_database.dart';
import 'package:drift/drift.dart';

class AppSettingsDatabase {
  final db = DatabaseManager.database;

  // save first date of the app startup
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await db.getSettings();
    if (existingSettings == null) {
      await db.insertSettings(AppSettingsCompanion.insert(
        firstLaunchDate: Value(DateTime.now()),
      ));
    }
  }

  // get first date of app startup
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await db.getSettings();
    return settings?.firstLaunchDate;
  }
}
