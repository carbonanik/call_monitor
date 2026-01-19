// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _firstLaunchDateMeta =
      const VerificationMeta('firstLaunchDate');
  @override
  late final GeneratedColumn<DateTime> firstLaunchDate =
      GeneratedColumn<DateTime>('first_launch_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, firstLaunchDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(Insertable<AppSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_launch_date')) {
      context.handle(
          _firstLaunchDateMeta,
          firstLaunchDate.isAcceptableOrUnknown(
              data['first_launch_date']!, _firstLaunchDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      firstLaunchDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}first_launch_date']),
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final DateTime? firstLaunchDate;
  const AppSetting({required this.id, this.firstLaunchDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || firstLaunchDate != null) {
      map['first_launch_date'] = Variable<DateTime>(firstLaunchDate);
    }
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      firstLaunchDate: firstLaunchDate == null && nullToAbsent
          ? const Value.absent()
          : Value(firstLaunchDate),
    );
  }

  factory AppSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      firstLaunchDate: serializer.fromJson<DateTime?>(json['firstLaunchDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstLaunchDate': serializer.toJson<DateTime?>(firstLaunchDate),
    };
  }

  AppSetting copyWith(
          {int? id, Value<DateTime?> firstLaunchDate = const Value.absent()}) =>
      AppSetting(
        id: id ?? this.id,
        firstLaunchDate: firstLaunchDate.present
            ? firstLaunchDate.value
            : this.firstLaunchDate,
      );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      firstLaunchDate: data.firstLaunchDate.present
          ? data.firstLaunchDate.value
          : this.firstLaunchDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('firstLaunchDate: $firstLaunchDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, firstLaunchDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.firstLaunchDate == this.firstLaunchDate);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<DateTime?> firstLaunchDate;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.firstLaunchDate = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.firstLaunchDate = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<DateTime>? firstLaunchDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstLaunchDate != null) 'first_launch_date': firstLaunchDate,
    });
  }

  AppSettingsCompanion copyWith(
      {Value<int>? id, Value<DateTime?>? firstLaunchDate}) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      firstLaunchDate: firstLaunchDate ?? this.firstLaunchDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstLaunchDate.present) {
      map['first_launch_date'] = Variable<DateTime>(firstLaunchDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('firstLaunchDate: $firstLaunchDate')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts with TableInfo<$ContactsTable, Contact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _contactIdMeta =
      const VerificationMeta('contactId');
  @override
  late final GeneratedColumn<String> contactId = GeneratedColumn<String>(
      'contact_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      phoneNumbers = GeneratedColumn<String>(
              'phone_numbers', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($ContactsTable.$converterphoneNumbers);
  @override
  List<GeneratedColumn> get $columns =>
      [id, contactId, displayName, phoneNumbers];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(Insertable<Contact> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('contact_id')) {
      context.handle(_contactIdMeta,
          contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta));
    } else if (isInserting) {
      context.missing(_contactIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contact(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      contactId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contact_id'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      phoneNumbers: $ContactsTable.$converterphoneNumbers.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}phone_numbers'])!),
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterphoneNumbers =
      const StringListConverter();
}

class Contact extends DataClass implements Insertable<Contact> {
  final int id;
  final String contactId;
  final String displayName;
  final List<String> phoneNumbers;
  const Contact(
      {required this.id,
      required this.contactId,
      required this.displayName,
      required this.phoneNumbers});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['contact_id'] = Variable<String>(contactId);
    map['display_name'] = Variable<String>(displayName);
    {
      map['phone_numbers'] = Variable<String>(
          $ContactsTable.$converterphoneNumbers.toSql(phoneNumbers));
    }
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      id: Value(id),
      contactId: Value(contactId),
      displayName: Value(displayName),
      phoneNumbers: Value(phoneNumbers),
    );
  }

  factory Contact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contact(
      id: serializer.fromJson<int>(json['id']),
      contactId: serializer.fromJson<String>(json['contactId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      phoneNumbers: serializer.fromJson<List<String>>(json['phoneNumbers']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'contactId': serializer.toJson<String>(contactId),
      'displayName': serializer.toJson<String>(displayName),
      'phoneNumbers': serializer.toJson<List<String>>(phoneNumbers),
    };
  }

  Contact copyWith(
          {int? id,
          String? contactId,
          String? displayName,
          List<String>? phoneNumbers}) =>
      Contact(
        id: id ?? this.id,
        contactId: contactId ?? this.contactId,
        displayName: displayName ?? this.displayName,
        phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      );
  Contact copyWithCompanion(ContactsCompanion data) {
    return Contact(
      id: data.id.present ? data.id.value : this.id,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      phoneNumbers: data.phoneNumbers.present
          ? data.phoneNumbers.value
          : this.phoneNumbers,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Contact(')
          ..write('id: $id, ')
          ..write('contactId: $contactId, ')
          ..write('displayName: $displayName, ')
          ..write('phoneNumbers: $phoneNumbers')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, contactId, displayName, phoneNumbers);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contact &&
          other.id == this.id &&
          other.contactId == this.contactId &&
          other.displayName == this.displayName &&
          other.phoneNumbers == this.phoneNumbers);
}

class ContactsCompanion extends UpdateCompanion<Contact> {
  final Value<int> id;
  final Value<String> contactId;
  final Value<String> displayName;
  final Value<List<String>> phoneNumbers;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.contactId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.phoneNumbers = const Value.absent(),
  });
  ContactsCompanion.insert({
    this.id = const Value.absent(),
    required String contactId,
    required String displayName,
    required List<String> phoneNumbers,
  })  : contactId = Value(contactId),
        displayName = Value(displayName),
        phoneNumbers = Value(phoneNumbers);
  static Insertable<Contact> custom({
    Expression<int>? id,
    Expression<String>? contactId,
    Expression<String>? displayName,
    Expression<String>? phoneNumbers,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contactId != null) 'contact_id': contactId,
      if (displayName != null) 'display_name': displayName,
      if (phoneNumbers != null) 'phone_numbers': phoneNumbers,
    });
  }

  ContactsCompanion copyWith(
      {Value<int>? id,
      Value<String>? contactId,
      Value<String>? displayName,
      Value<List<String>>? phoneNumbers}) {
    return ContactsCompanion(
      id: id ?? this.id,
      contactId: contactId ?? this.contactId,
      displayName: displayName ?? this.displayName,
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<String>(contactId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (phoneNumbers.present) {
      map['phone_numbers'] = Variable<String>(
          $ContactsTable.$converterphoneNumbers.toSql(phoneNumbers.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('contactId: $contactId, ')
          ..write('displayName: $displayName, ')
          ..write('phoneNumbers: $phoneNumbers')
          ..write(')'))
        .toString();
  }
}

class $TrackGroupsTable extends TrackGroups
    with TableInfo<$TrackGroupsTable, TrackGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrackGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _frequencyMeta =
      const VerificationMeta('frequency');
  @override
  late final GeneratedColumn<int> frequency = GeneratedColumn<int>(
      'frequency', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, name, frequency];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'track_groups';
  @override
  VerificationContext validateIntegrity(Insertable<TrackGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrackGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackGroup(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      frequency: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}frequency'])!,
    );
  }

  @override
  $TrackGroupsTable createAlias(String alias) {
    return $TrackGroupsTable(attachedDatabase, alias);
  }
}

class TrackGroup extends DataClass implements Insertable<TrackGroup> {
  final int id;
  final String name;
  final int frequency;
  const TrackGroup(
      {required this.id, required this.name, required this.frequency});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['frequency'] = Variable<int>(frequency);
    return map;
  }

  TrackGroupsCompanion toCompanion(bool nullToAbsent) {
    return TrackGroupsCompanion(
      id: Value(id),
      name: Value(name),
      frequency: Value(frequency),
    );
  }

  factory TrackGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrackGroup(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      frequency: serializer.fromJson<int>(json['frequency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'frequency': serializer.toJson<int>(frequency),
    };
  }

  TrackGroup copyWith({int? id, String? name, int? frequency}) => TrackGroup(
        id: id ?? this.id,
        name: name ?? this.name,
        frequency: frequency ?? this.frequency,
      );
  TrackGroup copyWithCompanion(TrackGroupsCompanion data) {
    return TrackGroup(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrackGroup(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('frequency: $frequency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, frequency);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackGroup &&
          other.id == this.id &&
          other.name == this.name &&
          other.frequency == this.frequency);
}

class TrackGroupsCompanion extends UpdateCompanion<TrackGroup> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> frequency;
  const TrackGroupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.frequency = const Value.absent(),
  });
  TrackGroupsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.frequency = const Value.absent(),
  }) : name = Value(name);
  static Insertable<TrackGroup> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? frequency,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (frequency != null) 'frequency': frequency,
    });
  }

  TrackGroupsCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int>? frequency}) {
    return TrackGroupsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      frequency: frequency ?? this.frequency,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<int>(frequency.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackGroupsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('frequency: $frequency')
          ..write(')'))
        .toString();
  }
}

