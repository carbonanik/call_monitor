import 'package:call_monitor/database/model/app_settings.dart';
import 'package:call_monitor/database/model/contact_database_model.dart';
import 'package:call_monitor/database/model/history.dart';
import 'package:call_monitor/database/model/track_group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatabase {

  static late Isar isar;

  /// ? S E T U P

  // I N I T I A L I Z E -- D A T A B A S E
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [ContactDatabaseModelSchema, AppSettingsSchema, TrackGroupSchema, HistorySchema],
      directory: dir.path,
    );
  }
}
