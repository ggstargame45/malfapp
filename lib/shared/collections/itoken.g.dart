// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itoken.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetITokenCollection on Isar {
  IsarCollection<IToken> get iTokens => this.collection();
}

const ITokenSchema = CollectionSchema(
  name: r'IToken',
  id: -1447930404535492126,
  properties: {
    r'accessToken': PropertySchema(
      id: 0,
      name: r'accessToken',
      type: IsarType.string,
    ),
    r'refreshToken': PropertySchema(
      id: 1,
      name: r'refreshToken',
      type: IsarType.string,
    ),
    r'userUniqId': PropertySchema(
      id: 2,
      name: r'userUniqId',
      type: IsarType.string,
    )
  },
  estimateSize: _iTokenEstimateSize,
  serialize: _iTokenSerialize,
  deserialize: _iTokenDeserialize,
  deserializeProp: _iTokenDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _iTokenGetId,
  getLinks: _iTokenGetLinks,
  attach: _iTokenAttach,
  version: '3.1.0+1',
);

int _iTokenEstimateSize(
  IToken object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.accessToken.length * 3;
  bytesCount += 3 + object.refreshToken.length * 3;
  bytesCount += 3 + object.userUniqId.length * 3;
  return bytesCount;
}

void _iTokenSerialize(
  IToken object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accessToken);
  writer.writeString(offsets[1], object.refreshToken);
  writer.writeString(offsets[2], object.userUniqId);
}

IToken _iTokenDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IToken();
  object.accessToken = reader.readString(offsets[0]);
  object.id = id;
  object.refreshToken = reader.readString(offsets[1]);
  object.userUniqId = reader.readString(offsets[2]);
  return object;
}

P _iTokenDeserializeProp<P>(
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

Id _iTokenGetId(IToken object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _iTokenGetLinks(IToken object) {
  return [];
}

void _iTokenAttach(IsarCollection<dynamic> col, Id id, IToken object) {
  object.id = id;
}

extension ITokenQueryWhereSort on QueryBuilder<IToken, IToken, QWhere> {
  QueryBuilder<IToken, IToken, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ITokenQueryWhere on QueryBuilder<IToken, IToken, QWhereClause> {
  QueryBuilder<IToken, IToken, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<IToken, IToken, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IToken, IToken, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IToken, IToken, QAfterWhereClause> idBetween(
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

extension ITokenQueryFilter on QueryBuilder<IToken, IToken, QFilterCondition> {
  QueryBuilder<IToken, IToken, QAfterFilterCondition> accessTokenEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accessToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> accessTokenGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accessToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> accessTokenLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accessToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> accessTokenBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accessToken',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> accessTokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'accessToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> accessTokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'accessToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> accessTokenContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'accessToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> accessTokenMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'accessToken',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> accessTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accessToken',
        value: '',
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> accessTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accessToken',
        value: '',
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<IToken, IToken, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<IToken, IToken, QAfterFilterCondition> idBetween(
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

  QueryBuilder<IToken, IToken, QAfterFilterCondition> refreshTokenEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'refreshToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> refreshTokenGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'refreshToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> refreshTokenLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'refreshToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> refreshTokenBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'refreshToken',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> refreshTokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'refreshToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> refreshTokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'refreshToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> refreshTokenContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'refreshToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> refreshTokenMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'refreshToken',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> refreshTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'refreshToken',
        value: '',
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> refreshTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'refreshToken',
        value: '',
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> userUniqIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> userUniqIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> userUniqIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> userUniqIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userUniqId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> userUniqIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> userUniqIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> userUniqIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userUniqId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> userUniqIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userUniqId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> userUniqIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userUniqId',
        value: '',
      ));
    });
  }

  QueryBuilder<IToken, IToken, QAfterFilterCondition> userUniqIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userUniqId',
        value: '',
      ));
    });
  }
}

extension ITokenQueryObject on QueryBuilder<IToken, IToken, QFilterCondition> {}

extension ITokenQueryLinks on QueryBuilder<IToken, IToken, QFilterCondition> {}

extension ITokenQuerySortBy on QueryBuilder<IToken, IToken, QSortBy> {
  QueryBuilder<IToken, IToken, QAfterSortBy> sortByAccessToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessToken', Sort.asc);
    });
  }

  QueryBuilder<IToken, IToken, QAfterSortBy> sortByAccessTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessToken', Sort.desc);
    });
  }

  QueryBuilder<IToken, IToken, QAfterSortBy> sortByRefreshToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refreshToken', Sort.asc);
    });
  }

  QueryBuilder<IToken, IToken, QAfterSortBy> sortByRefreshTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refreshToken', Sort.desc);
    });
  }

  QueryBuilder<IToken, IToken, QAfterSortBy> sortByUserUniqId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userUniqId', Sort.asc);
    });
  }

  QueryBuilder<IToken, IToken, QAfterSortBy> sortByUserUniqIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userUniqId', Sort.desc);
    });
  }
}

extension ITokenQuerySortThenBy on QueryBuilder<IToken, IToken, QSortThenBy> {
  QueryBuilder<IToken, IToken, QAfterSortBy> thenByAccessToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessToken', Sort.asc);
    });
  }

  QueryBuilder<IToken, IToken, QAfterSortBy> thenByAccessTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessToken', Sort.desc);
    });
  }

  QueryBuilder<IToken, IToken, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IToken, IToken, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IToken, IToken, QAfterSortBy> thenByRefreshToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refreshToken', Sort.asc);
    });
  }

  QueryBuilder<IToken, IToken, QAfterSortBy> thenByRefreshTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refreshToken', Sort.desc);
    });
  }

  QueryBuilder<IToken, IToken, QAfterSortBy> thenByUserUniqId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userUniqId', Sort.asc);
    });
  }

  QueryBuilder<IToken, IToken, QAfterSortBy> thenByUserUniqIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userUniqId', Sort.desc);
    });
  }
}

extension ITokenQueryWhereDistinct on QueryBuilder<IToken, IToken, QDistinct> {
  QueryBuilder<IToken, IToken, QDistinct> distinctByAccessToken(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accessToken', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IToken, IToken, QDistinct> distinctByRefreshToken(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'refreshToken', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IToken, IToken, QDistinct> distinctByUserUniqId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userUniqId', caseSensitive: caseSensitive);
    });
  }
}

extension ITokenQueryProperty on QueryBuilder<IToken, IToken, QQueryProperty> {
  QueryBuilder<IToken, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IToken, String, QQueryOperations> accessTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accessToken');
    });
  }

  QueryBuilder<IToken, String, QQueryOperations> refreshTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'refreshToken');
    });
  }

  QueryBuilder<IToken, String, QQueryOperations> userUniqIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userUniqId');
    });
  }
}
