// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iblockposting.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIBlockPostingCollection on Isar {
  IsarCollection<IBlockPosting> get iBlockPostings => this.collection();
}

const IBlockPostingSchema = CollectionSchema(
  name: r'IBlockPosting',
  id: 5396728552392531902,
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
  estimateSize: _iBlockPostingEstimateSize,
  serialize: _iBlockPostingSerialize,
  deserialize: _iBlockPostingDeserialize,
  deserializeProp: _iBlockPostingDeserializeProp,
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
  getId: _iBlockPostingGetId,
  getLinks: _iBlockPostingGetLinks,
  attach: _iBlockPostingAttach,
  version: '3.1.0+1',
);

int _iBlockPostingEstimateSize(
  IBlockPosting object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.blockedAuthorNickname.length * 3;
  bytesCount += 3 + object.blockedTitle.length * 3;
  bytesCount += 3 + object.ownUserUniqId.length * 3;
  return bytesCount;
}

void _iBlockPostingSerialize(
  IBlockPosting object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.blockedAuthorNickname);
  writer.writeLong(offsets[1], object.blockedPostId);
  writer.writeString(offsets[2], object.blockedTitle);
  writer.writeString(offsets[3], object.ownUserUniqId);
}

IBlockPosting _iBlockPostingDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IBlockPosting();
  object.blockedAuthorNickname = reader.readString(offsets[0]);
  object.blockedPostId = reader.readLong(offsets[1]);
  object.blockedTitle = reader.readString(offsets[2]);
  object.id = id;
  object.ownUserUniqId = reader.readString(offsets[3]);
  return object;
}

P _iBlockPostingDeserializeProp<P>(
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

Id _iBlockPostingGetId(IBlockPosting object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _iBlockPostingGetLinks(IBlockPosting object) {
  return [];
}

void _iBlockPostingAttach(
    IsarCollection<dynamic> col, Id id, IBlockPosting object) {
  object.id = id;
}

extension IBlockPostingQueryWhereSort
    on QueryBuilder<IBlockPosting, IBlockPosting, QWhere> {
  QueryBuilder<IBlockPosting, IBlockPosting, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IBlockPostingQueryWhere
    on QueryBuilder<IBlockPosting, IBlockPosting, QWhereClause> {
  QueryBuilder<IBlockPosting, IBlockPosting, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterWhereClause> idBetween(
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterWhereClause>
      ownUserUniqIdEqualTo(String ownUserUniqId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ownUserUniqId',
        value: [ownUserUniqId],
      ));
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterWhereClause>
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

extension IBlockPostingQueryFilter
    on QueryBuilder<IBlockPosting, IBlockPosting, QFilterCondition> {
  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
      blockedAuthorNicknameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'blockedAuthorNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
      blockedAuthorNicknameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedAuthorNickname',
        value: '',
      ));
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
      blockedAuthorNicknameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'blockedAuthorNickname',
        value: '',
      ));
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
      blockedPostIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedPostId',
        value: value,
      ));
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
      blockedTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'blockedTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
      blockedTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'blockedTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
      blockedTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
      blockedTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'blockedTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition> idBetween(
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
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

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
      ownUserUniqIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ownUserUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
      ownUserUniqIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ownUserUniqId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
      ownUserUniqIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownUserUniqId',
        value: '',
      ));
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterFilterCondition>
      ownUserUniqIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ownUserUniqId',
        value: '',
      ));
    });
  }
}

extension IBlockPostingQueryObject
    on QueryBuilder<IBlockPosting, IBlockPosting, QFilterCondition> {}

extension IBlockPostingQueryLinks
    on QueryBuilder<IBlockPosting, IBlockPosting, QFilterCondition> {}

extension IBlockPostingQuerySortBy
    on QueryBuilder<IBlockPosting, IBlockPosting, QSortBy> {
  QueryBuilder<IBlockPosting, IBlockPosting, QAfterSortBy>
      sortByBlockedAuthorNickname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedAuthorNickname', Sort.asc);
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterSortBy>
      sortByBlockedAuthorNicknameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedAuthorNickname', Sort.desc);
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterSortBy>
      sortByBlockedPostId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedPostId', Sort.asc);
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterSortBy>
      sortByBlockedPostIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedPostId', Sort.desc);
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterSortBy>
      sortByBlockedTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedTitle', Sort.asc);
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterSortBy>
      sortByBlockedTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedTitle', Sort.desc);
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterSortBy>
      sortByOwnUserUniqId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.asc);
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterSortBy>
      sortByOwnUserUniqIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.desc);
    });
  }
}

extension IBlockPostingQuerySortThenBy
    on QueryBuilder<IBlockPosting, IBlockPosting, QSortThenBy> {
  QueryBuilder<IBlockPosting, IBlockPosting, QAfterSortBy>
      thenByBlockedAuthorNickname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedAuthorNickname', Sort.asc);
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterSortBy>
      thenByBlockedAuthorNicknameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedAuthorNickname', Sort.desc);
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterSortBy>
      thenByBlockedPostId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedPostId', Sort.asc);
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterSortBy>
      thenByBlockedPostIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedPostId', Sort.desc);
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterSortBy>
      thenByBlockedTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedTitle', Sort.asc);
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterSortBy>
      thenByBlockedTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedTitle', Sort.desc);
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterSortBy>
      thenByOwnUserUniqId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.asc);
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QAfterSortBy>
      thenByOwnUserUniqIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownUserUniqId', Sort.desc);
    });
  }
}

extension IBlockPostingQueryWhereDistinct
    on QueryBuilder<IBlockPosting, IBlockPosting, QDistinct> {
  QueryBuilder<IBlockPosting, IBlockPosting, QDistinct>
      distinctByBlockedAuthorNickname({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockedAuthorNickname',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QDistinct>
      distinctByBlockedPostId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockedPostId');
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QDistinct> distinctByBlockedTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockedTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IBlockPosting, IBlockPosting, QDistinct> distinctByOwnUserUniqId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ownUserUniqId',
          caseSensitive: caseSensitive);
    });
  }
}

extension IBlockPostingQueryProperty
    on QueryBuilder<IBlockPosting, IBlockPosting, QQueryProperty> {
  QueryBuilder<IBlockPosting, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IBlockPosting, String, QQueryOperations>
      blockedAuthorNicknameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockedAuthorNickname');
    });
  }

  QueryBuilder<IBlockPosting, int, QQueryOperations> blockedPostIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockedPostId');
    });
  }

  QueryBuilder<IBlockPosting, String, QQueryOperations> blockedTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockedTitle');
    });
  }

  QueryBuilder<IBlockPosting, String, QQueryOperations>
      ownUserUniqIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ownUserUniqId');
    });
  }
}
