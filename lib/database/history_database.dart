import 'package:call_monitor/database/model/app_settings.dart';
import 'package:call_monitor/database/model/contact_database_model.dart';
import 'package:call_monitor/database/model/history.dart';
import 'package:call_monitor/database/model/track_group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'database.dart';

class ContactDatabase {

  final Isar isar = IsarDatabase.isar;

}
