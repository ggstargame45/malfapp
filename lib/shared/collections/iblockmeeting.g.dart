// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iblockmeeting.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIBlockMeetingCollection on Isar {
  IsarCollection<IBlockMeeting> get iBlockMeetings => this.collection();
}

const IBlockMeetingSchema = CollectionSchema(
  name: r'IBlockMeeting',
  id: -3850932433944328409,
  properties: {
    r'blockedAuthorNickname': PropertySchema(
      id: 0,
      name: r'blockedAuthorNickname',
      type: IsarType.string,
    ),
    r'blockedPostId': PropertySchema(
      id: 1,
      name: r'blockedPostId',
      type: IsarType.long,
    ),
    r'blockedTitle': PropertySchema(
      id: 2,
      name: r'blockedTitle',
      type: IsarType.string,
    ),
    r'ownUserUniqId': PropertySchema(
      id: 3,
      name: r'ownUserUniqId',
      type: IsarType.string,
    )
  },
  estimateSize: _iBlockMeetingEstimateSize,
  serialize: _iBlockMeetingSerialize,
  deserialize: _iBlockMeetingDeserialize,
  deserializeProp: _iBlockMeetingDeserializeProp,
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
  getId: _iBlockMeetingGetId,
  getLinks: _iBlockMeetingGetLinks,
  attach: _iBlockMeetingAttach,
  version: '3.1.0+1',
);

int _iBlockMeetingEstimateSize(
  IBlockMeeting object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.blockedAuthorNickname.length * 3;
  bytesCount += 3 + object.blockedTitle.length * 3;
  bytesCount += 3 + object.ownUserUniqId.length * 3;
  return bytesCount;
}

void _iBlockMeetingSerialize(
  IBlockMeeting object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.blockedAuthorNickname);
  writer.writeLong(offsets[1], object.blockedPostId);
  writer.writeString(offsets[2], object.blockedTitle);
  writer.writeString(offsets[3], object.ownUserUniqId);
}

IBlockMeeting _iBlockMeetingDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IBlockMeeting();
  object.blockedAuthorNickname = reader.readString(offsets[0]);
  object.blockedPostId = reader.readLong(offsets[1]);
  object.blockedTitle = reader.readString(offsets[2]);
  object.id = id;
  object.ownUserUniqId = reader.readString(offsets[3]);
  return object;
}

P _iBlockMeetingDeserializeProp<P>(
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
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _iBlockMeetingGetId(IBlockMeeting object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _iBlockMeetingGetLinks(IBlockMeeting object) {
  return [];
}

void _iBlockMeetingAttach(
    IsarCollection<dynamic> col, Id id, IBlockMeeting object) {
  object.id = id;
}

extension IBlockMeetingQueryWhereSort
    on QueryBuilder<IBlockMeeting, IBlockMeeting, QWhere> {
  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IBlockMeetingQueryWhere
    on QueryBuilder<IBlockMeeting, IBlockMeeting, QWhereClause> {
  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterWhereClause> idBetween(
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

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterWhereClause>
      ownUserUniqIdEqualTo(String ownUserUniqId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ownUserUniqId',
        value: [ownUserUniqId],
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterWhereClause>
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

extension IBlockMeetingQueryFilter
    on QueryBuilder<IBlockMeeting, IBlockMeeting, QFilterCondition> {
  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedAuthorNicknameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedAuthorNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedAuthorNicknameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'blockedAuthorNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedAuthorNicknameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'blockedAuthorNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedAuthorNicknameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'blockedAuthorNickname',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedAuthorNicknameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'blockedAuthorNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedAuthorNicknameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'blockedAuthorNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedAuthorNicknameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'blockedAuthorNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedAuthorNicknameMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'blockedAuthorNickname',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedAuthorNicknameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedAuthorNickname',
        value: '',
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedAuthorNicknameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'blockedAuthorNickname',
        value: '',
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedPostIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedPostId',
        value: value,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedPostIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'blockedPostId',
        value: value,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedPostIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'blockedPostId',
        value: value,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedPostIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'blockedPostId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedTitleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedTitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'blockedTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedTitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'blockedTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedTitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'blockedTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'blockedTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'blockedTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'blockedTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'blockedTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      blockedTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'blockedTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition> idBetween(
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

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
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

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
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

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
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

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
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

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
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

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
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

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      ownUserUniqIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ownUserUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      ownUserUniqIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ownUserUniqId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      ownUserUniqIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownUserUniqId',
        value: '',
      ));
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterFilterCondition>
      ownUserUniqIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ownUserUniqId',
        value: '',
      ));
    });
  }
}

