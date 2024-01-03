// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reply_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReplyData _$ReplyDataFromJson(Map<String, dynamic> json) {
  return _ReplyData.fromJson(json);
}

/// @nodoc
mixin _$ReplyData {
  @JsonKey(name: 'reply_id')
  int get replyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'content')
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  int get authorStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'post_status')
  int? get postStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_picture')
  @PicListConverter()
  List<String> get authorPicture => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_nickname')
  String get authorNickname => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_nation')
  int? get authorNation => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_type')
  int? get userType => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_uniq_id')
  String get userUniqId => throw _privateConstructorUsedError;
  @JsonKey(name: 'create_at')
  @DateTimeConverter()
  DateTime get createAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'update_at')
  @DateTimeConverter()
  DateTime? get updateAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReplyDataCopyWith<ReplyData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReplyDataCopyWith<$Res> {
  factory $ReplyDataCopyWith(ReplyData value, $Res Function(ReplyData) then) =
      _$ReplyDataCopyWithImpl<$Res, ReplyData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'reply_id') int replyId,
      @JsonKey(name: 'content') String content,
      @JsonKey(name: 'status') int authorStatus,
      @JsonKey(name: 'post_status') int? postStatus,
      @JsonKey(name: 'author_picture')
      @PicListConverter()
      List<String> authorPicture,
      @JsonKey(name: 'author_nickname') String authorNickname,
      @JsonKey(name: 'author_nation') int? authorNation,
      @JsonKey(name: 'user_type') int? userType,
      @JsonKey(name: 'user_uniq_id') String userUniqId,
      @JsonKey(name: 'create_at') @DateTimeConverter() DateTime createAt,
      @JsonKey(name: 'update_at') @DateTimeConverter() DateTime? updateAt});
}

/// @nodoc
class _$ReplyDataCopyWithImpl<$Res, $Val extends ReplyData>
    implements $ReplyDataCopyWith<$Res> {
  _$ReplyDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? replyId = null,
    Object? content = null,
    Object? authorStatus = null,
    Object? postStatus = freezed,
    Object? authorPicture = null,
    Object? authorNickname = null,
    Object? authorNation = freezed,
    Object? userType = freezed,
    Object? userUniqId = null,
    Object? createAt = null,
    Object? updateAt = freezed,
  }) {
    return _then(_value.copyWith(
      replyId: null == replyId
          ? _value.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      authorStatus: null == authorStatus
          ? _value.authorStatus
          : authorStatus // ignore: cast_nullable_to_non_nullable
              as int,
      postStatus: freezed == postStatus
          ? _value.postStatus
          : postStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      authorPicture: null == authorPicture
          ? _value.authorPicture
          : authorPicture // ignore: cast_nullable_to_non_nullable
              as List<String>,
      authorNickname: null == authorNickname
          ? _value.authorNickname
          : authorNickname // ignore: cast_nullable_to_non_nullable
              as String,
      authorNation: freezed == authorNation
          ? _value.authorNation
          : authorNation // ignore: cast_nullable_to_non_nullable
              as int?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as int?,
      userUniqId: null == userUniqId
          ? _value.userUniqId
          : userUniqId // ignore: cast_nullable_to_non_nullable
              as String,
      createAt: null == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updateAt: freezed == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReplyDataImplCopyWith<$Res>
    implements $ReplyDataCopyWith<$Res> {
  factory _$$ReplyDataImplCopyWith(
          _$ReplyDataImpl value, $Res Function(_$ReplyDataImpl) then) =
      __$$ReplyDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'reply_id') int replyId,
      @JsonKey(name: 'content') String content,
      @JsonKey(name: 'status') int authorStatus,
      @JsonKey(name: 'post_status') int? postStatus,
      @JsonKey(name: 'author_picture')
      @PicListConverter()
      List<String> authorPicture,
      @JsonKey(name: 'author_nickname') String authorNickname,
      @JsonKey(name: 'author_nation') int? authorNation,
      @JsonKey(name: 'user_type') int? userType,
      @JsonKey(name: 'user_uniq_id') String userUniqId,
      @JsonKey(name: 'create_at') @DateTimeConverter() DateTime createAt,
      @JsonKey(name: 'update_at') @DateTimeConverter() DateTime? updateAt});
}

