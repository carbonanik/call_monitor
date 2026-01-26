// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TrackedContactsTable extends TrackedContacts
    with TableInfo<$TrackedContactsTable, TrackedContact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrackedContactsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
      'phone_number', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nicknameMeta =
      const VerificationMeta('nickname');
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
      'nickname', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _frequencyDaysMeta =
      const VerificationMeta('frequencyDays');
  @override
  late final GeneratedColumn<int> frequencyDays = GeneratedColumn<int>(
      'frequency_days', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(7));
  static const VerificationMeta _lastCalledMeta =
      const VerificationMeta('lastCalled');
  @override
  late final GeneratedColumn<DateTime> lastCalled = GeneratedColumn<DateTime>(
      'last_called', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _remindersEnabledMeta =
      const VerificationMeta('remindersEnabled');
  @override
  late final GeneratedColumn<bool> remindersEnabled = GeneratedColumn<bool>(
      'reminders_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("reminders_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _lastNotifiedMeta =
      const VerificationMeta('lastNotified');
  @override
  late final GeneratedColumn<DateTime> lastNotified = GeneratedColumn<DateTime>(
      'last_notified', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        phoneNumber,
        nickname,
        frequencyDays,
        lastCalled,
        remindersEnabled,
        lastNotified,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tracked_contacts';
  @override
  VerificationContext validateIntegrity(Insertable<TrackedContact> instance,
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
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('nickname')) {
      context.handle(_nicknameMeta,
          nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta));
    }
    if (data.containsKey('frequency_days')) {
      context.handle(
          _frequencyDaysMeta,
          frequencyDays.isAcceptableOrUnknown(
              data['frequency_days']!, _frequencyDaysMeta));
    }
    if (data.containsKey('last_called')) {
      context.handle(
          _lastCalledMeta,
          lastCalled.isAcceptableOrUnknown(
              data['last_called']!, _lastCalledMeta));
    }
    if (data.containsKey('reminders_enabled')) {
      context.handle(
          _remindersEnabledMeta,
          remindersEnabled.isAcceptableOrUnknown(
              data['reminders_enabled']!, _remindersEnabledMeta));
    }
    if (data.containsKey('last_notified')) {
      context.handle(
          _lastNotifiedMeta,
          lastNotified.isAcceptableOrUnknown(
              data['last_notified']!, _lastNotifiedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrackedContact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackedContact(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phoneNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone_number'])!,
      nickname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nickname']),
      frequencyDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}frequency_days'])!,
      lastCalled: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_called']),
      remindersEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}reminders_enabled'])!,
      lastNotified: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_notified']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $TrackedContactsTable createAlias(String alias) {
    return $TrackedContactsTable(attachedDatabase, alias);
  }
}

class TrackedContact extends DataClass implements Insertable<TrackedContact> {
  final int id;
  final String name;
  final String phoneNumber;
  final String? nickname;
  final int frequencyDays;
  final DateTime? lastCalled;
  final bool remindersEnabled;
  final DateTime? lastNotified;
  final DateTime createdAt;
  const TrackedContact(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      this.nickname,
      required this.frequencyDays,
      this.lastCalled,
      required this.remindersEnabled,
      this.lastNotified,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['phone_number'] = Variable<String>(phoneNumber);
    if (!nullToAbsent || nickname != null) {
      map['nickname'] = Variable<String>(nickname);
    }
    map['frequency_days'] = Variable<int>(frequencyDays);
    if (!nullToAbsent || lastCalled != null) {
      map['last_called'] = Variable<DateTime>(lastCalled);
    }
    map['reminders_enabled'] = Variable<bool>(remindersEnabled);
    if (!nullToAbsent || lastNotified != null) {
      map['last_notified'] = Variable<DateTime>(lastNotified);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TrackedContactsCompanion toCompanion(bool nullToAbsent) {
    return TrackedContactsCompanion(
      id: Value(id),
      name: Value(name),
      phoneNumber: Value(phoneNumber),
      nickname: nickname == null && nullToAbsent
          ? const Value.absent()
          : Value(nickname),
      frequencyDays: Value(frequencyDays),
      lastCalled: lastCalled == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCalled),
      remindersEnabled: Value(remindersEnabled),
      lastNotified: lastNotified == null && nullToAbsent
          ? const Value.absent()
          : Value(lastNotified),
      createdAt: Value(createdAt),
    );
  }

  factory TrackedContact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrackedContact(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      nickname: serializer.fromJson<String?>(json['nickname']),
      frequencyDays: serializer.fromJson<int>(json['frequencyDays']),
      lastCalled: serializer.fromJson<DateTime?>(json['lastCalled']),
      remindersEnabled: serializer.fromJson<bool>(json['remindersEnabled']),
      lastNotified: serializer.fromJson<DateTime?>(json['lastNotified']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'nickname': serializer.toJson<String?>(nickname),
      'frequencyDays': serializer.toJson<int>(frequencyDays),
      'lastCalled': serializer.toJson<DateTime?>(lastCalled),
      'remindersEnabled': serializer.toJson<bool>(remindersEnabled),
      'lastNotified': serializer.toJson<DateTime?>(lastNotified),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TrackedContact copyWith(
          {int? id,
          String? name,
          String? phoneNumber,
          Value<String?> nickname = const Value.absent(),
          int? frequencyDays,
          Value<DateTime?> lastCalled = const Value.absent(),
          bool? remindersEnabled,
          Value<DateTime?> lastNotified = const Value.absent(),
          DateTime? createdAt}) =>
      TrackedContact(
        id: id ?? this.id,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        nickname: nickname.present ? nickname.value : this.nickname,
        frequencyDays: frequencyDays ?? this.frequencyDays,
        lastCalled: lastCalled.present ? lastCalled.value : this.lastCalled,
        remindersEnabled: remindersEnabled ?? this.remindersEnabled,
        lastNotified:
            lastNotified.present ? lastNotified.value : this.lastNotified,
        createdAt: createdAt ?? this.createdAt,
      );
  TrackedContact copyWithCompanion(TrackedContactsCompanion data) {
    return TrackedContact(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phoneNumber:
          data.phoneNumber.present ? data.phoneNumber.value : this.phoneNumber,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      frequencyDays: data.frequencyDays.present
          ? data.frequencyDays.value
          : this.frequencyDays,
      lastCalled:
          data.lastCalled.present ? data.lastCalled.value : this.lastCalled,
      remindersEnabled: data.remindersEnabled.present
          ? data.remindersEnabled.value
          : this.remindersEnabled,
      lastNotified: data.lastNotified.present
          ? data.lastNotified.value
          : this.lastNotified,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrackedContact(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('nickname: $nickname, ')
          ..write('frequencyDays: $frequencyDays, ')
          ..write('lastCalled: $lastCalled, ')
          ..write('remindersEnabled: $remindersEnabled, ')
          ..write('lastNotified: $lastNotified, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, phoneNumber, nickname,
      frequencyDays, lastCalled, remindersEnabled, lastNotified, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackedContact &&
          other.id == this.id &&
          other.name == this.name &&
          other.phoneNumber == this.phoneNumber &&
          other.nickname == this.nickname &&
          other.frequencyDays == this.frequencyDays &&
          other.lastCalled == this.lastCalled &&
          other.remindersEnabled == this.remindersEnabled &&
          other.lastNotified == this.lastNotified &&
          other.createdAt == this.createdAt);
}

class TrackedContactsCompanion extends UpdateCompanion<TrackedContact> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> phoneNumber;
  final Value<String?> nickname;
  final Value<int> frequencyDays;
  final Value<DateTime?> lastCalled;
  final Value<bool> remindersEnabled;
  final Value<DateTime?> lastNotified;
  final Value<DateTime> createdAt;
  const TrackedContactsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.nickname = const Value.absent(),
    this.frequencyDays = const Value.absent(),
    this.lastCalled = const Value.absent(),
    this.remindersEnabled = const Value.absent(),
    this.lastNotified = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TrackedContactsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String phoneNumber,
    this.nickname = const Value.absent(),
    this.frequencyDays = const Value.absent(),
    this.lastCalled = const Value.absent(),
    this.remindersEnabled = const Value.absent(),
    this.lastNotified = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : name = Value(name),
        phoneNumber = Value(phoneNumber);
  static Insertable<TrackedContact> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phoneNumber,
    Expression<String>? nickname,
    Expression<int>? frequencyDays,
    Expression<DateTime>? lastCalled,
    Expression<bool>? remindersEnabled,
    Expression<DateTime>? lastNotified,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (nickname != null) 'nickname': nickname,
      if (frequencyDays != null) 'frequency_days': frequencyDays,
      if (lastCalled != null) 'last_called': lastCalled,
      if (remindersEnabled != null) 'reminders_enabled': remindersEnabled,
      if (lastNotified != null) 'last_notified': lastNotified,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TrackedContactsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? phoneNumber,
      Value<String?>? nickname,
      Value<int>? frequencyDays,
      Value<DateTime?>? lastCalled,
      Value<bool>? remindersEnabled,
      Value<DateTime?>? lastNotified,
      Value<DateTime>? createdAt}) {
    return TrackedContactsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      nickname: nickname ?? this.nickname,
      frequencyDays: frequencyDays ?? this.frequencyDays,
      lastCalled: lastCalled ?? this.lastCalled,
      remindersEnabled: remindersEnabled ?? this.remindersEnabled,
      lastNotified: lastNotified ?? this.lastNotified,
      createdAt: createdAt ?? this.createdAt,
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
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (frequencyDays.present) {
      map['frequency_days'] = Variable<int>(frequencyDays.value);
    }
    if (lastCalled.present) {
      map['last_called'] = Variable<DateTime>(lastCalled.value);
    }
    if (remindersEnabled.present) {
      map['reminders_enabled'] = Variable<bool>(remindersEnabled.value);
    }
    if (lastNotified.present) {
      map['last_notified'] = Variable<DateTime>(lastNotified.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackedContactsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('nickname: $nickname, ')
          ..write('frequencyDays: $frequencyDays, ')
          ..write('lastCalled: $lastCalled, ')
          ..write('remindersEnabled: $remindersEnabled, ')
          ..write('lastNotified: $lastNotified, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $NotificationStatsTable extends NotificationStats
    with TableInfo<$NotificationStatsTable, NotificationStat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationStatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _morningSentMeta =
      const VerificationMeta('morningSent');
  @override
  late final GeneratedColumn<bool> morningSent = GeneratedColumn<bool>(
      'morning_sent', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("morning_sent" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _dayNudgesCountMeta =
      const VerificationMeta('dayNudgesCount');
  @override
  late final GeneratedColumn<int> dayNudgesCount = GeneratedColumn<int>(
      'day_nudges_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _eveningSentMeta =
      const VerificationMeta('eveningSent');
  @override
  late final GeneratedColumn<bool> eveningSent = GeneratedColumn<bool>(
      'evening_sent', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("evening_sent" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _nudgedContactIdsMeta =
      const VerificationMeta('nudgedContactIds');
  @override
  late final GeneratedColumn<String> nudgedContactIds = GeneratedColumn<String>(
      'nudged_contact_ids', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [date, morningSent, dayNudgesCount, eveningSent, nudgedContactIds];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_stats';
  @override
  VerificationContext validateIntegrity(Insertable<NotificationStat> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('morning_sent')) {
      context.handle(
          _morningSentMeta,
          morningSent.isAcceptableOrUnknown(
              data['morning_sent']!, _morningSentMeta));
    }
    if (data.containsKey('day_nudges_count')) {
      context.handle(
          _dayNudgesCountMeta,
          dayNudgesCount.isAcceptableOrUnknown(
              data['day_nudges_count']!, _dayNudgesCountMeta));
    }
    if (data.containsKey('evening_sent')) {
      context.handle(
          _eveningSentMeta,
          eveningSent.isAcceptableOrUnknown(
              data['evening_sent']!, _eveningSentMeta));
    }
    if (data.containsKey('nudged_contact_ids')) {
      context.handle(
          _nudgedContactIdsMeta,
          nudgedContactIds.isAcceptableOrUnknown(
              data['nudged_contact_ids']!, _nudgedContactIdsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  NotificationStat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationStat(
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      morningSent: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}morning_sent'])!,
      dayNudgesCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}day_nudges_count'])!,
      eveningSent: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}evening_sent'])!,
      nudgedContactIds: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}nudged_contact_ids']),
    );
  }

  @override
  $NotificationStatsTable createAlias(String alias) {
    return $NotificationStatsTable(attachedDatabase, alias);
  }
}

class NotificationStat extends DataClass
    implements Insertable<NotificationStat> {
  final DateTime date;
  final bool morningSent;
  final int dayNudgesCount;
  final bool eveningSent;
  final String? nudgedContactIds;
  const NotificationStat(
      {required this.date,
      required this.morningSent,
      required this.dayNudgesCount,
      required this.eveningSent,
      this.nudgedContactIds});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    map['morning_sent'] = Variable<bool>(morningSent);
    map['day_nudges_count'] = Variable<int>(dayNudgesCount);
    map['evening_sent'] = Variable<bool>(eveningSent);
    if (!nullToAbsent || nudgedContactIds != null) {
      map['nudged_contact_ids'] = Variable<String>(nudgedContactIds);
    }
    return map;
  }

  NotificationStatsCompanion toCompanion(bool nullToAbsent) {
    return NotificationStatsCompanion(
      date: Value(date),
      morningSent: Value(morningSent),
      dayNudgesCount: Value(dayNudgesCount),
      eveningSent: Value(eveningSent),
      nudgedContactIds: nudgedContactIds == null && nullToAbsent
          ? const Value.absent()
          : Value(nudgedContactIds),
    );
  }

  factory NotificationStat.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationStat(
      date: serializer.fromJson<DateTime>(json['date']),
      morningSent: serializer.fromJson<bool>(json['morningSent']),
      dayNudgesCount: serializer.fromJson<int>(json['dayNudgesCount']),
      eveningSent: serializer.fromJson<bool>(json['eveningSent']),
      nudgedContactIds: serializer.fromJson<String?>(json['nudgedContactIds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'morningSent': serializer.toJson<bool>(morningSent),
      'dayNudgesCount': serializer.toJson<int>(dayNudgesCount),
      'eveningSent': serializer.toJson<bool>(eveningSent),
      'nudgedContactIds': serializer.toJson<String?>(nudgedContactIds),
    };
  }

  NotificationStat copyWith(
          {DateTime? date,
          bool? morningSent,
          int? dayNudgesCount,
          bool? eveningSent,
          Value<String?> nudgedContactIds = const Value.absent()}) =>
      NotificationStat(
        date: date ?? this.date,
        morningSent: morningSent ?? this.morningSent,
        dayNudgesCount: dayNudgesCount ?? this.dayNudgesCount,
        eveningSent: eveningSent ?? this.eveningSent,
        nudgedContactIds: nudgedContactIds.present
            ? nudgedContactIds.value
            : this.nudgedContactIds,
      );
  NotificationStat copyWithCompanion(NotificationStatsCompanion data) {
    return NotificationStat(
      date: data.date.present ? data.date.value : this.date,
      morningSent:
          data.morningSent.present ? data.morningSent.value : this.morningSent,
      dayNudgesCount: data.dayNudgesCount.present
          ? data.dayNudgesCount.value
          : this.dayNudgesCount,
      eveningSent:
          data.eveningSent.present ? data.eveningSent.value : this.eveningSent,
      nudgedContactIds: data.nudgedContactIds.present
          ? data.nudgedContactIds.value
          : this.nudgedContactIds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationStat(')
          ..write('date: $date, ')
          ..write('morningSent: $morningSent, ')
          ..write('dayNudgesCount: $dayNudgesCount, ')
          ..write('eveningSent: $eveningSent, ')
          ..write('nudgedContactIds: $nudgedContactIds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      date, morningSent, dayNudgesCount, eveningSent, nudgedContactIds);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationStat &&
          other.date == this.date &&
          other.morningSent == this.morningSent &&
          other.dayNudgesCount == this.dayNudgesCount &&
          other.eveningSent == this.eveningSent &&
          other.nudgedContactIds == this.nudgedContactIds);
}

class NotificationStatsCompanion extends UpdateCompanion<NotificationStat> {
  final Value<DateTime> date;
  final Value<bool> morningSent;
  final Value<int> dayNudgesCount;
  final Value<bool> eveningSent;
  final Value<String?> nudgedContactIds;
  final Value<int> rowid;
  const NotificationStatsCompanion({
    this.date = const Value.absent(),
    this.morningSent = const Value.absent(),
    this.dayNudgesCount = const Value.absent(),
    this.eveningSent = const Value.absent(),
    this.nudgedContactIds = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationStatsCompanion.insert({
    required DateTime date,
    this.morningSent = const Value.absent(),
    this.dayNudgesCount = const Value.absent(),
    this.eveningSent = const Value.absent(),
    this.nudgedContactIds = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : date = Value(date);
  static Insertable<NotificationStat> custom({
    Expression<DateTime>? date,
    Expression<bool>? morningSent,
    Expression<int>? dayNudgesCount,
    Expression<bool>? eveningSent,
    Expression<String>? nudgedContactIds,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (morningSent != null) 'morning_sent': morningSent,
      if (dayNudgesCount != null) 'day_nudges_count': dayNudgesCount,
      if (eveningSent != null) 'evening_sent': eveningSent,
      if (nudgedContactIds != null) 'nudged_contact_ids': nudgedContactIds,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationStatsCompanion copyWith(
      {Value<DateTime>? date,
      Value<bool>? morningSent,
      Value<int>? dayNudgesCount,
      Value<bool>? eveningSent,
      Value<String?>? nudgedContactIds,
      Value<int>? rowid}) {
    return NotificationStatsCompanion(
      date: date ?? this.date,
      morningSent: morningSent ?? this.morningSent,
      dayNudgesCount: dayNudgesCount ?? this.dayNudgesCount,
      eveningSent: eveningSent ?? this.eveningSent,
      nudgedContactIds: nudgedContactIds ?? this.nudgedContactIds,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (morningSent.present) {
      map['morning_sent'] = Variable<bool>(morningSent.value);
    }
    if (dayNudgesCount.present) {
      map['day_nudges_count'] = Variable<int>(dayNudgesCount.value);
    }
    if (eveningSent.present) {
      map['evening_sent'] = Variable<bool>(eveningSent.value);
    }
    if (nudgedContactIds.present) {
      map['nudged_contact_ids'] = Variable<String>(nudgedContactIds.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationStatsCompanion(')
          ..write('date: $date, ')
          ..write('morningSent: $morningSent, ')
          ..write('dayNudgesCount: $dayNudgesCount, ')
          ..write('eveningSent: $eveningSent, ')
          ..write('nudgedContactIds: $nudgedContactIds, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TrackedContactsTable trackedContacts =
      $TrackedContactsTable(this);
  late final $NotificationStatsTable notificationStats =
      $NotificationStatsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [trackedContacts, notificationStats];
}

typedef $$TrackedContactsTableCreateCompanionBuilder = TrackedContactsCompanion
    Function({
  Value<int> id,
  required String name,
  required String phoneNumber,
  Value<String?> nickname,
  Value<int> frequencyDays,
  Value<DateTime?> lastCalled,
  Value<bool> remindersEnabled,
  Value<DateTime?> lastNotified,
  Value<DateTime> createdAt,
});
typedef $$TrackedContactsTableUpdateCompanionBuilder = TrackedContactsCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String> phoneNumber,
  Value<String?> nickname,
  Value<int> frequencyDays,
  Value<DateTime?> lastCalled,
  Value<bool> remindersEnabled,
  Value<DateTime?> lastNotified,
  Value<DateTime> createdAt,
});

class $$TrackedContactsTableFilterComposer
    extends Composer<_$AppDatabase, $TrackedContactsTable> {
  $$TrackedContactsTableFilterComposer({
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

  ColumnFilters<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nickname => $composableBuilder(
      column: $table.nickname, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get frequencyDays => $composableBuilder(
      column: $table.frequencyDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastCalled => $composableBuilder(
      column: $table.lastCalled, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get remindersEnabled => $composableBuilder(
      column: $table.remindersEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastNotified => $composableBuilder(
      column: $table.lastNotified, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$TrackedContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $TrackedContactsTable> {
  $$TrackedContactsTableOrderingComposer({
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

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nickname => $composableBuilder(
      column: $table.nickname, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get frequencyDays => $composableBuilder(
      column: $table.frequencyDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastCalled => $composableBuilder(
      column: $table.lastCalled, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get remindersEnabled => $composableBuilder(
      column: $table.remindersEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastNotified => $composableBuilder(
      column: $table.lastNotified,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$TrackedContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrackedContactsTable> {
  $$TrackedContactsTableAnnotationComposer({
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

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => column);

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<int> get frequencyDays => $composableBuilder(
      column: $table.frequencyDays, builder: (column) => column);

  GeneratedColumn<DateTime> get lastCalled => $composableBuilder(
      column: $table.lastCalled, builder: (column) => column);

  GeneratedColumn<bool> get remindersEnabled => $composableBuilder(
      column: $table.remindersEnabled, builder: (column) => column);

  GeneratedColumn<DateTime> get lastNotified => $composableBuilder(
      column: $table.lastNotified, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TrackedContactsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TrackedContactsTable,
    TrackedContact,
    $$TrackedContactsTableFilterComposer,
    $$TrackedContactsTableOrderingComposer,
    $$TrackedContactsTableAnnotationComposer,
    $$TrackedContactsTableCreateCompanionBuilder,
    $$TrackedContactsTableUpdateCompanionBuilder,
    (
      TrackedContact,
      BaseReferences<_$AppDatabase, $TrackedContactsTable, TrackedContact>
    ),
    TrackedContact,
    PrefetchHooks Function()> {
  $$TrackedContactsTableTableManager(
      _$AppDatabase db, $TrackedContactsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrackedContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrackedContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrackedContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> phoneNumber = const Value.absent(),
            Value<String?> nickname = const Value.absent(),
            Value<int> frequencyDays = const Value.absent(),
            Value<DateTime?> lastCalled = const Value.absent(),
            Value<bool> remindersEnabled = const Value.absent(),
            Value<DateTime?> lastNotified = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              TrackedContactsCompanion(
            id: id,
            name: name,
            phoneNumber: phoneNumber,
            nickname: nickname,
            frequencyDays: frequencyDays,
            lastCalled: lastCalled,
            remindersEnabled: remindersEnabled,
            lastNotified: lastNotified,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String phoneNumber,
            Value<String?> nickname = const Value.absent(),
            Value<int> frequencyDays = const Value.absent(),
            Value<DateTime?> lastCalled = const Value.absent(),
            Value<bool> remindersEnabled = const Value.absent(),
            Value<DateTime?> lastNotified = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              TrackedContactsCompanion.insert(
            id: id,
            name: name,
            phoneNumber: phoneNumber,
            nickname: nickname,
            frequencyDays: frequencyDays,
            lastCalled: lastCalled,
            remindersEnabled: remindersEnabled,
            lastNotified: lastNotified,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TrackedContactsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TrackedContactsTable,
    TrackedContact,
    $$TrackedContactsTableFilterComposer,
    $$TrackedContactsTableOrderingComposer,
    $$TrackedContactsTableAnnotationComposer,
    $$TrackedContactsTableCreateCompanionBuilder,
    $$TrackedContactsTableUpdateCompanionBuilder,
    (
      TrackedContact,
      BaseReferences<_$AppDatabase, $TrackedContactsTable, TrackedContact>
    ),
    TrackedContact,
    PrefetchHooks Function()>;
typedef $$NotificationStatsTableCreateCompanionBuilder
    = NotificationStatsCompanion Function({
  required DateTime date,
  Value<bool> morningSent,
  Value<int> dayNudgesCount,
  Value<bool> eveningSent,
  Value<String?> nudgedContactIds,
  Value<int> rowid,
});
typedef $$NotificationStatsTableUpdateCompanionBuilder
    = NotificationStatsCompanion Function({
  Value<DateTime> date,
  Value<bool> morningSent,
  Value<int> dayNudgesCount,
  Value<bool> eveningSent,
  Value<String?> nudgedContactIds,
  Value<int> rowid,
});

class $$NotificationStatsTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationStatsTable> {
  $$NotificationStatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get morningSent => $composableBuilder(
      column: $table.morningSent, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dayNudgesCount => $composableBuilder(
      column: $table.dayNudgesCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get eveningSent => $composableBuilder(
      column: $table.eveningSent, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nudgedContactIds => $composableBuilder(
      column: $table.nudgedContactIds,
      builder: (column) => ColumnFilters(column));
}

class $$NotificationStatsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationStatsTable> {
  $$NotificationStatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get morningSent => $composableBuilder(
      column: $table.morningSent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dayNudgesCount => $composableBuilder(
      column: $table.dayNudgesCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get eveningSent => $composableBuilder(
      column: $table.eveningSent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nudgedContactIds => $composableBuilder(
      column: $table.nudgedContactIds,
      builder: (column) => ColumnOrderings(column));
}

class $$NotificationStatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationStatsTable> {
  $$NotificationStatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get morningSent => $composableBuilder(
      column: $table.morningSent, builder: (column) => column);

  GeneratedColumn<int> get dayNudgesCount => $composableBuilder(
      column: $table.dayNudgesCount, builder: (column) => column);

  GeneratedColumn<bool> get eveningSent => $composableBuilder(
      column: $table.eveningSent, builder: (column) => column);

  GeneratedColumn<String> get nudgedContactIds => $composableBuilder(
      column: $table.nudgedContactIds, builder: (column) => column);
}

class $$NotificationStatsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotificationStatsTable,
    NotificationStat,
    $$NotificationStatsTableFilterComposer,
    $$NotificationStatsTableOrderingComposer,
    $$NotificationStatsTableAnnotationComposer,
    $$NotificationStatsTableCreateCompanionBuilder,
    $$NotificationStatsTableUpdateCompanionBuilder,
    (
      NotificationStat,
      BaseReferences<_$AppDatabase, $NotificationStatsTable, NotificationStat>
    ),
    NotificationStat,
    PrefetchHooks Function()> {
  $$NotificationStatsTableTableManager(
      _$AppDatabase db, $NotificationStatsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationStatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationStatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationStatsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<DateTime> date = const Value.absent(),
            Value<bool> morningSent = const Value.absent(),
            Value<int> dayNudgesCount = const Value.absent(),
            Value<bool> eveningSent = const Value.absent(),
            Value<String?> nudgedContactIds = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotificationStatsCompanion(
            date: date,
            morningSent: morningSent,
            dayNudgesCount: dayNudgesCount,
            eveningSent: eveningSent,
            nudgedContactIds: nudgedContactIds,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required DateTime date,
            Value<bool> morningSent = const Value.absent(),
            Value<int> dayNudgesCount = const Value.absent(),
            Value<bool> eveningSent = const Value.absent(),
            Value<String?> nudgedContactIds = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotificationStatsCompanion.insert(
            date: date,
            morningSent: morningSent,
            dayNudgesCount: dayNudgesCount,
            eveningSent: eveningSent,
            nudgedContactIds: nudgedContactIds,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotificationStatsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NotificationStatsTable,
    NotificationStat,
    $$NotificationStatsTableFilterComposer,
    $$NotificationStatsTableOrderingComposer,
    $$NotificationStatsTableAnnotationComposer,
    $$NotificationStatsTableCreateCompanionBuilder,
    $$NotificationStatsTableUpdateCompanionBuilder,
    (
      NotificationStat,
      BaseReferences<_$AppDatabase, $NotificationStatsTable, NotificationStat>
    ),
    NotificationStat,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TrackedContactsTableTableManager get trackedContacts =>
      $$TrackedContactsTableTableManager(_db, _db.trackedContacts);
  $$NotificationStatsTableTableManager get notificationStats =>
      $$NotificationStatsTableTableManager(_db, _db.notificationStats);
}
