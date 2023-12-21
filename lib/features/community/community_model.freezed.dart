// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CommunityData _$CommunityDataFromJson(Map<String, dynamic> json) {
  return _CommunityData.fromJson(json);
}

/// @nodoc
mixin _$CommunityData {
  @JsonKey(name: 'post_id')
  int get postId => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'content')
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'picture')
  @PicListConverter()
  List<String> get picture => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  int get authorStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'post_status')
  int get postStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_nickname')
  String get authorNickname => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_nation')
  int? get authorNation => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_picture')
  @PicListConverter()
  List<String>? get authorPic => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_type')
  int? get userType => throw _privateConstructorUsedError;
  @JsonKey(name: 'create_at')
  @DateTimeConverter()
  DateTime get createAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'update_at')
  @DateTimeConverter()
  DateTime? get updateAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_uniq_id')
  String get userUniqId => throw _privateConstructorUsedError;
  @JsonKey(name: "scrap_check")
  int? get scrapCheck => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommunityDataCopyWith<CommunityData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityDataCopyWith<$Res> {
  factory $CommunityDataCopyWith(
          CommunityData value, $Res Function(CommunityData) then) =
      _$CommunityDataCopyWithImpl<$Res, CommunityData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'post_id') int postId,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'content') String content,
      @JsonKey(name: 'picture') @PicListConverter() List<String> picture,
      @JsonKey(name: 'status') int authorStatus,
      @JsonKey(name: 'post_status') int postStatus,
      @JsonKey(name: 'author_nickname') String authorNickname,
      @JsonKey(name: 'author_nation') int? authorNation,
      @JsonKey(name: 'author_picture')
      @PicListConverter()
      List<String>? authorPic,
      @JsonKey(name: 'user_type') int? userType,
      @JsonKey(name: 'create_at') @DateTimeConverter() DateTime createAt,
      @JsonKey(name: 'update_at') @DateTimeConverter() DateTime? updateAt,
      @JsonKey(name: 'user_uniq_id') String userUniqId,
      @JsonKey(name: "scrap_check") int? scrapCheck});
}

/// @nodoc
class _$CommunityDataCopyWithImpl<$Res, $Val extends CommunityData>
    implements $CommunityDataCopyWith<$Res> {
  _$CommunityDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? title = null,
    Object? content = null,
    Object? picture = null,
    Object? authorStatus = null,
    Object? postStatus = null,
    Object? authorNickname = null,
    Object? authorNation = freezed,
    Object? authorPic = freezed,
    Object? userType = freezed,
    Object? createAt = null,
    Object? updateAt = freezed,
    Object? userUniqId = null,
    Object? scrapCheck = freezed,
  }) {
    return _then(_value.copyWith(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      picture: null == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as List<String>,
      authorStatus: null == authorStatus
          ? _value.authorStatus
          : authorStatus // ignore: cast_nullable_to_non_nullable
              as int,
      postStatus: null == postStatus
          ? _value.postStatus
          : postStatus // ignore: cast_nullable_to_non_nullable
              as int,
      authorNickname: null == authorNickname
          ? _value.authorNickname
          : authorNickname // ignore: cast_nullable_to_non_nullable
              as String,
      authorNation: freezed == authorNation
          ? _value.authorNation
          : authorNation // ignore: cast_nullable_to_non_nullable
              as int?,
      authorPic: freezed == authorPic
          ? _value.authorPic
          : authorPic // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as int?,
      createAt: null == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updateAt: freezed == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userUniqId: null == userUniqId
          ? _value.userUniqId
          : userUniqId // ignore: cast_nullable_to_non_nullable
              as String,
      scrapCheck: freezed == scrapCheck
          ? _value.scrapCheck
          : scrapCheck // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommunityDataImplCopyWith<$Res>
    implements $CommunityDataCopyWith<$Res> {
  factory _$$CommunityDataImplCopyWith(
          _$CommunityDataImpl value, $Res Function(_$CommunityDataImpl) then) =
      __$$CommunityDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'post_id') int postId,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'content') String content,
      @JsonKey(name: 'picture') @PicListConverter() List<String> picture,
      @JsonKey(name: 'status') int authorStatus,
      @JsonKey(name: 'post_status') int postStatus,
      @JsonKey(name: 'author_nickname') String authorNickname,
      @JsonKey(name: 'author_nation') int? authorNation,
      @JsonKey(name: 'author_picture')
      @PicListConverter()
      List<String>? authorPic,
      @JsonKey(name: 'user_type') int? userType,
      @JsonKey(name: 'create_at') @DateTimeConverter() DateTime createAt,
      @JsonKey(name: 'update_at') @DateTimeConverter() DateTime? updateAt,
      @JsonKey(name: 'user_uniq_id') String userUniqId,
      @JsonKey(name: "scrap_check") int? scrapCheck});
}