class $HistoriesTable extends Histories
    with TableInfo<$HistoriesTable, History> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _continuationMeta =
      const VerificationMeta('continuation');
  @override
  late final GeneratedColumn<int> continuation = GeneratedColumn<int>(
      'continuation', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, date, duration, continuation];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'histories';
  @override
  VerificationContext validateIntegrity(Insertable<History> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('continuation')) {
      context.handle(
          _continuationMeta,
          continuation.isAcceptableOrUnknown(
              data['continuation']!, _continuationMeta));
    } else if (isInserting) {
      context.missing(_continuationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  History map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return History(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration'])!,
      continuation: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}continuation'])!,
    );
  }

  @override
  $HistoriesTable createAlias(String alias) {
    return $HistoriesTable(attachedDatabase, alias);
  }
}

class History extends DataClass implements Insertable<History> {
  final int id;
  final DateTime date;
  final int duration;
  final int continuation;
  const History(
      {required this.id,
      required this.date,
      required this.duration,
      required this.continuation});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['duration'] = Variable<int>(duration);
    map['continuation'] = Variable<int>(continuation);
    return map;
  }

  HistoriesCompanion toCompanion(bool nullToAbsent) {
    return HistoriesCompanion(
      id: Value(id),
      date: Value(date),
      duration: Value(duration),
      continuation: Value(continuation),
    );
  }

  factory History.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return History(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      duration: serializer.fromJson<int>(json['duration']),
      continuation: serializer.fromJson<int>(json['continuation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'duration': serializer.toJson<int>(duration),
      'continuation': serializer.toJson<int>(continuation),
    };
  }

  History copyWith(
          {int? id, DateTime? date, int? duration, int? continuation}) =>
      History(
        id: id ?? this.id,
        date: date ?? this.date,
        duration: duration ?? this.duration,
        continuation: continuation ?? this.continuation,
      );
  History copyWithCompanion(HistoriesCompanion data) {
    return History(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      duration: data.duration.present ? data.duration.value : this.duration,
      continuation: data.continuation.present
          ? data.continuation.value
          : this.continuation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('History(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('duration: $duration, ')
          ..write('continuation: $continuation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, duration, continuation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is History &&
          other.id == this.id &&
          other.date == this.date &&
          other.duration == this.duration &&
          other.continuation == this.continuation);
}

class HistoriesCompanion extends UpdateCompanion<History> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> duration;
  final Value<int> continuation;
  const HistoriesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.duration = const Value.absent(),
    this.continuation = const Value.absent(),
  });
  HistoriesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required int duration,
    required int continuation,
  })  : date = Value(date),
        duration = Value(duration),
        continuation = Value(continuation);
  static Insertable<History> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? duration,
    Expression<int>? continuation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (duration != null) 'duration': duration,
      if (continuation != null) 'continuation': continuation,
    });
  }

  HistoriesCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<int>? duration,
      Value<int>? continuation}) {
    return HistoriesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      duration: duration ?? this.duration,
      continuation: continuation ?? this.continuation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (continuation.present) {
      map['continuation'] = Variable<int>(continuation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoriesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('duration: $duration, ')
          ..write('continuation: $continuation')
          ..write(')'))
        .toString();
  }
}

