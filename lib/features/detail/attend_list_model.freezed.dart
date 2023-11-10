// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attend_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AttendListData _$AttendListDataFromJson(Map<String, dynamic> json) {
  return _AttendListData.fromJson(json);
}

/// @nodoc
mixin _$AttendListData {
  @JsonKey(name: 'user_uniq_id')
  String get userUniqId =>
      throw _privateConstructorUsedError; // @JsonKey(name: 'user_status') required int userStatus,
  @JsonKey(name: 'user_type')
  int get userType => throw _privateConstructorUsedError;
  @JsonKey(name: 'nation')
  int get nation => throw _privateConstructorUsedError;
  @JsonKey(name: 'nick_name')
  String get nickname => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_pic')
  @PicListConverter()
  List<String> get profilePic => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendListDataCopyWith<AttendListData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendListDataCopyWith<$Res> {
  factory $AttendListDataCopyWith(
          AttendListData value, $Res Function(AttendListData) then) =
      _$AttendListDataCopyWithImpl<$Res, AttendListData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_uniq_id') String userUniqId,
      @JsonKey(name: 'user_type') int userType,
      @JsonKey(name: 'nation') int nation,
      @JsonKey(name: 'nick_name') String nickname,
      @JsonKey(name: 'profile_pic')
      @PicListConverter()
      List<String> profilePic});
}

/// @nodoc
class _$AttendListDataCopyWithImpl<$Res, $Val extends AttendListData>
    implements $AttendListDataCopyWith<$Res> {
  _$AttendListDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUniqId = null,
    Object? userType = null,
    Object? nation = null,
    Object? nickname = null,
    Object? profilePic = null,
  }) {
    return _then(_value.copyWith(
      userUniqId: null == userUniqId
          ? _value.userUniqId
          : userUniqId // ignore: cast_nullable_to_non_nullable
              as String,
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as int,
      nation: null == nation
          ? _value.nation
          : nation // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      profilePic: null == profilePic
          ? _value.profilePic
          : profilePic // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendListDataImplCopyWith<$Res>
    implements $AttendListDataCopyWith<$Res> {
  factory _$$AttendListDataImplCopyWith(_$AttendListDataImpl value,
          $Res Function(_$AttendListDataImpl) then) =
      __$$AttendListDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user_uniq_id') String userUniqId,
      @JsonKey(name: 'user_type') int userType,
      @JsonKey(name: 'nation') int nation,
      @JsonKey(name: 'nick_name') String nickname,
      @JsonKey(name: 'profile_pic')
      @PicListConverter()
      List<String> profilePic});
}

/// @nodoc
class __$$AttendListDataImplCopyWithImpl<$Res>
    extends _$AttendListDataCopyWithImpl<$Res, _$AttendListDataImpl>
    implements _$$AttendListDataImplCopyWith<$Res> {
  __$$AttendListDataImplCopyWithImpl(
      _$AttendListDataImpl _value, $Res Function(_$AttendListDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUniqId = null,
    Object? userType = null,
    Object? nation = null,
    Object? nickname = null,
    Object? profilePic = null,
  }) {
    return _then(_$AttendListDataImpl(
      userUniqId: null == userUniqId
          ? _value.userUniqId
          : userUniqId // ignore: cast_nullable_to_non_nullable
              as String,
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as int,
      nation: null == nation
          ? _value.nation
          : nation // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      profilePic: null == profilePic
          ? _value._profilePic
          : profilePic // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendListDataImpl implements _AttendListData {
  const _$AttendListDataImpl(
      {@JsonKey(name: 'user_uniq_id') required this.userUniqId,
      @JsonKey(name: 'user_type') required this.userType,
      @JsonKey(name: 'nation') required this.nation,
      @JsonKey(name: 'nick_name') required this.nickname,
      @JsonKey(name: 'profile_pic')
      @PicListConverter()
      required final List<String> profilePic})
      : _profilePic = profilePic;

  factory _$AttendListDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendListDataImplFromJson(json);

  @override
  @JsonKey(name: 'user_uniq_id')
  final String userUniqId;
// @JsonKey(name: 'user_status') required int userStatus,
  @override
  @JsonKey(name: 'user_type')
  final int userType;
  @override
  @JsonKey(name: 'nation')
  final int nation;
  @override
  @JsonKey(name: 'nick_name')
  final String nickname;
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
  String toString() {
    return 'AttendListData(userUniqId: $userUniqId, userType: $userType, nation: $nation, nickname: $nickname, profilePic: $profilePic)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendListDataImpl &&
            (identical(other.userUniqId, userUniqId) ||
                other.userUniqId == userUniqId) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.nation, nation) || other.nation == nation) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            const DeepCollectionEquality()
                .equals(other._profilePic, _profilePic));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userUniqId, userType, nation,
      nickname, const DeepCollectionEquality().hash(_profilePic));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendListDataImplCopyWith<_$AttendListDataImpl> get copyWith =>
      __$$AttendListDataImplCopyWithImpl<_$AttendListDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendListDataImplToJson(
      this,
    );
  }
}

abstract class _AttendListData implements AttendListData {
  const factory _AttendListData(
      {@JsonKey(name: 'user_uniq_id') required final String userUniqId,
      @JsonKey(name: 'user_type') required final int userType,
      @JsonKey(name: 'nation') required final int nation,
      @JsonKey(name: 'nick_name') required final String nickname,
      @JsonKey(name: 'profile_pic')
      @PicListConverter()
      required final List<String> profilePic}) = _$AttendListDataImpl;

  factory _AttendListData.fromJson(Map<String, dynamic> json) =
      _$AttendListDataImpl.fromJson;

  @override
  @JsonKey(name: 'user_uniq_id')
  String get userUniqId;
  @override // @JsonKey(name: 'user_status') required int userStatus,
  @JsonKey(name: 'user_type')
  int get userType;
  @override
  @JsonKey(name: 'nation')
  int get nation;
  @override
  @JsonKey(name: 'nick_name')
  String get nickname;
  @override
  @JsonKey(name: 'profile_pic')
  @PicListConverter()
  List<String> get profilePic;
  @override
  @JsonKey(ignore: true)
  _$$AttendListDataImplCopyWith<_$AttendListDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
