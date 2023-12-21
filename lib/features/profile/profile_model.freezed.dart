// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) {
  return _ProfileData.fromJson(json);
}

/// @nodoc
mixin _$ProfileData {
  @JsonKey(name: 'user_uniq_id')
  String get userUniqId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_status')
  int get userStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_type')
  int get userType => throw _privateConstructorUsedError;
  @JsonKey(name: 'nation')
  int get nation => throw _privateConstructorUsedError;
  @JsonKey(name: 'gender')
  int get gender => throw _privateConstructorUsedError;
  @JsonKey(name: 'nickname')
  String get nickname => throw _privateConstructorUsedError;
  @JsonKey(name: 'birthday')
  @DateTimeConverter()
  DateTime get birthday => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'default_language')
  String? get defaultLanguage => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_pic')
  @PicListConverter()
  List<String> get profilePic => throw _privateConstructorUsedError;
  @JsonKey(name: 'interests')
  String? get interests => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  @DateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  @DateTimeConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: "able_language")
  @IntListConverter()
  List<int> get ableLanguage => throw _privateConstructorUsedError;
  @JsonKey(name: "user_temperature")
  int get userTemperature => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileDataCopyWith<ProfileData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileDataCopyWith<$Res> {
  factory $ProfileDataCopyWith(
          ProfileData value, $Res Function(ProfileData) then) =
      _$ProfileDataCopyWithImpl<$Res, ProfileData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_uniq_id') String userUniqId,
      @JsonKey(name: 'user_status') int userStatus,
      @JsonKey(name: 'user_type') int userType,
      @JsonKey(name: 'nation') int nation,
      @JsonKey(name: 'gender') int gender,
      @JsonKey(name: 'nickname') String nickname,
      @JsonKey(name: 'birthday') @DateTimeConverter() DateTime birthday,
      @JsonKey(name: 'description') String description,
      @JsonKey(name: 'default_language') String? defaultLanguage,
      @JsonKey(name: 'profile_pic') @PicListConverter() List<String> profilePic,
      @JsonKey(name: 'interests') String? interests,
      @JsonKey(name: 'created_at') @DateTimeConverter() DateTime createdAt,
      @JsonKey(name: 'updated_at') @DateTimeConverter() DateTime updatedAt,
      @JsonKey(name: "able_language")
      @IntListConverter()
      List<int> ableLanguage,
      @JsonKey(name: "user_temperature") int userTemperature});
}

