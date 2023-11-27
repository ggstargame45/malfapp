// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iuserstatus.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIUserStatusCollection on Isar {
  IsarCollection<IUserStatus> get iUserStatus => this.collection();
}

const IUserStatusSchema = CollectionSchema(
  name: r'IUserStatus',
  id: -6968331638406055416,
  properties: {
    r'ownUserUniqId': PropertySchema(
      id: 0,
      name: r'ownUserUniqId',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 1,
      name: r'status',
      type: IsarType.long,
    )
  },
  estimateSize: _iUserStatusEstimateSize,
  serialize: _iUserStatusSerialize,
  deserialize: _iUserStatusDeserialize,
  deserializeProp: _iUserStatusDeserializeProp,
  idName: r'id',
  indexes: {
    r'ownUserUniqId': IndexSchema(
      id: -7763221012865388671,
      name: r'ownUserUniqId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'ownUserUniqId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _iUserStatusGetId,
  getLinks: _iUserStatusGetLinks,
  attach: _iUserStatusAttach,
  version: '3.1.0+1',
);

int _iUserStatusEstimateSize(
  IUserStatus object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.ownUserUniqId.length * 3;
  return bytesCount;
}

void _iUserStatusSerialize(
  IUserStatus object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.ownUserUniqId);
  writer.writeLong(offsets[1], object.status);
}

IUserStatus _iUserStatusDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IUserStatus();
  object.id = id;
  object.ownUserUniqId = reader.readString(offsets[0]);
  object.status = reader.readLong(offsets[1]);
  return object;
}

P _iUserStatusDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _iUserStatusGetId(IUserStatus object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _iUserStatusGetLinks(IUserStatus object) {
  return [];
}

void _iUserStatusAttach(
    IsarCollection<dynamic> col, Id id, IUserStatus object) {
  object.id = id;
}

extension IUserStatusQueryWhereSort
    on QueryBuilder<IUserStatus, IUserStatus, QWhere> {
  QueryBuilder<IUserStatus, IUserStatus, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IUserStatusQueryWhere
    on QueryBuilder<IUserStatus, IUserStatus, QWhereClause> {
  QueryBuilder<IUserStatus, IUserStatus, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<IUserStatus, IUserStatus, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterWhereClause> idBetween(
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

  QueryBuilder<IUserStatus, IUserStatus, QAfterWhereClause>
      ownUserUniqIdEqualTo(String ownUserUniqId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ownUserUniqId',
        value: [ownUserUniqId],
      ));
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterWhereClause>
      ownUserUniqIdNotEqualTo(String ownUserUniqId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ownUserUniqId',
              lower: [],
              upper: [ownUserUniqId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ownUserUniqId',
              lower: [ownUserUniqId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ownUserUniqId',
              lower: [ownUserUniqId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ownUserUniqId',
              lower: [],
              upper: [ownUserUniqId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IUserStatusQueryFilter
    on QueryBuilder<IUserStatus, IUserStatus, QFilterCondition> {
  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition> idGreaterThan(
    Id? value, {
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

  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition> idLessThan(
    Id? value, {
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

  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
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

  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition>
      ownUserUniqIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownUserUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition>
      ownUserUniqIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ownUserUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition>
      ownUserUniqIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ownUserUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition>
      ownUserUniqIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ownUserUniqId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition>
      ownUserUniqIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ownUserUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition>
      ownUserUniqIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ownUserUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition>
      ownUserUniqIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ownUserUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition>
      ownUserUniqIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ownUserUniqId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition>
      ownUserUniqIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownUserUniqId',
        value: '',
      ));
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition>
      ownUserUniqIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ownUserUniqId',
        value: '',
      ));
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition> statusEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition>
      statusGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition> statusLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterFilterCondition> statusBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IUserStatusQueryObject
    on QueryBuilder<IUserStatus, IUserStatus, QFilterCondition> {}

extension IUserStatusQueryLinks
    on QueryBuilder<IUserStatus, IUserStatus, QFilterCondition> {}

extension IUserStatusQuerySortBy
    on QueryBuilder<IUserStatus, IUserStatus, QSortBy> {
  QueryBuilder<IUserStatus, IUserStatus, QAfterSortBy> sortByOwnUserUniqId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.asc);
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterSortBy>
      sortByOwnUserUniqIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.desc);
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension IUserStatusQuerySortThenBy
    on QueryBuilder<IUserStatus, IUserStatus, QSortThenBy> {
  QueryBuilder<IUserStatus, IUserStatus, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterSortBy> thenByOwnUserUniqId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.asc);
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterSortBy>
      thenByOwnUserUniqIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.desc);
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension IUserStatusQueryWhereDistinct
    on QueryBuilder<IUserStatus, IUserStatus, QDistinct> {
  QueryBuilder<IUserStatus, IUserStatus, QDistinct> distinctByOwnUserUniqId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ownUserUniqId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IUserStatus, IUserStatus, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }
}

extension IUserStatusQueryProperty
    on QueryBuilder<IUserStatus, IUserStatus, QQueryProperty> {
  QueryBuilder<IUserStatus, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IUserStatus, String, QQueryOperations> ownUserUniqIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ownUserUniqId');
    });
  }

  QueryBuilder<IUserStatus, int, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
