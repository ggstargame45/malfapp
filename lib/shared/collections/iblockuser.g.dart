// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iblockuser.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIBlockUserCollection on Isar {
  IsarCollection<IBlockUser> get iBlockUsers => this.collection();
}

const IBlockUserSchema = CollectionSchema(
  name: r'IBlockUser',
  id: 3828730729125048460,
  properties: {
    r'blockedNickname': PropertySchema(
      id: 0,
      name: r'blockedNickname',
      type: IsarType.string,
    ),
    r'blockedUserUniqId': PropertySchema(
      id: 1,
      name: r'blockedUserUniqId',
      type: IsarType.string,
    ),
    r'ownUserUniqId': PropertySchema(
      id: 2,
      name: r'ownUserUniqId',
      type: IsarType.string,
    )
  },
  estimateSize: _iBlockUserEstimateSize,
  serialize: _iBlockUserSerialize,
  deserialize: _iBlockUserDeserialize,
  deserializeProp: _iBlockUserDeserializeProp,
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
  getId: _iBlockUserGetId,
  getLinks: _iBlockUserGetLinks,
  attach: _iBlockUserAttach,
  version: '3.1.0+1',
);

int _iBlockUserEstimateSize(
  IBlockUser object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.blockedNickname.length * 3;
  bytesCount += 3 + object.blockedUserUniqId.length * 3;
  bytesCount += 3 + object.ownUserUniqId.length * 3;
  return bytesCount;
}

void _iBlockUserSerialize(
  IBlockUser object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.blockedNickname);
  writer.writeString(offsets[1], object.blockedUserUniqId);
  writer.writeString(offsets[2], object.ownUserUniqId);
}

IBlockUser _iBlockUserDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IBlockUser();
  object.blockedNickname = reader.readString(offsets[0]);
  object.blockedUserUniqId = reader.readString(offsets[1]);
  object.id = id;
  object.ownUserUniqId = reader.readString(offsets[2]);
  return object;
}

P _iBlockUserDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _iBlockUserGetId(IBlockUser object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _iBlockUserGetLinks(IBlockUser object) {
  return [];
}

void _iBlockUserAttach(IsarCollection<dynamic> col, Id id, IBlockUser object) {
  object.id = id;
}

extension IBlockUserQueryWhereSort
    on QueryBuilder<IBlockUser, IBlockUser, QWhere> {
  QueryBuilder<IBlockUser, IBlockUser, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IBlockUserQueryWhere
    on QueryBuilder<IBlockUser, IBlockUser, QWhereClause> {
  QueryBuilder<IBlockUser, IBlockUser, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<IBlockUser, IBlockUser, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterWhereClause> idBetween(
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

  QueryBuilder<IBlockUser, IBlockUser, QAfterWhereClause> ownUserUniqIdEqualTo(
      String ownUserUniqId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ownUserUniqId',
        value: [ownUserUniqId],
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterWhereClause>
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

extension IBlockUserQueryFilter
    on QueryBuilder<IBlockUser, IBlockUser, QFilterCondition> {
  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedNicknameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedNicknameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'blockedNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedNicknameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'blockedNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedNicknameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'blockedNickname',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedNicknameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'blockedNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedNicknameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'blockedNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedNicknameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'blockedNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedNicknameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'blockedNickname',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedNicknameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedNickname',
        value: '',
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedNicknameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'blockedNickname',
        value: '',
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedUserUniqIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedUserUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedUserUniqIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'blockedUserUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedUserUniqIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'blockedUserUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedUserUniqIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'blockedUserUniqId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedUserUniqIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'blockedUserUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedUserUniqIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'blockedUserUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedUserUniqIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'blockedUserUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedUserUniqIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'blockedUserUniqId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedUserUniqIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedUserUniqId',
        value: '',
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      blockedUserUniqIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'blockedUserUniqId',
        value: '',
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition> idBetween(
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

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
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

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
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

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
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

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
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

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
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

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
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

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      ownUserUniqIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ownUserUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      ownUserUniqIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ownUserUniqId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      ownUserUniqIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownUserUniqId',
        value: '',
      ));
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterFilterCondition>
      ownUserUniqIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ownUserUniqId',
        value: '',
      ));
    });
  }
}

extension IBlockUserQueryObject
    on QueryBuilder<IBlockUser, IBlockUser, QFilterCondition> {}

extension IBlockUserQueryLinks
    on QueryBuilder<IBlockUser, IBlockUser, QFilterCondition> {}

extension IBlockUserQuerySortBy
    on QueryBuilder<IBlockUser, IBlockUser, QSortBy> {
  QueryBuilder<IBlockUser, IBlockUser, QAfterSortBy> sortByBlockedNickname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedNickname', Sort.asc);
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterSortBy>
      sortByBlockedNicknameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedNickname', Sort.desc);
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterSortBy> sortByBlockedUserUniqId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedUserUniqId', Sort.asc);
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterSortBy>
      sortByBlockedUserUniqIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedUserUniqId', Sort.desc);
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterSortBy> sortByOwnUserUniqId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.asc);
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterSortBy> sortByOwnUserUniqIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.desc);
    });
  }
}

extension IBlockUserQuerySortThenBy
    on QueryBuilder<IBlockUser, IBlockUser, QSortThenBy> {
  QueryBuilder<IBlockUser, IBlockUser, QAfterSortBy> thenByBlockedNickname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedNickname', Sort.asc);
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterSortBy>
      thenByBlockedNicknameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedNickname', Sort.desc);
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterSortBy> thenByBlockedUserUniqId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedUserUniqId', Sort.asc);
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterSortBy>
      thenByBlockedUserUniqIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedUserUniqId', Sort.desc);
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterSortBy> thenByOwnUserUniqId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.asc);
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QAfterSortBy> thenByOwnUserUniqIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.desc);
    });
  }
}

extension IBlockUserQueryWhereDistinct
    on QueryBuilder<IBlockUser, IBlockUser, QDistinct> {
  QueryBuilder<IBlockUser, IBlockUser, QDistinct> distinctByBlockedNickname(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockedNickname',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QDistinct> distinctByBlockedUserUniqId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockedUserUniqId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IBlockUser, IBlockUser, QDistinct> distinctByOwnUserUniqId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ownUserUniqId',
          caseSensitive: caseSensitive);
    });
  }
}

extension IBlockUserQueryProperty
    on QueryBuilder<IBlockUser, IBlockUser, QQueryProperty> {
  QueryBuilder<IBlockUser, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IBlockUser, String, QQueryOperations> blockedNicknameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockedNickname');
    });
  }

  QueryBuilder<IBlockUser, String, QQueryOperations>
      blockedUserUniqIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockedUserUniqId');
    });
  }

  QueryBuilder<IBlockUser, String, QQueryOperations> ownUserUniqIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ownUserUniqId');
    });
  }
}
