// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_database_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetContactDatabaseModelCollection on Isar {
  IsarCollection<ContactDatabaseModel> get contactDatabaseModels =>
      this.collection();
}

const ContactDatabaseModelSchema = CollectionSchema(
  name: r'ContactDatabaseModel',
  id: -1953634533913294123,
  properties: {
    r'contactId': PropertySchema(
      id: 0,
      name: r'contactId',
      type: IsarType.string,
    ),
    r'displayName': PropertySchema(
      id: 1,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'phoneNumbers': PropertySchema(
      id: 2,
      name: r'phoneNumbers',
      type: IsarType.stringList,
    )
  },
  estimateSize: _contactDatabaseModelEstimateSize,
  serialize: _contactDatabaseModelSerialize,
  deserialize: _contactDatabaseModelDeserialize,
  deserializeProp: _contactDatabaseModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _contactDatabaseModelGetId,
  getLinks: _contactDatabaseModelGetLinks,
  attach: _contactDatabaseModelAttach,
  version: '3.1.0+1',
);

int _contactDatabaseModelEstimateSize(
  ContactDatabaseModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.contactId.length * 3;
  bytesCount += 3 + object.displayName.length * 3;
  bytesCount += 3 + object.phoneNumbers.length * 3;
  {
    for (var i = 0; i < object.phoneNumbers.length; i++) {
      final value = object.phoneNumbers[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _contactDatabaseModelSerialize(
  ContactDatabaseModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.contactId);
  writer.writeString(offsets[1], object.displayName);
  writer.writeStringList(offsets[2], object.phoneNumbers);
}

ContactDatabaseModel _contactDatabaseModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ContactDatabaseModel(
    contactId: reader.readString(offsets[0]),
    displayName: reader.readString(offsets[1]),
    phoneNumbers: reader.readStringList(offsets[2]) ?? [],
  );
  object.id = id;
  return object;
}

P _contactDatabaseModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _contactDatabaseModelGetId(ContactDatabaseModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _contactDatabaseModelGetLinks(
    ContactDatabaseModel object) {
  return [];
}

void _contactDatabaseModelAttach(
    IsarCollection<dynamic> col, Id id, ContactDatabaseModel object) {
  object.id = id;
}

extension ContactDatabaseModelQueryWhereSort
    on QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QWhere> {
  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ContactDatabaseModelQueryWhere
    on QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QWhereClause> {
  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ContactDatabaseModelQueryFilter on QueryBuilder<ContactDatabaseModel,
    ContactDatabaseModel, QFilterCondition> {
  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> contactIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contactId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> contactIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contactId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> contactIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contactId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> contactIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contactId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> contactIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contactId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> contactIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contactId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
          QAfterFilterCondition>
      contactIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contactId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
          QAfterFilterCondition>
      contactIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contactId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> contactIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contactId',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> contactIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contactId',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> displayNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> displayNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> displayNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> displayNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> displayNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> displayNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
          QAfterFilterCondition>
      displayNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
          QAfterFilterCondition>
      displayNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> phoneNumbersElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phoneNumbers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> phoneNumbersElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phoneNumbers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> phoneNumbersElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phoneNumbers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> phoneNumbersElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phoneNumbers',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> phoneNumbersElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'phoneNumbers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> phoneNumbersElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'phoneNumbers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
          QAfterFilterCondition>
      phoneNumbersElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phoneNumbers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
          QAfterFilterCondition>
      phoneNumbersElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phoneNumbers',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> phoneNumbersElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phoneNumbers',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> phoneNumbersElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phoneNumbers',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> phoneNumbersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'phoneNumbers',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> phoneNumbersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'phoneNumbers',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> phoneNumbersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'phoneNumbers',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> phoneNumbersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'phoneNumbers',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> phoneNumbersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'phoneNumbers',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel,
      QAfterFilterCondition> phoneNumbersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'phoneNumbers',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension ContactDatabaseModelQueryObject on QueryBuilder<ContactDatabaseModel,
    ContactDatabaseModel, QFilterCondition> {}

extension ContactDatabaseModelQueryLinks on QueryBuilder<ContactDatabaseModel,
    ContactDatabaseModel, QFilterCondition> {}

extension ContactDatabaseModelQuerySortBy
    on QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QSortBy> {
  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QAfterSortBy>
      sortByContactId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactId', Sort.asc);
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QAfterSortBy>
      sortByContactIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactId', Sort.desc);
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QAfterSortBy>
      sortByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QAfterSortBy>
      sortByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }
}

extension ContactDatabaseModelQuerySortThenBy
    on QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QSortThenBy> {
  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QAfterSortBy>
      thenByContactId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactId', Sort.asc);
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QAfterSortBy>
      thenByContactIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactId', Sort.desc);
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QAfterSortBy>
      thenByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QAfterSortBy>
      thenByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension ContactDatabaseModelQueryWhereDistinct
    on QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QDistinct> {
  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QDistinct>
      distinctByContactId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contactId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QDistinct>
      distinctByDisplayName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactDatabaseModel, ContactDatabaseModel, QDistinct>
      distinctByPhoneNumbers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phoneNumbers');
    });
  }
}

extension ContactDatabaseModelQueryProperty on QueryBuilder<
    ContactDatabaseModel, ContactDatabaseModel, QQueryProperty> {
  QueryBuilder<ContactDatabaseModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ContactDatabaseModel, String, QQueryOperations>
      contactIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contactId');
    });
  }

  QueryBuilder<ContactDatabaseModel, String, QQueryOperations>
      displayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayName');
    });
  }

  QueryBuilder<ContactDatabaseModel, List<String>, QQueryOperations>
      phoneNumbersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phoneNumbers');
    });
  }
}