/// @nodoc
class _$ProfileDataCopyWithImpl<$Res, $Val extends ProfileData>
    implements $ProfileDataCopyWith<$Res> {
  _$ProfileDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUniqId = null,
    Object? userStatus = null,
    Object? userType = null,
    Object? nation = null,
    Object? gender = null,
    Object? nickname = null,
    Object? birthday = null,
    Object? description = null,
    Object? defaultLanguage = freezed,
    Object? profilePic = null,
    Object? interests = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? ableLanguage = null,
    Object? userTemperature = null,
  }) {
    return _then(_value.copyWith(
      userUniqId: null == userUniqId
          ? _value.userUniqId
          : userUniqId // ignore: cast_nullable_to_non_nullable
              as String,
      userStatus: null == userStatus
          ? _value.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as int,
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as int,
      nation: null == nation
          ? _value.nation
          : nation // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      birthday: null == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      defaultLanguage: freezed == defaultLanguage
          ? _value.defaultLanguage
          : defaultLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePic: null == profilePic
          ? _value.profilePic
          : profilePic // ignore: cast_nullable_to_non_nullable
              as List<String>,
      interests: freezed == interests
          ? _value.interests
          : interests // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ableLanguage: null == ableLanguage
          ? _value.ableLanguage
          : ableLanguage // ignore: cast_nullable_to_non_nullable
              as List<int>,
      userTemperature: null == userTemperature
          ? _value.userTemperature
          : userTemperature // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileDataImplCopyWith<$Res>
    implements $ProfileDataCopyWith<$Res> {
  factory _$$ProfileDataImplCopyWith(
          _$ProfileDataImpl value, $Res Function(_$ProfileDataImpl) then) =
      __$$ProfileDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user_uniq_id') String userUniqId,
      @JsonKey(name: 'user_status') int userStatus,
      @JsonKey(name: 'user_type') int userType,
      @JsonKey(name: 'nation') int nation,
      @JsonKey(name: 'gender') int gender,
      @JsonKey(name: 'nickname') String nickname,
      @JsonKey(name: 'birthday') @DateTimeConverter() DateTime birthday,
      @JsonKey(name: 'description') String description,
      @JsonKey(name: 'default_language') String? defaultLanguage,
      @JsonKey(name: 'profile_pic') @PicListConverter() List<String> profilePic,
      @JsonKey(name: 'interests') String? interests,
      @JsonKey(name: 'created_at') @DateTimeConverter() DateTime createdAt,
      @JsonKey(name: 'updated_at') @DateTimeConverter() DateTime updatedAt,
      @JsonKey(name: "able_language")
      @IntListConverter()
      List<int> ableLanguage,
      @JsonKey(name: "user_temperature") int userTemperature});
}

/// @nodoc
class __$$ProfileDataImplCopyWithImpl<$Res>
    extends _$ProfileDataCopyWithImpl<$Res, _$ProfileDataImpl>
    implements _$$ProfileDataImplCopyWith<$Res> {
  __$$ProfileDataImplCopyWithImpl(
      _$ProfileDataImpl _value, $Res Function(_$ProfileDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUniqId = null,
    Object? userStatus = null,
    Object? userType = null,
    Object? nation = null,
    Object? gender = null,
    Object? nickname = null,
    Object? birthday = null,
    Object? description = null,
    Object? defaultLanguage = freezed,
    Object? profilePic = null,
    Object? interests = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? ableLanguage = null,
    Object? userTemperature = null,
  }) {
    return _then(_$ProfileDataImpl(
      userUniqId: null == userUniqId
          ? _value.userUniqId
          : userUniqId // ignore: cast_nullable_to_non_nullable
              as String,
      userStatus: null == userStatus
          ? _value.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as int,
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as int,
      nation: null == nation
          ? _value.nation
          : nation // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      birthday: null == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      defaultLanguage: freezed == defaultLanguage
          ? _value.defaultLanguage
          : defaultLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePic: null == profilePic
          ? _value._profilePic
          : profilePic // ignore: cast_nullable_to_non_nullable
              as List<String>,
      interests: freezed == interests
          ? _value.interests
          : interests // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ableLanguage: null == ableLanguage
          ? _value._ableLanguage
          : ableLanguage // ignore: cast_nullable_to_non_nullable
              as List<int>,
      userTemperature: null == userTemperature
          ? _value.userTemperature
          : userTemperature // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileDataImpl implements _ProfileData {
  const _$ProfileDataImpl(
      {@JsonKey(name: 'user_uniq_id') required this.userUniqId,
      @JsonKey(name: 'user_status') required this.userStatus,
      @JsonKey(name: 'user_type') required this.userType,
      @JsonKey(name: 'nation') required this.nation,
      @JsonKey(name: 'gender') required this.gender,
      @JsonKey(name: 'nickname') required this.nickname,
      @JsonKey(name: 'birthday') @DateTimeConverter() required this.birthday,
      @JsonKey(name: 'description') required this.description,
      @JsonKey(name: 'default_language') required this.defaultLanguage,
      @JsonKey(name: 'profile_pic')
      @PicListConverter()
      required final List<String> profilePic,
      @JsonKey(name: 'interests') required this.interests,
      @JsonKey(name: 'created_at') @DateTimeConverter() required this.createdAt,
      @JsonKey(name: 'updated_at') @DateTimeConverter() required this.updatedAt,
      @JsonKey(name: "able_language")
      @IntListConverter()
      required final List<int> ableLanguage,
      @JsonKey(name: "user_temperature") required this.userTemperature})
      : _profilePic = profilePic,
        _ableLanguage = ableLanguage;

  factory _$ProfileDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileDataImplFromJson(json);

  @override
  @JsonKey(name: 'user_uniq_id')
  final String userUniqId;
  @override
  @JsonKey(name: 'user_status')
  final int userStatus;
  @override
  @JsonKey(name: 'user_type')
  final int userType;
  @override
  @JsonKey(name: 'nation')
  final int nation;
  @override
  @JsonKey(name: 'gender')
  final int gender;
  @override
  @JsonKey(name: 'nickname')
  final String nickname;
  @override
  @JsonKey(name: 'birthday')
  @DateTimeConverter()
  final DateTime birthday;
  @override
  @JsonKey(name: 'description')
  final String description;
  @override
  @JsonKey(name: 'default_language')
  final String? defaultLanguage;
  final List<String> _profilePic;
  @override
  @JsonKey(name: 'profile_pic')
  @PicListConverter()
  List<String> get profilePic {
    if (_profilePic is EqualUnmodifiableListView) return _profilePic;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_profilePic);
  }

  @override
  @JsonKey(name: 'interests')
  final String? interests;
  @override
  @JsonKey(name: 'created_at')
  @DateTimeConverter()
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  @DateTimeConverter()
  final DateTime updatedAt;
  final List<int> _ableLanguage;
  @override
  @JsonKey(name: "able_language")
  @IntListConverter()
  List<int> get ableLanguage {
    if (_ableLanguage is EqualUnmodifiableListView) return _ableLanguage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ableLanguage);
  }

  @override
  @JsonKey(name: "user_temperature")
  final int userTemperature;

  @override
  String toString() {
    return 'ProfileData(userUniqId: $userUniqId, userStatus: $userStatus, userType: $userType, nation: $nation, gender: $gender, nickname: $nickname, birthday: $birthday, description: $description, defaultLanguage: $defaultLanguage, profilePic: $profilePic, interests: $interests, createdAt: $createdAt, updatedAt: $updatedAt, ableLanguage: $ableLanguage, userTemperature: $userTemperature)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileDataImpl &&
            (identical(other.userUniqId, userUniqId) ||
                other.userUniqId == userUniqId) &&
            (identical(other.userStatus, userStatus) ||
                other.userStatus == userStatus) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.nation, nation) || other.nation == nation) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.defaultLanguage, defaultLanguage) ||
                other.defaultLanguage == defaultLanguage) &&
            const DeepCollectionEquality()
                .equals(other._profilePic, _profilePic) &&
            (identical(other.interests, interests) ||
                other.interests == interests) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality()
                .equals(other._ableLanguage, _ableLanguage) &&
            (identical(other.userTemperature, userTemperature) ||
                other.userTemperature == userTemperature));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userUniqId,
      userStatus,
      userType,
      nation,
      gender,
      nickname,
      birthday,
      description,
      defaultLanguage,
      const DeepCollectionEquality().hash(_profilePic),
      interests,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_ableLanguage),
      userTemperature);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileDataImplCopyWith<_$ProfileDataImpl> get copyWith =>
      __$$ProfileDataImplCopyWithImpl<_$ProfileDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileDataImplToJson(
      this,
    );
  }
}