extension IBlockMeetingQueryObject
    on QueryBuilder<IBlockMeeting, IBlockMeeting, QFilterCondition> {}

extension IBlockMeetingQueryLinks
    on QueryBuilder<IBlockMeeting, IBlockMeeting, QFilterCondition> {}

extension IBlockMeetingQuerySortBy
    on QueryBuilder<IBlockMeeting, IBlockMeeting, QSortBy> {
  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterSortBy>
      sortByBlockedAuthorNickname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedAuthorNickname', Sort.asc);
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterSortBy>
      sortByBlockedAuthorNicknameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedAuthorNickname', Sort.desc);
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterSortBy>
      sortByBlockedPostId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedPostId', Sort.asc);
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterSortBy>
      sortByBlockedPostIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedPostId', Sort.desc);
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterSortBy>
      sortByBlockedTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedTitle', Sort.asc);
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterSortBy>
      sortByBlockedTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedTitle', Sort.desc);
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterSortBy>
      sortByOwnUserUniqId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.asc);
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterSortBy>
      sortByOwnUserUniqIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.desc);
    });
  }
}

extension IBlockMeetingQuerySortThenBy
    on QueryBuilder<IBlockMeeting, IBlockMeeting, QSortThenBy> {
  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterSortBy>
      thenByBlockedAuthorNickname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedAuthorNickname', Sort.asc);
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterSortBy>
      thenByBlockedAuthorNicknameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedAuthorNickname', Sort.desc);
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterSortBy>
      thenByBlockedPostId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedPostId', Sort.asc);
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterSortBy>
      thenByBlockedPostIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedPostId', Sort.desc);
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterSortBy>
      thenByBlockedTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedTitle', Sort.asc);
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterSortBy>
      thenByBlockedTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedTitle', Sort.desc);
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterSortBy>
      thenByOwnUserUniqId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.asc);
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QAfterSortBy>
      thenByOwnUserUniqIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.desc);
    });
  }
}

extension IBlockMeetingQueryWhereDistinct
    on QueryBuilder<IBlockMeeting, IBlockMeeting, QDistinct> {
  QueryBuilder<IBlockMeeting, IBlockMeeting, QDistinct>
      distinctByBlockedAuthorNickname({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockedAuthorNickname',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QDistinct>
      distinctByBlockedPostId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockedPostId');
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QDistinct> distinctByBlockedTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockedTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IBlockMeeting, IBlockMeeting, QDistinct> distinctByOwnUserUniqId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ownUserUniqId',
          caseSensitive: caseSensitive);
    });
  }
}

extension IBlockMeetingQueryProperty
    on QueryBuilder<IBlockMeeting, IBlockMeeting, QQueryProperty> {
  QueryBuilder<IBlockMeeting, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IBlockMeeting, String, QQueryOperations>
      blockedAuthorNicknameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockedAuthorNickname');
    });
  }

  QueryBuilder<IBlockMeeting, int, QQueryOperations> blockedPostIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockedPostId');
    });
  }

  QueryBuilder<IBlockMeeting, String, QQueryOperations> blockedTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockedTitle');
    });
  }

  QueryBuilder<IBlockMeeting, String, QQueryOperations>
      ownUserUniqIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ownUserUniqId');
    });
  }
}
