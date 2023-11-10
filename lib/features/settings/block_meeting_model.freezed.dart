// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'block_meeting_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BlockMeetingData _$BlockMeetingDataFromJson(Map<String, dynamic> json) {
  return _BlockMeetingData.fromJson(json);
}

/// @nodoc
mixin _$BlockMeetingData {
  @JsonKey(name: 'post_id')
  String get postId => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_nickname')
  String get authorNickname => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BlockMeetingDataCopyWith<BlockMeetingData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlockMeetingDataCopyWith<$Res> {
  factory $BlockMeetingDataCopyWith(
          BlockMeetingData value, $Res Function(BlockMeetingData) then) =
      _$BlockMeetingDataCopyWithImpl<$Res, BlockMeetingData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'post_id') String postId,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'author_nickname') String authorNickname});
}

/// @nodoc
class _$BlockMeetingDataCopyWithImpl<$Res, $Val extends BlockMeetingData>
    implements $BlockMeetingDataCopyWith<$Res> {
  _$BlockMeetingDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? title = null,
    Object? authorNickname = null,
  }) {
    return _then(_value.copyWith(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authorNickname: null == authorNickname
          ? _value.authorNickname
          : authorNickname // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BlockMeetingDataImplCopyWith<$Res>
    implements $BlockMeetingDataCopyWith<$Res> {
  factory _$$BlockMeetingDataImplCopyWith(_$BlockMeetingDataImpl value,
          $Res Function(_$BlockMeetingDataImpl) then) =
      __$$BlockMeetingDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'post_id') String postId,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'author_nickname') String authorNickname});
}

/// @nodoc
class __$$BlockMeetingDataImplCopyWithImpl<$Res>
    extends _$BlockMeetingDataCopyWithImpl<$Res, _$BlockMeetingDataImpl>
    implements _$$BlockMeetingDataImplCopyWith<$Res> {
  __$$BlockMeetingDataImplCopyWithImpl(_$BlockMeetingDataImpl _value,
      $Res Function(_$BlockMeetingDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? title = null,
    Object? authorNickname = null,
  }) {
    return _then(_$BlockMeetingDataImpl(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authorNickname: null == authorNickname
          ? _value.authorNickname
          : authorNickname // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BlockMeetingDataImpl implements _BlockMeetingData {
  const _$BlockMeetingDataImpl(
      {@JsonKey(name: 'post_id') required this.postId,
      @JsonKey(name: 'title') required this.title,
      @JsonKey(name: 'author_nickname') required this.authorNickname});

  factory _$BlockMeetingDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$BlockMeetingDataImplFromJson(json);

  @override
  @JsonKey(name: 'post_id')
  final String postId;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'author_nickname')
  final String authorNickname;

  @override
  String toString() {
    return 'BlockMeetingData(postId: $postId, title: $title, authorNickname: $authorNickname)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockMeetingDataImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.authorNickname, authorNickname) ||
                other.authorNickname == authorNickname));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, postId, title, authorNickname);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockMeetingDataImplCopyWith<_$BlockMeetingDataImpl> get copyWith =>
      __$$BlockMeetingDataImplCopyWithImpl<_$BlockMeetingDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BlockMeetingDataImplToJson(
      this,
    );
  }
}

abstract class _BlockMeetingData implements BlockMeetingData {
  const factory _BlockMeetingData(
      {@JsonKey(name: 'post_id') required final String postId,
      @JsonKey(name: 'title') required final String title,
      @JsonKey(name: 'author_nickname')
      required final String authorNickname}) = _$BlockMeetingDataImpl;

  factory _BlockMeetingData.fromJson(Map<String, dynamic> json) =
      _$BlockMeetingDataImpl.fromJson;

  @override
  @JsonKey(name: 'post_id')
  String get postId;
  @override
  @JsonKey(name: 'title')
  String get title;
  @override
  @JsonKey(name: 'author_nickname')
  String get authorNickname;
  @override
  @JsonKey(ignore: true)
  _$$BlockMeetingDataImplCopyWith<_$BlockMeetingDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
