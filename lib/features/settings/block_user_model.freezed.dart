// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'block_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BlockUserData _$BlockUserDataFromJson(Map<String, dynamic> json) {
  return _BlockUserData.fromJson(json);
}

/// @nodoc
mixin _$BlockUserData {
  @JsonKey(name: 'user_uniq_id')
  String get userUniqId => throw _privateConstructorUsedError;
  @JsonKey(name: 'nickname')
  String get nickname => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BlockUserDataCopyWith<BlockUserData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlockUserDataCopyWith<$Res> {
  factory $BlockUserDataCopyWith(
          BlockUserData value, $Res Function(BlockUserData) then) =
      _$BlockUserDataCopyWithImpl<$Res, BlockUserData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_uniq_id') String userUniqId,
      @JsonKey(name: 'nickname') String nickname});
}

/// @nodoc
class _$BlockUserDataCopyWithImpl<$Res, $Val extends BlockUserData>
    implements $BlockUserDataCopyWith<$Res> {
  _$BlockUserDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUniqId = null,
    Object? nickname = null,
  }) {
    return _then(_value.copyWith(
      userUniqId: null == userUniqId
          ? _value.userUniqId
          : userUniqId // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BlockUserDataImplCopyWith<$Res>
    implements $BlockUserDataCopyWith<$Res> {
  factory _$$BlockUserDataImplCopyWith(
          _$BlockUserDataImpl value, $Res Function(_$BlockUserDataImpl) then) =
      __$$BlockUserDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user_uniq_id') String userUniqId,
      @JsonKey(name: 'nickname') String nickname});
}

/// @nodoc
class __$$BlockUserDataImplCopyWithImpl<$Res>
    extends _$BlockUserDataCopyWithImpl<$Res, _$BlockUserDataImpl>
    implements _$$BlockUserDataImplCopyWith<$Res> {
  __$$BlockUserDataImplCopyWithImpl(
      _$BlockUserDataImpl _value, $Res Function(_$BlockUserDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUniqId = null,
    Object? nickname = null,
  }) {
    return _then(_$BlockUserDataImpl(
      userUniqId: null == userUniqId
          ? _value.userUniqId
          : userUniqId // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BlockUserDataImpl implements _BlockUserData {
  const _$BlockUserDataImpl(
      {@JsonKey(name: 'user_uniq_id') required this.userUniqId,
      @JsonKey(name: 'nickname') required this.nickname});

  factory _$BlockUserDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$BlockUserDataImplFromJson(json);

  @override
  @JsonKey(name: 'user_uniq_id')
  final String userUniqId;
  @override
  @JsonKey(name: 'nickname')
  final String nickname;

  @override
  String toString() {
    return 'BlockUserData(userUniqId: $userUniqId, nickname: $nickname)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockUserDataImpl &&
            (identical(other.userUniqId, userUniqId) ||
                other.userUniqId == userUniqId) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userUniqId, nickname);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockUserDataImplCopyWith<_$BlockUserDataImpl> get copyWith =>
      __$$BlockUserDataImplCopyWithImpl<_$BlockUserDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BlockUserDataImplToJson(
      this,
    );
  }
}

abstract class _BlockUserData implements BlockUserData {
  const factory _BlockUserData(
          {@JsonKey(name: 'user_uniq_id') required final String userUniqId,
          @JsonKey(name: 'nickname') required final String nickname}) =
      _$BlockUserDataImpl;

  factory _BlockUserData.fromJson(Map<String, dynamic> json) =
      _$BlockUserDataImpl.fromJson;

  @override
  @JsonKey(name: 'user_uniq_id')
  String get userUniqId;
  @override
  @JsonKey(name: 'nickname')
  String get nickname;
  @override
  @JsonKey(ignore: true)
  _$$BlockUserDataImplCopyWith<_$BlockUserDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