/// @nodoc
class __$$CommunityDataImplCopyWithImpl<$Res>
    extends _$CommunityDataCopyWithImpl<$Res, _$CommunityDataImpl>
    implements _$$CommunityDataImplCopyWith<$Res> {
  __$$CommunityDataImplCopyWithImpl(
      _$CommunityDataImpl _value, $Res Function(_$CommunityDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? title = null,
    Object? content = null,
    Object? picture = null,
    Object? authorStatus = null,
    Object? postStatus = null,
    Object? authorNickname = null,
    Object? authorNation = freezed,
    Object? authorPic = freezed,
    Object? userType = freezed,
    Object? createAt = null,
    Object? updateAt = freezed,
    Object? userUniqId = null,
    Object? scrapCheck = freezed,
  }) {
    return _then(_$CommunityDataImpl(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      picture: null == picture
          ? _value._picture
          : picture // ignore: cast_nullable_to_non_nullable
              as List<String>,
      authorStatus: null == authorStatus
          ? _value.authorStatus
          : authorStatus // ignore: cast_nullable_to_non_nullable
              as int,
      postStatus: null == postStatus
          ? _value.postStatus
          : postStatus // ignore: cast_nullable_to_non_nullable
              as int,
      authorNickname: null == authorNickname
          ? _value.authorNickname
          : authorNickname // ignore: cast_nullable_to_non_nullable
              as String,
      authorNation: freezed == authorNation
          ? _value.authorNation
          : authorNation // ignore: cast_nullable_to_non_nullable
              as int?,
      authorPic: freezed == authorPic
          ? _value._authorPic
          : authorPic // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as int?,
      createAt: null == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updateAt: freezed == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userUniqId: null == userUniqId
          ? _value.userUniqId
          : userUniqId // ignore: cast_nullable_to_non_nullable
              as String,
      scrapCheck: freezed == scrapCheck
          ? _value.scrapCheck
          : scrapCheck // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommunityDataImpl implements _CommunityData {
  const _$CommunityDataImpl(
      {@JsonKey(name: 'post_id') required this.postId,
      @JsonKey(name: 'title') required this.title,
      @JsonKey(name: 'content') required this.content,
      @JsonKey(name: 'picture')
      @PicListConverter()
      required final List<String> picture,
      @JsonKey(name: 'status') required this.authorStatus,
      @JsonKey(name: 'post_status') required this.postStatus,
      @JsonKey(name: 'author_nickname') required this.authorNickname,
      @JsonKey(name: 'author_nation') this.authorNation,
      @JsonKey(name: 'author_picture')
      @PicListConverter()
      final List<String>? authorPic,
      @JsonKey(name: 'user_type') this.userType,
      @JsonKey(name: 'create_at') @DateTimeConverter() required this.createAt,
      @JsonKey(name: 'update_at') @DateTimeConverter() this.updateAt,
      @JsonKey(name: 'user_uniq_id') required this.userUniqId,
      @JsonKey(name: "scrap_check") this.scrapCheck})
      : _picture = picture,
        _authorPic = authorPic;

  factory _$CommunityDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommunityDataImplFromJson(json);

  @override
  @JsonKey(name: 'post_id')
  final int postId;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'content')
  final String content;
  final List<String> _picture;
  @override
  @JsonKey(name: 'picture')
  @PicListConverter()
  List<String> get picture {
    if (_picture is EqualUnmodifiableListView) return _picture;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_picture);
  }

  @override
  @JsonKey(name: 'status')
  final int authorStatus;
  @override
  @JsonKey(name: 'post_status')
  final int postStatus;
  @override
  @JsonKey(name: 'author_nickname')
  final String authorNickname;
  @override
  @JsonKey(name: 'author_nation')
  final int? authorNation;
  final List<String>? _authorPic;
  @override
  @JsonKey(name: 'author_picture')
  @PicListConverter()
  List<String>? get authorPic {
    final value = _authorPic;
    if (value == null) return null;
    if (_authorPic is EqualUnmodifiableListView) return _authorPic;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'user_type')
  final int? userType;
  @override
  @JsonKey(name: 'create_at')
  @DateTimeConverter()
  final DateTime createAt;
  @override
  @JsonKey(name: 'update_at')
  @DateTimeConverter()
  final DateTime? updateAt;
  @override
  @JsonKey(name: 'user_uniq_id')
  final String userUniqId;
  @override
  @JsonKey(name: "scrap_check")
  final int? scrapCheck;

  @override
  String toString() {
    return 'CommunityData(postId: $postId, title: $title, content: $content, picture: $picture, authorStatus: $authorStatus, postStatus: $postStatus, authorNickname: $authorNickname, authorNation: $authorNation, authorPic: $authorPic, userType: $userType, createAt: $createAt, updateAt: $updateAt, userUniqId: $userUniqId, scrapCheck: $scrapCheck)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunityDataImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._picture, _picture) &&
            (identical(other.authorStatus, authorStatus) ||
                other.authorStatus == authorStatus) &&
            (identical(other.postStatus, postStatus) ||
                other.postStatus == postStatus) &&
            (identical(other.authorNickname, authorNickname) ||
                other.authorNickname == authorNickname) &&
            (identical(other.authorNation, authorNation) ||
                other.authorNation == authorNation) &&
            const DeepCollectionEquality()
                .equals(other._authorPic, _authorPic) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.createAt, createAt) ||
                other.createAt == createAt) &&
            (identical(other.updateAt, updateAt) ||
                other.updateAt == updateAt) &&
            (identical(other.userUniqId, userUniqId) ||
                other.userUniqId == userUniqId) &&
            (identical(other.scrapCheck, scrapCheck) ||
                other.scrapCheck == scrapCheck));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      postId,
      title,
      content,
      const DeepCollectionEquality().hash(_picture),
      authorStatus,
      postStatus,
      authorNickname,
      authorNation,
      const DeepCollectionEquality().hash(_authorPic),
      userType,
      createAt,
      updateAt,
      userUniqId,
      scrapCheck);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunityDataImplCopyWith<_$CommunityDataImpl> get copyWith =>
      __$$CommunityDataImplCopyWithImpl<_$CommunityDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommunityDataImplToJson(
      this,
    );
  }
}