abstract class _ProfileData implements ProfileData {
  const factory _ProfileData(
      {@JsonKey(name: 'user_uniq_id') required final String userUniqId,
      @JsonKey(name: 'user_status') required final int userStatus,
      @JsonKey(name: 'user_type') required final int userType,
      @JsonKey(name: 'nation') required final int nation,
      @JsonKey(name: 'gender') required final int gender,
      @JsonKey(name: 'nickname') required final String nickname,
      @JsonKey(name: 'birthday')
      @DateTimeConverter()
      required final DateTime birthday,
      @JsonKey(name: 'description') required final String description,
      @JsonKey(name: 'default_language') required final String? defaultLanguage,
      @JsonKey(name: 'profile_pic')
      @PicListConverter()
      required final List<String> profilePic,
      @JsonKey(name: 'interests') required final String? interests,
      @JsonKey(name: 'created_at')
      @DateTimeConverter()
      required final DateTime createdAt,
      @JsonKey(name: 'updated_at')
      @DateTimeConverter()
      required final DateTime updatedAt,
      @JsonKey(name: "able_language")
      @IntListConverter()
      required final List<int> ableLanguage,
      @JsonKey(name: "user_temperature")
      required final int userTemperature}) = _$ProfileDataImpl;

  factory _ProfileData.fromJson(Map<String, dynamic> json) =
      _$ProfileDataImpl.fromJson;

  @override
  @JsonKey(name: 'user_uniq_id')
  String get userUniqId;
  @override
  @JsonKey(name: 'user_status')
  int get userStatus;
  @override
  @JsonKey(name: 'user_type')
  int get userType;
  @override
  @JsonKey(name: 'nation')
  int get nation;
  @override
  @JsonKey(name: 'gender')
  int get gender;
  @override
  @JsonKey(name: 'nickname')
  String get nickname;
  @override
  @JsonKey(name: 'birthday')
  @DateTimeConverter()
  DateTime get birthday;
  @override
  @JsonKey(name: 'description')
  String get description;
  @override
  @JsonKey(name: 'default_language')
  String? get defaultLanguage;
  @override
  @JsonKey(name: 'profile_pic')
  @PicListConverter()
  List<String> get profilePic;
  @override
  @JsonKey(name: 'interests')
  String? get interests;
  @override
  @JsonKey(name: 'created_at')
  @DateTimeConverter()
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  @DateTimeConverter()
  DateTime get updatedAt;
  @override
  @JsonKey(name: "able_language")
  @IntListConverter()
  List<int> get ableLanguage;
  @override
  @JsonKey(name: "user_temperature")
  int get userTemperature;
  @override
  @JsonKey(ignore: true)
  _$$ProfileDataImplCopyWith<_$ProfileDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