class $TrackGroupContactsTable extends TrackGroupContacts
    with TableInfo<$TrackGroupContactsTable, TrackGroupContact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrackGroupContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _trackGroupIdMeta =
      const VerificationMeta('trackGroupId');
  @override
  late final GeneratedColumn<int> trackGroupId = GeneratedColumn<int>(
      'track_group_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES track_groups (id) ON DELETE CASCADE'));
  static const VerificationMeta _contactIdMeta =
      const VerificationMeta('contactId');
  @override
  late final GeneratedColumn<int> contactId = GeneratedColumn<int>(
      'contact_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES contacts (id) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns => [trackGroupId, contactId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'track_group_contacts';
  @override
  VerificationContext validateIntegrity(Insertable<TrackGroupContact> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('track_group_id')) {
      context.handle(
          _trackGroupIdMeta,
          trackGroupId.isAcceptableOrUnknown(
              data['track_group_id']!, _trackGroupIdMeta));
    } else if (isInserting) {
      context.missing(_trackGroupIdMeta);
    }
    if (data.containsKey('contact_id')) {
      context.handle(_contactIdMeta,
          contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta));
    } else if (isInserting) {
      context.missing(_contactIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {trackGroupId, contactId};
  @override
  TrackGroupContact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackGroupContact(
      trackGroupId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}track_group_id'])!,
      contactId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}contact_id'])!,
    );
  }

  @override
  $TrackGroupContactsTable createAlias(String alias) {
    return $TrackGroupContactsTable(attachedDatabase, alias);
  }
}