abstract class _CommunityData implements CommunityData {
  const factory _CommunityData(
      {@JsonKey(name: 'post_id') required final int postId,
      @JsonKey(name: 'title') required final String title,
      @JsonKey(name: 'content') required final String content,
      @JsonKey(name: 'picture')
      @PicListConverter()
      required final List<String> picture,
      @JsonKey(name: 'status') required final int authorStatus,
      @JsonKey(name: 'post_status') required final int postStatus,
      @JsonKey(name: 'author_nickname') required final String authorNickname,
      @JsonKey(name: 'author_nation') final int? authorNation,
      @JsonKey(name: 'author_picture')
      @PicListConverter()
      final List<String>? authorPic,
      @JsonKey(name: 'user_type') final int? userType,
      @JsonKey(name: 'create_at')
      @DateTimeConverter()
      required final DateTime createAt,
      @JsonKey(name: 'update_at') @DateTimeConverter() final DateTime? updateAt,
      @JsonKey(name: 'user_uniq_id') required final String userUniqId,
      @JsonKey(name: "scrap_check")
      final int? scrapCheck}) = _$CommunityDataImpl;

  factory _CommunityData.fromJson(Map<String, dynamic> json) =
      _$CommunityDataImpl.fromJson;

  @override
  @JsonKey(name: 'post_id')
  int get postId;
  @override
  @JsonKey(name: 'title')
  String get title;
  @override
  @JsonKey(name: 'content')
  String get content;
  @override
  @JsonKey(name: 'picture')
  @PicListConverter()
  List<String> get picture;
  @override
  @JsonKey(name: 'status')
  int get authorStatus;
  @override
  @JsonKey(name: 'post_status')
  int get postStatus;
  @override
  @JsonKey(name: 'author_nickname')
  String get authorNickname;
  @override
  @JsonKey(name: 'author_nation')
  int? get authorNation;
  @override
  @JsonKey(name: 'author_picture')
  @PicListConverter()
  List<String>? get authorPic;
  @override
  @JsonKey(name: 'user_type')
  int? get userType;
  @override
  @JsonKey(name: 'create_at')
  @DateTimeConverter()
  DateTime get createAt;
  @override
  @JsonKey(name: 'update_at')
  @DateTimeConverter()
  DateTime? get updateAt;
  @override
  @JsonKey(name: 'user_uniq_id')
  String get userUniqId;
  @override
  @JsonKey(name: "scrap_check")
  int? get scrapCheck;
  @override
  @JsonKey(ignore: true)
  _$$CommunityDataImplCopyWith<_$CommunityDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