/// @nodoc
class __$$ReplyDataImplCopyWithImpl<$Res>
    extends _$ReplyDataCopyWithImpl<$Res, _$ReplyDataImpl>
    implements _$$ReplyDataImplCopyWith<$Res> {
  __$$ReplyDataImplCopyWithImpl(
      _$ReplyDataImpl _value, $Res Function(_$ReplyDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? replyId = null,
    Object? content = null,
    Object? authorStatus = null,
    Object? postStatus = freezed,
    Object? authorPicture = null,
    Object? authorNickname = null,
    Object? authorNation = freezed,
    Object? userType = freezed,
    Object? userUniqId = null,
    Object? createAt = null,
    Object? updateAt = freezed,
  }) {
    return _then(_$ReplyDataImpl(
      replyId: null == replyId
          ? _value.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      authorStatus: null == authorStatus
          ? _value.authorStatus
          : authorStatus // ignore: cast_nullable_to_non_nullable
              as int,
      postStatus: freezed == postStatus
          ? _value.postStatus
          : postStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      authorPicture: null == authorPicture
          ? _value._authorPicture
          : authorPicture // ignore: cast_nullable_to_non_nullable
              as List<String>,
      authorNickname: null == authorNickname
          ? _value.authorNickname
          : authorNickname // ignore: cast_nullable_to_non_nullable
              as String,
      authorNation: freezed == authorNation
          ? _value.authorNation
          : authorNation // ignore: cast_nullable_to_non_nullable
              as int?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as int?,
      userUniqId: null == userUniqId
          ? _value.userUniqId
          : userUniqId // ignore: cast_nullable_to_non_nullable
              as String,
      createAt: null == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updateAt: freezed == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReplyDataImpl implements _ReplyData {
  const _$ReplyDataImpl(
      {@JsonKey(name: 'reply_id') required this.replyId,
      @JsonKey(name: 'content') required this.content,
      @JsonKey(name: 'status') required this.authorStatus,
      @JsonKey(name: 'post_status') this.postStatus,
      @JsonKey(name: 'author_picture')
      @PicListConverter()
      required final List<String> authorPicture,
      @JsonKey(name: 'author_nickname') required this.authorNickname,
      @JsonKey(name: 'author_nation') this.authorNation,
      @JsonKey(name: 'user_type') this.userType,
      @JsonKey(name: 'user_uniq_id') required this.userUniqId,
      @JsonKey(name: 'create_at') @DateTimeConverter() required this.createAt,
      @JsonKey(name: 'update_at') @DateTimeConverter() this.updateAt})
      : _authorPicture = authorPicture;

  factory _$ReplyDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReplyDataImplFromJson(json);

  @override
  @JsonKey(name: 'reply_id')
  final int replyId;
  @override
  @JsonKey(name: 'content')
  final String content;
  @override
  @JsonKey(name: 'status')
  final int authorStatus;
  @override
  @JsonKey(name: 'post_status')
  final int? postStatus;
  final List<String> _authorPicture;
  @override
  @JsonKey(name: 'author_picture')
  @PicListConverter()
  List<String> get authorPicture {
    if (_authorPicture is EqualUnmodifiableListView) return _authorPicture;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_authorPicture);
  }

  @override
  @JsonKey(name: 'author_nickname')
  final String authorNickname;
  @override
  @JsonKey(name: 'author_nation')
  final int? authorNation;
  @override
  @JsonKey(name: 'user_type')
  final int? userType;
  @override
  @JsonKey(name: 'user_uniq_id')
  final String userUniqId;
  @override
  @JsonKey(name: 'create_at')
  @DateTimeConverter()
  final DateTime createAt;
  @override
  @JsonKey(name: 'update_at')
  @DateTimeConverter()
  final DateTime? updateAt;

  @override
  String toString() {
    return 'ReplyData(replyId: $replyId, content: $content, authorStatus: $authorStatus, postStatus: $postStatus, authorPicture: $authorPicture, authorNickname: $authorNickname, authorNation: $authorNation, userType: $userType, userUniqId: $userUniqId, createAt: $createAt, updateAt: $updateAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReplyDataImpl &&
            (identical(other.replyId, replyId) || other.replyId == replyId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.authorStatus, authorStatus) ||
                other.authorStatus == authorStatus) &&
            (identical(other.postStatus, postStatus) ||
                other.postStatus == postStatus) &&
            const DeepCollectionEquality()
                .equals(other._authorPicture, _authorPicture) &&
            (identical(other.authorNickname, authorNickname) ||
                other.authorNickname == authorNickname) &&
            (identical(other.authorNation, authorNation) ||
                other.authorNation == authorNation) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.userUniqId, userUniqId) ||
                other.userUniqId == userUniqId) &&
            (identical(other.createAt, createAt) ||
                other.createAt == createAt) &&
            (identical(other.updateAt, updateAt) ||
                other.updateAt == updateAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      replyId,
      content,
      authorStatus,
      postStatus,
      const DeepCollectionEquality().hash(_authorPicture),
      authorNickname,
      authorNation,
      userType,
      userUniqId,
      createAt,
      updateAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReplyDataImplCopyWith<_$ReplyDataImpl> get copyWith =>
      __$$ReplyDataImplCopyWithImpl<_$ReplyDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReplyDataImplToJson(
      this,
    );
  }
}

abstract class _ReplyData implements ReplyData {
  const factory _ReplyData(
      {@JsonKey(name: 'reply_id') required final int replyId,
      @JsonKey(name: 'content') required final String content,
      @JsonKey(name: 'status') required final int authorStatus,
      @JsonKey(name: 'post_status') final int? postStatus,
      @JsonKey(name: 'author_picture')
      @PicListConverter()
      required final List<String> authorPicture,
      @JsonKey(name: 'author_nickname') required final String authorNickname,
      @JsonKey(name: 'author_nation') final int? authorNation,
      @JsonKey(name: 'user_type') final int? userType,
      @JsonKey(name: 'user_uniq_id') required final String userUniqId,
      @JsonKey(name: 'create_at')
      @DateTimeConverter()
      required final DateTime createAt,
      @JsonKey(name: 'update_at')
      @DateTimeConverter()
      final DateTime? updateAt}) = _$ReplyDataImpl;

  factory _ReplyData.fromJson(Map<String, dynamic> json) =
      _$ReplyDataImpl.fromJson;

  @override
  @JsonKey(name: 'reply_id')
  int get replyId;
  @override
  @JsonKey(name: 'content')
  String get content;
  @override
  @JsonKey(name: 'status')
  int get authorStatus;
  @override
  @JsonKey(name: 'post_status')
  int? get postStatus;
  @override
  @JsonKey(name: 'author_picture')
  @PicListConverter()
  List<String> get authorPicture;
  @override
  @JsonKey(name: 'author_nickname')
  String get authorNickname;
  @override
  @JsonKey(name: 'author_nation')
  int? get authorNation;
  @override
  @JsonKey(name: 'user_type')
  int? get userType;
  @override
  @JsonKey(name: 'user_uniq_id')
  String get userUniqId;
  @override
  @JsonKey(name: 'create_at')
  @DateTimeConverter()
  DateTime get createAt;
  @override
  @JsonKey(name: 'update_at')
  @DateTimeConverter()
  DateTime? get updateAt;
  @override
  @JsonKey(ignore: true)
  _$$ReplyDataImplCopyWith<_$ReplyDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
