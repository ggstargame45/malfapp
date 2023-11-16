// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imeetinglist.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIMeetingListCollection on Isar {
  IsarCollection<IMeetingList> get iMeetingLists => this.collection();
}

const IMeetingListSchema = CollectionSchema(
  name: r'IMeetingList',
  id: -2113637837105311357,
  properties: {
    r'ownUserUniqId': PropertySchema(
      id: 0,
      name: r'ownUserUniqId',
      type: IsarType.string,
    ),
    r'postId': PropertySchema(
      id: 1,
      name: r'postId',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 2,
      name: r'status',
      type: IsarType.byte,
      enumMap: _IMeetingListstatusEnumValueMap,
    )
  },
  estimateSize: _iMeetingListEstimateSize,
  serialize: _iMeetingListSerialize,
  deserialize: _iMeetingListDeserialize,
  deserializeProp: _iMeetingListDeserializeProp,
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
    ),
    r'postId': IndexSchema(
      id: -544810920068516617,
      name: r'postId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'postId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _iMeetingListGetId,
  getLinks: _iMeetingListGetLinks,
  attach: _iMeetingListAttach,
  version: '3.1.0+1',
);

int _iMeetingListEstimateSize(
  IMeetingList object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.ownUserUniqId.length * 3;
  bytesCount += 3 + object.postId.length * 3;
  return bytesCount;
}

void _iMeetingListSerialize(
  IMeetingList object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.ownUserUniqId);
  writer.writeString(offsets[1], object.postId);
  writer.writeByte(offsets[2], object.status.index);
}

IMeetingList _iMeetingListDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IMeetingList();
  object.id = id;
  object.ownUserUniqId = reader.readString(offsets[0]);
  object.postId = reader.readString(offsets[1]);
  object.status =
      _IMeetingListstatusValueEnumMap[reader.readByteOrNull(offsets[2])] ??
          Status.WAITING;
  return object;
}

P _iMeetingListDeserializeProp<P>(
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
      return (_IMeetingListstatusValueEnumMap[reader.readByteOrNull(offset)] ??
          Status.WAITING) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _IMeetingListstatusEnumValueMap = {
  'WAITING': 0,
  'ACCEPTED': 1,
  'REJECTED': 2,
  'CANCELED': 3,
  'FINISHED': 4,
  'DELETED': 5,
};
const _IMeetingListstatusValueEnumMap = {
  0: Status.WAITING,
  1: Status.ACCEPTED,
  2: Status.REJECTED,
  3: Status.CANCELED,
  4: Status.FINISHED,
  5: Status.DELETED,
};

Id _iMeetingListGetId(IMeetingList object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _iMeetingListGetLinks(IMeetingList object) {
  return [];
}

void _iMeetingListAttach(
    IsarCollection<dynamic> col, Id id, IMeetingList object) {
  object.id = id;
}

extension IMeetingListQueryWhereSort
    on QueryBuilder<IMeetingList, IMeetingList, QWhere> {
  QueryBuilder<IMeetingList, IMeetingList, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IMeetingListQueryWhere
    on QueryBuilder<IMeetingList, IMeetingList, QWhereClause> {
  QueryBuilder<IMeetingList, IMeetingList, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<IMeetingList, IMeetingList, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterWhereClause> idBetween(
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

  QueryBuilder<IMeetingList, IMeetingList, QAfterWhereClause>
      ownUserUniqIdEqualTo(String ownUserUniqId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ownUserUniqId',
        value: [ownUserUniqId],
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterWhereClause>
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

  QueryBuilder<IMeetingList, IMeetingList, QAfterWhereClause> postIdEqualTo(
      String postId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'postId',
        value: [postId],
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterWhereClause> postIdNotEqualTo(
      String postId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'postId',
              lower: [],
              upper: [postId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'postId',
              lower: [postId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'postId',
              lower: [postId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'postId',
              lower: [],
              upper: [postId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IMeetingListQueryFilter
    on QueryBuilder<IMeetingList, IMeetingList, QFilterCondition> {
  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition> idBetween(
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

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
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

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
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

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
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

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
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

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
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

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
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

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
      ownUserUniqIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ownUserUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
      ownUserUniqIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ownUserUniqId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
      ownUserUniqIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownUserUniqId',
        value: '',
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
      ownUserUniqIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ownUserUniqId',
        value: '',
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition> postIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'postId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
      postIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'postId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
      postIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'postId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition> postIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'postId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
      postIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'postId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
      postIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'postId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
      postIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'postId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition> postIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'postId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
      postIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'postId',
        value: '',
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
      postIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'postId',
        value: '',
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition> statusEqualTo(
      Status value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
      statusGreaterThan(
    Status value, {
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

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition>
      statusLessThan(
    Status value, {
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

  QueryBuilder<IMeetingList, IMeetingList, QAfterFilterCondition> statusBetween(
    Status lower,
    Status upper, {
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

extension IMeetingListQueryObject
    on QueryBuilder<IMeetingList, IMeetingList, QFilterCondition> {}

extension IMeetingListQueryLinks
    on QueryBuilder<IMeetingList, IMeetingList, QFilterCondition> {}

extension IMeetingListQuerySortBy
    on QueryBuilder<IMeetingList, IMeetingList, QSortBy> {
  QueryBuilder<IMeetingList, IMeetingList, QAfterSortBy> sortByOwnUserUniqId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.asc);
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterSortBy>
      sortByOwnUserUniqIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.desc);
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterSortBy> sortByPostId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postId', Sort.asc);
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterSortBy> sortByPostIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postId', Sort.desc);
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension IMeetingListQuerySortThenBy
    on QueryBuilder<IMeetingList, IMeetingList, QSortThenBy> {
  QueryBuilder<IMeetingList, IMeetingList, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterSortBy> thenByOwnUserUniqId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.asc);
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterSortBy>
      thenByOwnUserUniqIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.desc);
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterSortBy> thenByPostId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postId', Sort.asc);
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterSortBy> thenByPostIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postId', Sort.desc);
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension IMeetingListQueryWhereDistinct
    on QueryBuilder<IMeetingList, IMeetingList, QDistinct> {
  QueryBuilder<IMeetingList, IMeetingList, QDistinct> distinctByOwnUserUniqId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ownUserUniqId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QDistinct> distinctByPostId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'postId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IMeetingList, IMeetingList, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }
}

extension IMeetingListQueryProperty
    on QueryBuilder<IMeetingList, IMeetingList, QQueryProperty> {
  QueryBuilder<IMeetingList, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IMeetingList, String, QQueryOperations> ownUserUniqIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ownUserUniqId');
    });
  }

  QueryBuilder<IMeetingList, String, QQueryOperations> postIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'postId');
    });
  }

  QueryBuilder<IMeetingList, Status, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