class TrackGroupContact extends DataClass
    implements Insertable<TrackGroupContact> {
  final int trackGroupId;
  final int contactId;
  const TrackGroupContact(
      {required this.trackGroupId, required this.contactId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['track_group_id'] = Variable<int>(trackGroupId);
    map['contact_id'] = Variable<int>(contactId);
    return map;
  }

  TrackGroupContactsCompanion toCompanion(bool nullToAbsent) {
    return TrackGroupContactsCompanion(
      trackGroupId: Value(trackGroupId),
      contactId: Value(contactId),
    );
  }

  factory TrackGroupContact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrackGroupContact(
      trackGroupId: serializer.fromJson<int>(json['trackGroupId']),
      contactId: serializer.fromJson<int>(json['contactId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'trackGroupId': serializer.toJson<int>(trackGroupId),
      'contactId': serializer.toJson<int>(contactId),
    };
  }

  TrackGroupContact copyWith({int? trackGroupId, int? contactId}) =>
      TrackGroupContact(
        trackGroupId: trackGroupId ?? this.trackGroupId,
        contactId: contactId ?? this.contactId,
      );
  TrackGroupContact copyWithCompanion(TrackGroupContactsCompanion data) {
    return TrackGroupContact(
      trackGroupId: data.trackGroupId.present
          ? data.trackGroupId.value
          : this.trackGroupId,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrackGroupContact(')
          ..write('trackGroupId: $trackGroupId, ')
          ..write('contactId: $contactId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(trackGroupId, contactId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackGroupContact &&
          other.trackGroupId == this.trackGroupId &&
          other.contactId == this.contactId);
}

class TrackGroupContactsCompanion extends UpdateCompanion<TrackGroupContact> {
  final Value<int> trackGroupId;
  final Value<int> contactId;
  final Value<int> rowid;
  const TrackGroupContactsCompanion({
    this.trackGroupId = const Value.absent(),
    this.contactId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrackGroupContactsCompanion.insert({
    required int trackGroupId,
    required int contactId,
    this.rowid = const Value.absent(),
  })  : trackGroupId = Value(trackGroupId),
        contactId = Value(contactId);
  static Insertable<TrackGroupContact> custom({
    Expression<int>? trackGroupId,
    Expression<int>? contactId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (trackGroupId != null) 'track_group_id': trackGroupId,
      if (contactId != null) 'contact_id': contactId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrackGroupContactsCompanion copyWith(
      {Value<int>? trackGroupId, Value<int>? contactId, Value<int>? rowid}) {
    return TrackGroupContactsCompanion(
      trackGroupId: trackGroupId ?? this.trackGroupId,
      contactId: contactId ?? this.contactId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (trackGroupId.present) {
      map['track_group_id'] = Variable<int>(trackGroupId.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<int>(contactId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackGroupContactsCompanion(')
          ..write('trackGroupId: $trackGroupId, ')
          ..write('contactId: $contactId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TrackGroupHistoriesTable extends TrackGroupHistories
    with TableInfo<$TrackGroupHistoriesTable, TrackGroupHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrackGroupHistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _trackGroupIdMeta =
      const VerificationMeta('trackGroupId');
  @override
  late final GeneratedColumn<int> trackGroupId = GeneratedColumn<int>(
      'track_group_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES track_groups (id) ON DELETE CASCADE'));
  static const VerificationMeta _historyIdMeta =
      const VerificationMeta('historyId');
  @override
  late final GeneratedColumn<int> historyId = GeneratedColumn<int>(
      'history_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES histories (id) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns => [trackGroupId, historyId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'track_group_histories';
  @override
  VerificationContext validateIntegrity(Insertable<TrackGroupHistory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('track_group_id')) {
      context.handle(
          _trackGroupIdMeta,
          trackGroupId.isAcceptableOrUnknown(
              data['track_group_id']!, _trackGroupIdMeta));
    } else if (isInserting) {
      context.missing(_trackGroupIdMeta);
    }
    if (data.containsKey('history_id')) {
      context.handle(_historyIdMeta,
          historyId.isAcceptableOrUnknown(data['history_id']!, _historyIdMeta));
    } else if (isInserting) {
      context.missing(_historyIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {trackGroupId, historyId};
  @override
  TrackGroupHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackGroupHistory(
      trackGroupId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}track_group_id'])!,
      historyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}history_id'])!,
    );
  }

  @override
  $TrackGroupHistoriesTable createAlias(String alias) {
    return $TrackGroupHistoriesTable(attachedDatabase, alias);
  }
}

class TrackGroupHistory extends DataClass
    implements Insertable<TrackGroupHistory> {
  final int trackGroupId;
  final int historyId;
  const TrackGroupHistory(
      {required this.trackGroupId, required this.historyId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['track_group_id'] = Variable<int>(trackGroupId);
    map['history_id'] = Variable<int>(historyId);
    return map;
  }

  TrackGroupHistoriesCompanion toCompanion(bool nullToAbsent) {
    return TrackGroupHistoriesCompanion(
      trackGroupId: Value(trackGroupId),
      historyId: Value(historyId),
    );
  }

  factory TrackGroupHistory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrackGroupHistory(
      trackGroupId: serializer.fromJson<int>(json['trackGroupId']),
      historyId: serializer.fromJson<int>(json['historyId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'trackGroupId': serializer.toJson<int>(trackGroupId),
      'historyId': serializer.toJson<int>(historyId),
    };
  }

  TrackGroupHistory copyWith({int? trackGroupId, int? historyId}) =>
      TrackGroupHistory(
        trackGroupId: trackGroupId ?? this.trackGroupId,
        historyId: historyId ?? this.historyId,
      );
  TrackGroupHistory copyWithCompanion(TrackGroupHistoriesCompanion data) {
    return TrackGroupHistory(
      trackGroupId: data.trackGroupId.present
          ? data.trackGroupId.value
          : this.trackGroupId,
      historyId: data.historyId.present ? data.historyId.value : this.historyId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrackGroupHistory(')
          ..write('trackGroupId: $trackGroupId, ')
          ..write('historyId: $historyId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(trackGroupId, historyId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackGroupHistory &&
          other.trackGroupId == this.trackGroupId &&
          other.historyId == this.historyId);
}

class TrackGroupHistoriesCompanion extends UpdateCompanion<TrackGroupHistory> {
  final Value<int> trackGroupId;
  final Value<int> historyId;
  final Value<int> rowid;
  const TrackGroupHistoriesCompanion({
    this.trackGroupId = const Value.absent(),
    this.historyId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrackGroupHistoriesCompanion.insert({
    required int trackGroupId,
    required int historyId,
    this.rowid = const Value.absent(),
  })  : trackGroupId = Value(trackGroupId),
        historyId = Value(historyId);
  static Insertable<TrackGroupHistory> custom({
    Expression<int>? trackGroupId,
    Expression<int>? historyId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (trackGroupId != null) 'track_group_id': trackGroupId,
      if (historyId != null) 'history_id': historyId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrackGroupHistoriesCompanion copyWith(
      {Value<int>? trackGroupId, Value<int>? historyId, Value<int>? rowid}) {
    return TrackGroupHistoriesCompanion(
      trackGroupId: trackGroupId ?? this.trackGroupId,
      historyId: historyId ?? this.historyId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (trackGroupId.present) {
      map['track_group_id'] = Variable<int>(trackGroupId.value);
    }
    if (historyId.present) {
      map['history_id'] = Variable<int>(historyId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackGroupHistoriesCompanion(')
          ..write('trackGroupId: $trackGroupId, ')
          ..write('historyId: $historyId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $TrackGroupsTable trackGroups = $TrackGroupsTable(this);
  late final $HistoriesTable histories = $HistoriesTable(this);
  late final $TrackGroupContactsTable trackGroupContacts =
      $TrackGroupContactsTable(this);
  late final $TrackGroupHistoriesTable trackGroupHistories =
      $TrackGroupHistoriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        appSettings,
        contacts,
        trackGroups,
        histories,
        trackGroupContacts,
        trackGroupHistories
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('track_groups',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('track_group_contacts', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('contacts',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('track_group_contacts', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('track_groups',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('track_group_histories', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('histories',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('track_group_histories', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$AppSettingsTableCreateCompanionBuilder = AppSettingsCompanion
    Function({
  Value<int> id,
  Value<DateTime?> firstLaunchDate,
});
typedef $$AppSettingsTableUpdateCompanionBuilder = AppSettingsCompanion
    Function({
  Value<int> id,
  Value<DateTime?> firstLaunchDate,
});

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get firstLaunchDate => $composableBuilder(
      column: $table.firstLaunchDate,
      builder: (column) => ColumnFilters(column));
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get firstLaunchDate => $composableBuilder(
      column: $table.firstLaunchDate,
      builder: (column) => ColumnOrderings(column));
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get firstLaunchDate => $composableBuilder(
      column: $table.firstLaunchDate, builder: (column) => column);
}

class $$AppSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableAnnotationComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder,
    (AppSetting, BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>),
    AppSetting,
    PrefetchHooks Function()> {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime?> firstLaunchDate = const Value.absent(),
          }) =>
              AppSettingsCompanion(
            id: id,
            firstLaunchDate: firstLaunchDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime?> firstLaunchDate = const Value.absent(),
          }) =>
              AppSettingsCompanion.insert(
            id: id,
            firstLaunchDate: firstLaunchDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppSettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableAnnotationComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder,
    (AppSetting, BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>),
    AppSetting,
    PrefetchHooks Function()>;
typedef $$ContactsTableCreateCompanionBuilder = ContactsCompanion Function({
  Value<int> id,
  required String contactId,
  required String displayName,
  required List<String> phoneNumbers,
});
typedef $$ContactsTableUpdateCompanionBuilder = ContactsCompanion Function({
  Value<int> id,
  Value<String> contactId,
  Value<String> displayName,
  Value<List<String>> phoneNumbers,
});

final class $$ContactsTableReferences
    extends BaseReferences<_$AppDatabase, $ContactsTable, Contact> {
  $$ContactsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TrackGroupContactsTable, List<TrackGroupContact>>
      _trackGroupContactsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.trackGroupContacts,
              aliasName: $_aliasNameGenerator(
                  db.contacts.id, db.trackGroupContacts.contactId));

  $$TrackGroupContactsTableProcessedTableManager get trackGroupContactsRefs {
    final manager =
        $$TrackGroupContactsTableTableManager($_db, $_db.trackGroupContacts)
            .filter((f) => f.contactId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_trackGroupContactsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ContactsTableFilterComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contactId => $composableBuilder(
      column: $table.contactId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get phoneNumbers => $composableBuilder(
          column: $table.phoneNumbers,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  Expression<bool> trackGroupContactsRefs(
      Expression<bool> Function($$TrackGroupContactsTableFilterComposer f) f) {
    final $$TrackGroupContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.trackGroupContacts,
        getReferencedColumn: (t) => t.contactId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TrackGroupContactsTableFilterComposer(
              $db: $db,
              $table: $db.trackGroupContacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contactId => $composableBuilder(
      column: $table.contactId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phoneNumbers => $composableBuilder(
      column: $table.phoneNumbers,
      builder: (column) => ColumnOrderings(column));
}

class $$ContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contactId =>
      $composableBuilder(column: $table.contactId, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get phoneNumbers =>
      $composableBuilder(
          column: $table.phoneNumbers, builder: (column) => column);

  Expression<T> trackGroupContactsRefs<T extends Object>(
      Expression<T> Function($$TrackGroupContactsTableAnnotationComposer a) f) {
    final $$TrackGroupContactsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.trackGroupContacts,
            getReferencedColumn: (t) => t.contactId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TrackGroupContactsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.trackGroupContacts,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ContactsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContactsTable,
    Contact,
    $$ContactsTableFilterComposer,
    $$ContactsTableOrderingComposer,
    $$ContactsTableAnnotationComposer,
    $$ContactsTableCreateCompanionBuilder,
    $$ContactsTableUpdateCompanionBuilder,
    (Contact, $$ContactsTableReferences),
    Contact,
    PrefetchHooks Function({bool trackGroupContactsRefs})> {
  $$ContactsTableTableManager(_$AppDatabase db, $ContactsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> contactId = const Value.absent(),
            Value<String> displayName = const Value.absent(),
            Value<List<String>> phoneNumbers = const Value.absent(),
          }) =>
              ContactsCompanion(
            id: id,
            contactId: contactId,
            displayName: displayName,
            phoneNumbers: phoneNumbers,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String contactId,
            required String displayName,
            required List<String> phoneNumbers,
          }) =>
              ContactsCompanion.insert(
            id: id,
            contactId: contactId,
            displayName: displayName,
            phoneNumbers: phoneNumbers,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ContactsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({trackGroupContactsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (trackGroupContactsRefs) db.trackGroupContacts
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (trackGroupContactsRefs)
                    await $_getPrefetchedData<Contact, $ContactsTable,
                            TrackGroupContact>(
                        currentTable: table,
                        referencedTable: $$ContactsTableReferences
                            ._trackGroupContactsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ContactsTableReferences(db, table, p0)
                                .trackGroupContactsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.contactId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ContactsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ContactsTable,
    Contact,
    $$ContactsTableFilterComposer,
    $$ContactsTableOrderingComposer,
    $$ContactsTableAnnotationComposer,
    $$ContactsTableCreateCompanionBuilder,
    $$ContactsTableUpdateCompanionBuilder,
    (Contact, $$ContactsTableReferences),
    Contact,
    PrefetchHooks Function({bool trackGroupContactsRefs})>;
typedef $$TrackGroupsTableCreateCompanionBuilder = TrackGroupsCompanion
    Function({
  Value<int> id,
  required String name,
  Value<int> frequency,
});
typedef $$TrackGroupsTableUpdateCompanionBuilder = TrackGroupsCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<int> frequency,
});

final class $$TrackGroupsTableReferences
    extends BaseReferences<_$AppDatabase, $TrackGroupsTable, TrackGroup> {
  $$TrackGroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TrackGroupContactsTable, List<TrackGroupContact>>
      _trackGroupContactsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.trackGroupContacts,
              aliasName: $_aliasNameGenerator(
                  db.trackGroups.id, db.trackGroupContacts.trackGroupId));

  $$TrackGroupContactsTableProcessedTableManager get trackGroupContactsRefs {
    final manager = $$TrackGroupContactsTableTableManager(
            $_db, $_db.trackGroupContacts)
        .filter((f) => f.trackGroupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_trackGroupContactsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TrackGroupHistoriesTable, List<TrackGroupHistory>>
      _trackGroupHistoriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.trackGroupHistories,
              aliasName: $_aliasNameGenerator(
                  db.trackGroups.id, db.trackGroupHistories.trackGroupId));

  $$TrackGroupHistoriesTableProcessedTableManager get trackGroupHistoriesRefs {
    final manager = $$TrackGroupHistoriesTableTableManager(
            $_db, $_db.trackGroupHistories)
        .filter((f) => f.trackGroupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_trackGroupHistoriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TrackGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $TrackGroupsTable> {
  $$TrackGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnFilters(column));

  Expression<bool> trackGroupContactsRefs(
      Expression<bool> Function($$TrackGroupContactsTableFilterComposer f) f) {
    final $$TrackGroupContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.trackGroupContacts,
        getReferencedColumn: (t) => t.trackGroupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TrackGroupContactsTableFilterComposer(
              $db: $db,
              $table: $db.trackGroupContacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> trackGroupHistoriesRefs(
      Expression<bool> Function($$TrackGroupHistoriesTableFilterComposer f) f) {
    final $$TrackGroupHistoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.trackGroupHistories,
        getReferencedColumn: (t) => t.trackGroupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TrackGroupHistoriesTableFilterComposer(
              $db: $db,
              $table: $db.trackGroupHistories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TrackGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $TrackGroupsTable> {
  $$TrackGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnOrderings(column));
}

class $$TrackGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrackGroupsTable> {
  $$TrackGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  Expression<T> trackGroupContactsRefs<T extends Object>(
      Expression<T> Function($$TrackGroupContactsTableAnnotationComposer a) f) {
    final $$TrackGroupContactsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.trackGroupContacts,
            getReferencedColumn: (t) => t.trackGroupId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TrackGroupContactsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.trackGroupContacts,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> trackGroupHistoriesRefs<T extends Object>(
      Expression<T> Function($$TrackGroupHistoriesTableAnnotationComposer a)
          f) {
    final $$TrackGroupHistoriesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.trackGroupHistories,
            getReferencedColumn: (t) => t.trackGroupId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TrackGroupHistoriesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.trackGroupHistories,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$TrackGroupsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TrackGroupsTable,
    TrackGroup,
    $$TrackGroupsTableFilterComposer,
    $$TrackGroupsTableOrderingComposer,
    $$TrackGroupsTableAnnotationComposer,
    $$TrackGroupsTableCreateCompanionBuilder,
    $$TrackGroupsTableUpdateCompanionBuilder,
    (TrackGroup, $$TrackGroupsTableReferences),
    TrackGroup,
    PrefetchHooks Function(
        {bool trackGroupContactsRefs, bool trackGroupHistoriesRefs})> {
  $$TrackGroupsTableTableManager(_$AppDatabase db, $TrackGroupsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrackGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrackGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrackGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> frequency = const Value.absent(),
          }) =>
              TrackGroupsCompanion(
            id: id,
            name: name,
            frequency: frequency,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<int> frequency = const Value.absent(),
          }) =>
              TrackGroupsCompanion.insert(
            id: id,
            name: name,
            frequency: frequency,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TrackGroupsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {trackGroupContactsRefs = false,
              trackGroupHistoriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (trackGroupContactsRefs) db.trackGroupContacts,
                if (trackGroupHistoriesRefs) db.trackGroupHistories
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (trackGroupContactsRefs)
                    await $_getPrefetchedData<TrackGroup, $TrackGroupsTable,
                            TrackGroupContact>(
                        currentTable: table,
                        referencedTable: $$TrackGroupsTableReferences
                            ._trackGroupContactsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TrackGroupsTableReferences(db, table, p0)
                                .trackGroupContactsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.trackGroupId == item.id),
                        typedResults: items),
                  if (trackGroupHistoriesRefs)
                    await $_getPrefetchedData<TrackGroup, $TrackGroupsTable,
                            TrackGroupHistory>(
                        currentTable: table,
                        referencedTable: $$TrackGroupsTableReferences
                            ._trackGroupHistoriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TrackGroupsTableReferences(db, table, p0)
                                .trackGroupHistoriesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.trackGroupId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TrackGroupsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TrackGroupsTable,
    TrackGroup,
    $$TrackGroupsTableFilterComposer,
    $$TrackGroupsTableOrderingComposer,
    $$TrackGroupsTableAnnotationComposer,
    $$TrackGroupsTableCreateCompanionBuilder,
    $$TrackGroupsTableUpdateCompanionBuilder,
    (TrackGroup, $$TrackGroupsTableReferences),
    TrackGroup,
    PrefetchHooks Function(
        {bool trackGroupContactsRefs, bool trackGroupHistoriesRefs})>;
typedef $$HistoriesTableCreateCompanionBuilder = HistoriesCompanion Function({
  Value<int> id,
  required DateTime date,
  required int duration,
  required int continuation,
});
typedef $$HistoriesTableUpdateCompanionBuilder = HistoriesCompanion Function({
  Value<int> id,
  Value<DateTime> date,
  Value<int> duration,
  Value<int> continuation,
});

final class $$HistoriesTableReferences
    extends BaseReferences<_$AppDatabase, $HistoriesTable, History> {
  $$HistoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TrackGroupHistoriesTable, List<TrackGroupHistory>>
      _trackGroupHistoriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.trackGroupHistories,
              aliasName: $_aliasNameGenerator(
                  db.histories.id, db.trackGroupHistories.historyId));

  $$TrackGroupHistoriesTableProcessedTableManager get trackGroupHistoriesRefs {
    final manager =
        $$TrackGroupHistoriesTableTableManager($_db, $_db.trackGroupHistories)
            .filter((f) => f.historyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_trackGroupHistoriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$HistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $HistoriesTable> {
  $$HistoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get continuation => $composableBuilder(
      column: $table.continuation, builder: (column) => ColumnFilters(column));

  Expression<bool> trackGroupHistoriesRefs(
      Expression<bool> Function($$TrackGroupHistoriesTableFilterComposer f) f) {
    final $$TrackGroupHistoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.trackGroupHistories,
        getReferencedColumn: (t) => t.historyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TrackGroupHistoriesTableFilterComposer(
              $db: $db,
              $table: $db.trackGroupHistories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$HistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $HistoriesTable> {
  $$HistoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get continuation => $composableBuilder(
      column: $table.continuation,
      builder: (column) => ColumnOrderings(column));
}

class $$HistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HistoriesTable> {
  $$HistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<int> get continuation => $composableBuilder(
      column: $table.continuation, builder: (column) => column);

  Expression<T> trackGroupHistoriesRefs<T extends Object>(
      Expression<T> Function($$TrackGroupHistoriesTableAnnotationComposer a)
          f) {
    final $$TrackGroupHistoriesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.trackGroupHistories,
            getReferencedColumn: (t) => t.historyId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TrackGroupHistoriesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.trackGroupHistories,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$HistoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HistoriesTable,
    History,
    $$HistoriesTableFilterComposer,
    $$HistoriesTableOrderingComposer,
    $$HistoriesTableAnnotationComposer,
    $$HistoriesTableCreateCompanionBuilder,
    $$HistoriesTableUpdateCompanionBuilder,
    (History, $$HistoriesTableReferences),
    History,
    PrefetchHooks Function({bool trackGroupHistoriesRefs})> {
  $$HistoriesTableTableManager(_$AppDatabase db, $HistoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HistoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HistoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> duration = const Value.absent(),
            Value<int> continuation = const Value.absent(),
          }) =>
              HistoriesCompanion(
            id: id,
            date: date,
            duration: duration,
            continuation: continuation,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime date,
            required int duration,
            required int continuation,
          }) =>
              HistoriesCompanion.insert(
            id: id,
            date: date,
            duration: duration,
            continuation: continuation,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$HistoriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({trackGroupHistoriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (trackGroupHistoriesRefs) db.trackGroupHistories
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (trackGroupHistoriesRefs)
                    await $_getPrefetchedData<History, $HistoriesTable,
                            TrackGroupHistory>(
                        currentTable: table,
                        referencedTable: $$HistoriesTableReferences
                            ._trackGroupHistoriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$HistoriesTableReferences(db, table, p0)
                                .trackGroupHistoriesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.historyId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$HistoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HistoriesTable,
    History,
    $$HistoriesTableFilterComposer,
    $$HistoriesTableOrderingComposer,
    $$HistoriesTableAnnotationComposer,
    $$HistoriesTableCreateCompanionBuilder,
    $$HistoriesTableUpdateCompanionBuilder,
    (History, $$HistoriesTableReferences),
    History,
    PrefetchHooks Function({bool trackGroupHistoriesRefs})>;
typedef $$TrackGroupContactsTableCreateCompanionBuilder
    = TrackGroupContactsCompanion Function({
  required int trackGroupId,
  required int contactId,
  Value<int> rowid,
});
typedef $$TrackGroupContactsTableUpdateCompanionBuilder
    = TrackGroupContactsCompanion Function({
  Value<int> trackGroupId,
  Value<int> contactId,
  Value<int> rowid,
});

final class $$TrackGroupContactsTableReferences extends BaseReferences<
    _$AppDatabase, $TrackGroupContactsTable, TrackGroupContact> {
  $$TrackGroupContactsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TrackGroupsTable _trackGroupIdTable(_$AppDatabase db) =>
      db.trackGroups.createAlias($_aliasNameGenerator(
          db.trackGroupContacts.trackGroupId, db.trackGroups.id));

  $$TrackGroupsTableProcessedTableManager get trackGroupId {
    final $_column = $_itemColumn<int>('track_group_id')!;

    final manager = $$TrackGroupsTableTableManager($_db, $_db.trackGroups)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trackGroupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ContactsTable _contactIdTable(_$AppDatabase db) =>
      db.contacts.createAlias($_aliasNameGenerator(
          db.trackGroupContacts.contactId, db.contacts.id));

  $$ContactsTableProcessedTableManager get contactId {
    final $_column = $_itemColumn<int>('contact_id')!;

    final manager = $$ContactsTableTableManager($_db, $_db.contacts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contactIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TrackGroupContactsTableFilterComposer
    extends Composer<_$AppDatabase, $TrackGroupContactsTable> {
  $$TrackGroupContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TrackGroupsTableFilterComposer get trackGroupId {
    final $$TrackGroupsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trackGroupId,
        referencedTable: $db.trackGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TrackGroupsTableFilterComposer(
              $db: $db,
              $table: $db.trackGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactsTableFilterComposer get contactId {
    final $$ContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableFilterComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TrackGroupContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $TrackGroupContactsTable> {
  $$TrackGroupContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TrackGroupsTableOrderingComposer get trackGroupId {
    final $$TrackGroupsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trackGroupId,
        referencedTable: $db.trackGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TrackGroupsTableOrderingComposer(
              $db: $db,
              $table: $db.trackGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactsTableOrderingComposer get contactId {
    final $$ContactsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableOrderingComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TrackGroupContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrackGroupContactsTable> {
  $$TrackGroupContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TrackGroupsTableAnnotationComposer get trackGroupId {
    final $$TrackGroupsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trackGroupId,
        referencedTable: $db.trackGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TrackGroupsTableAnnotationComposer(
              $db: $db,
              $table: $db.trackGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactsTableAnnotationComposer get contactId {
    final $$ContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TrackGroupContactsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TrackGroupContactsTable,
    TrackGroupContact,
    $$TrackGroupContactsTableFilterComposer,
    $$TrackGroupContactsTableOrderingComposer,
    $$TrackGroupContactsTableAnnotationComposer,
    $$TrackGroupContactsTableCreateCompanionBuilder,
    $$TrackGroupContactsTableUpdateCompanionBuilder,
    (TrackGroupContact, $$TrackGroupContactsTableReferences),
    TrackGroupContact,
    PrefetchHooks Function({bool trackGroupId, bool contactId})> {
  $$TrackGroupContactsTableTableManager(
      _$AppDatabase db, $TrackGroupContactsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrackGroupContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrackGroupContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrackGroupContactsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> trackGroupId = const Value.absent(),
            Value<int> contactId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TrackGroupContactsCompanion(
            trackGroupId: trackGroupId,
            contactId: contactId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int trackGroupId,
            required int contactId,
            Value<int> rowid = const Value.absent(),
          }) =>
              TrackGroupContactsCompanion.insert(
            trackGroupId: trackGroupId,
            contactId: contactId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TrackGroupContactsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({trackGroupId = false, contactId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (trackGroupId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.trackGroupId,
                    referencedTable: $$TrackGroupContactsTableReferences
                        ._trackGroupIdTable(db),
                    referencedColumn: $$TrackGroupContactsTableReferences
                        ._trackGroupIdTable(db)
                        .id,
                  ) as T;
                }
                if (contactId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.contactId,
                    referencedTable:
                        $$TrackGroupContactsTableReferences._contactIdTable(db),
                    referencedColumn: $$TrackGroupContactsTableReferences
                        ._contactIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TrackGroupContactsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TrackGroupContactsTable,
    TrackGroupContact,
    $$TrackGroupContactsTableFilterComposer,
    $$TrackGroupContactsTableOrderingComposer,
    $$TrackGroupContactsTableAnnotationComposer,
    $$TrackGroupContactsTableCreateCompanionBuilder,
    $$TrackGroupContactsTableUpdateCompanionBuilder,
    (TrackGroupContact, $$TrackGroupContactsTableReferences),
    TrackGroupContact,
    PrefetchHooks Function({bool trackGroupId, bool contactId})>;
typedef $$TrackGroupHistoriesTableCreateCompanionBuilder
    = TrackGroupHistoriesCompanion Function({
  required int trackGroupId,
  required int historyId,
  Value<int> rowid,
});
typedef $$TrackGroupHistoriesTableUpdateCompanionBuilder
    = TrackGroupHistoriesCompanion Function({
  Value<int> trackGroupId,
  Value<int> historyId,
  Value<int> rowid,
});

final class $$TrackGroupHistoriesTableReferences extends BaseReferences<
    _$AppDatabase, $TrackGroupHistoriesTable, TrackGroupHistory> {
  $$TrackGroupHistoriesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TrackGroupsTable _trackGroupIdTable(_$AppDatabase db) =>
      db.trackGroups.createAlias($_aliasNameGenerator(
          db.trackGroupHistories.trackGroupId, db.trackGroups.id));

  $$TrackGroupsTableProcessedTableManager get trackGroupId {
    final $_column = $_itemColumn<int>('track_group_id')!;

    final manager = $$TrackGroupsTableTableManager($_db, $_db.trackGroups)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trackGroupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $HistoriesTable _historyIdTable(_$AppDatabase db) =>
      db.histories.createAlias($_aliasNameGenerator(
          db.trackGroupHistories.historyId, db.histories.id));

  $$HistoriesTableProcessedTableManager get historyId {
    final $_column = $_itemColumn<int>('history_id')!;

    final manager = $$HistoriesTableTableManager($_db, $_db.histories)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_historyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TrackGroupHistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $TrackGroupHistoriesTable> {
  $$TrackGroupHistoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TrackGroupsTableFilterComposer get trackGroupId {
    final $$TrackGroupsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trackGroupId,
        referencedTable: $db.trackGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TrackGroupsTableFilterComposer(
              $db: $db,
              $table: $db.trackGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$HistoriesTableFilterComposer get historyId {
    final $$HistoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.historyId,
        referencedTable: $db.histories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HistoriesTableFilterComposer(
              $db: $db,
              $table: $db.histories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TrackGroupHistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $TrackGroupHistoriesTable> {
  $$TrackGroupHistoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TrackGroupsTableOrderingComposer get trackGroupId {
    final $$TrackGroupsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trackGroupId,
        referencedTable: $db.trackGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TrackGroupsTableOrderingComposer(
              $db: $db,
              $table: $db.trackGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$HistoriesTableOrderingComposer get historyId {
    final $$HistoriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.historyId,
        referencedTable: $db.histories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HistoriesTableOrderingComposer(
              $db: $db,
              $table: $db.histories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TrackGroupHistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrackGroupHistoriesTable> {
  $$TrackGroupHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TrackGroupsTableAnnotationComposer get trackGroupId {
    final $$TrackGroupsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trackGroupId,
        referencedTable: $db.trackGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TrackGroupsTableAnnotationComposer(
              $db: $db,
              $table: $db.trackGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$HistoriesTableAnnotationComposer get historyId {
    final $$HistoriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.historyId,
        referencedTable: $db.histories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HistoriesTableAnnotationComposer(
              $db: $db,
              $table: $db.histories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TrackGroupHistoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TrackGroupHistoriesTable,
    TrackGroupHistory,
    $$TrackGroupHistoriesTableFilterComposer,
    $$TrackGroupHistoriesTableOrderingComposer,
    $$TrackGroupHistoriesTableAnnotationComposer,
    $$TrackGroupHistoriesTableCreateCompanionBuilder,
    $$TrackGroupHistoriesTableUpdateCompanionBuilder,
    (TrackGroupHistory, $$TrackGroupHistoriesTableReferences),
    TrackGroupHistory,
    PrefetchHooks Function({bool trackGroupId, bool historyId})> {
  $$TrackGroupHistoriesTableTableManager(
      _$AppDatabase db, $TrackGroupHistoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrackGroupHistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrackGroupHistoriesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrackGroupHistoriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> trackGroupId = const Value.absent(),
            Value<int> historyId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TrackGroupHistoriesCompanion(
            trackGroupId: trackGroupId,
            historyId: historyId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int trackGroupId,
            required int historyId,
            Value<int> rowid = const Value.absent(),
          }) =>
              TrackGroupHistoriesCompanion.insert(
            trackGroupId: trackGroupId,
            historyId: historyId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TrackGroupHistoriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({trackGroupId = false, historyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (trackGroupId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.trackGroupId,
                    referencedTable: $$TrackGroupHistoriesTableReferences
                        ._trackGroupIdTable(db),
                    referencedColumn: $$TrackGroupHistoriesTableReferences
                        ._trackGroupIdTable(db)
                        .id,
                  ) as T;
                }
                if (historyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.historyId,
                    referencedTable: $$TrackGroupHistoriesTableReferences
                        ._historyIdTable(db),
                    referencedColumn: $$TrackGroupHistoriesTableReferences
                        ._historyIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TrackGroupHistoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TrackGroupHistoriesTable,
    TrackGroupHistory,
    $$TrackGroupHistoriesTableFilterComposer,
    $$TrackGroupHistoriesTableOrderingComposer,
    $$TrackGroupHistoriesTableAnnotationComposer,
    $$TrackGroupHistoriesTableCreateCompanionBuilder,
    $$TrackGroupHistoriesTableUpdateCompanionBuilder,
    (TrackGroupHistory, $$TrackGroupHistoriesTableReferences),
    TrackGroupHistory,
    PrefetchHooks Function({bool trackGroupId, bool historyId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$ContactsTableTableManager get contacts =>
      $$ContactsTableTableManager(_db, _db.contacts);
  $$TrackGroupsTableTableManager get trackGroups =>
      $$TrackGroupsTableTableManager(_db, _db.trackGroups);
  $$HistoriesTableTableManager get histories =>
      $$HistoriesTableTableManager(_db, _db.histories);
  $$TrackGroupContactsTableTableManager get trackGroupContacts =>
      $$TrackGroupContactsTableTableManager(_db, _db.trackGroupContacts);
  $$TrackGroupHistoriesTableTableManager get trackGroupHistories =>
      $$TrackGroupHistoriesTableTableManager(_db, _db.trackGroupHistories);
}
