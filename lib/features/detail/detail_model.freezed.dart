// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DetailData _$DetailDataFromJson(Map<String, dynamic> json) {
  return _DetailData.fromJson(json);
}

/// @nodoc
mixin _$DetailData {
  @JsonKey(name: 'post_id')
  int get postId => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'content')
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_nickname')
  String get authorNickname => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_nation')
  int get authorNation => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_picture')
  @PicListConverter()
  List<String> get authorPic => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_type')
  int get userType => throw _privateConstructorUsedError;
  @JsonKey(name: 'capacity_local')
  int get capacityLocal => throw _privateConstructorUsedError;
  @JsonKey(name: 'capacity_travel')
  int get capacityTravel =>
      throw _privateConstructorUsedError; //@JsonKey(name: 'amount_local') required int amountLocal,
//@JsonKey(name: 'amount_travel') required int amountTravel,
  @JsonKey(name: 'meeting_pic')
  @PicListConverter()
  List<String> get meetingPic => throw _privateConstructorUsedError;
  @JsonKey(name: 'meeting_location')
  String get meetingLocation => throw _privateConstructorUsedError;
  @JsonKey(name: 'meeting_start_time')
  @DateTimeConverter()
  DateTime get meetingStartTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'category')
  int get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_uniq_id')
  String get userUniqId => throw _privateConstructorUsedError;
  @JsonKey(name: "like_count")
  int get likeCount => throw _privateConstructorUsedError;
  @JsonKey(name: "like_check")
  int get likeCheck => throw _privateConstructorUsedError;
  @JsonKey(name: "participation_status")
  int get participationStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DetailDataCopyWith<DetailData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailDataCopyWith<$Res> {
  factory $DetailDataCopyWith(
          DetailData value, $Res Function(DetailData) then) =
      _$DetailDataCopyWithImpl<$Res, DetailData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'post_id') int postId,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'content') String content,
      @JsonKey(name: 'author_nickname') String authorNickname,
      @JsonKey(name: 'author_nation') int authorNation,
      @JsonKey(name: 'author_picture')
      @PicListConverter()
      List<String> authorPic,
      @JsonKey(name: 'user_type') int userType,
      @JsonKey(name: 'capacity_local') int capacityLocal,
      @JsonKey(name: 'capacity_travel') int capacityTravel,
      @JsonKey(name: 'meeting_pic') @PicListConverter() List<String> meetingPic,
      @JsonKey(name: 'meeting_location') String meetingLocation,
      @JsonKey(name: 'meeting_start_time')
      @DateTimeConverter()
      DateTime meetingStartTime,
      @JsonKey(name: 'category') int category,
      @JsonKey(name: 'user_uniq_id') String userUniqId,
      @JsonKey(name: "like_count") int likeCount,
      @JsonKey(name: "like_check") int likeCheck,
      @JsonKey(name: "participation_status") int participationStatus});
}

/// @nodoc
class _$DetailDataCopyWithImpl<$Res, $Val extends DetailData>
    implements $DetailDataCopyWith<$Res> {
  _$DetailDataCopyWithImpl(this._value, this._then);

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
    Object? authorNickname = null,
    Object? authorNation = null,
    Object? authorPic = null,
    Object? userType = null,
    Object? capacityLocal = null,
    Object? capacityTravel = null,
    Object? meetingPic = null,
    Object? meetingLocation = null,
    Object? meetingStartTime = null,
    Object? category = null,
    Object? userUniqId = null,
    Object? likeCount = null,
    Object? likeCheck = null,
    Object? participationStatus = null,
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
      authorNickname: null == authorNickname
          ? _value.authorNickname
          : authorNickname // ignore: cast_nullable_to_non_nullable
              as String,
      authorNation: null == authorNation
          ? _value.authorNation
          : authorNation // ignore: cast_nullable_to_non_nullable
              as int,
      authorPic: null == authorPic
          ? _value.authorPic
          : authorPic // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as int,
      capacityLocal: null == capacityLocal
          ? _value.capacityLocal
          : capacityLocal // ignore: cast_nullable_to_non_nullable
              as int,
      capacityTravel: null == capacityTravel
          ? _value.capacityTravel
          : capacityTravel // ignore: cast_nullable_to_non_nullable
              as int,
      meetingPic: null == meetingPic
          ? _value.meetingPic
          : meetingPic // ignore: cast_nullable_to_non_nullable
              as List<String>,
      meetingLocation: null == meetingLocation
          ? _value.meetingLocation
          : meetingLocation // ignore: cast_nullable_to_non_nullable
              as String,
      meetingStartTime: null == meetingStartTime
          ? _value.meetingStartTime
          : meetingStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as int,
      userUniqId: null == userUniqId
          ? _value.userUniqId
          : userUniqId // ignore: cast_nullable_to_non_nullable
              as String,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      likeCheck: null == likeCheck
          ? _value.likeCheck
          : likeCheck // ignore: cast_nullable_to_non_nullable
              as int,
      participationStatus: null == participationStatus
          ? _value.participationStatus
          : participationStatus // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DetailDataImplCopyWith<$Res>
    implements $DetailDataCopyWith<$Res> {
  factory _$$DetailDataImplCopyWith(
          _$DetailDataImpl value, $Res Function(_$DetailDataImpl) then) =
      __$$DetailDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'post_id') int postId,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'content') String content,
      @JsonKey(name: 'author_nickname') String authorNickname,
      @JsonKey(name: 'author_nation') int authorNation,
      @JsonKey(name: 'author_picture')
      @PicListConverter()
      List<String> authorPic,
      @JsonKey(name: 'user_type') int userType,
      @JsonKey(name: 'capacity_local') int capacityLocal,
      @JsonKey(name: 'capacity_travel') int capacityTravel,
      @JsonKey(name: 'meeting_pic') @PicListConverter() List<String> meetingPic,
      @JsonKey(name: 'meeting_location') String meetingLocation,
      @JsonKey(name: 'meeting_start_time')
      @DateTimeConverter()
      DateTime meetingStartTime,
      @JsonKey(name: 'category') int category,
      @JsonKey(name: 'user_uniq_id') String userUniqId,
      @JsonKey(name: "like_count") int likeCount,
      @JsonKey(name: "like_check") int likeCheck,
      @JsonKey(name: "participation_status") int participationStatus});
}

/// @nodoc
class __$$DetailDataImplCopyWithImpl<$Res>
    extends _$DetailDataCopyWithImpl<$Res, _$DetailDataImpl>
    implements _$$DetailDataImplCopyWith<$Res> {
  __$$DetailDataImplCopyWithImpl(
      _$DetailDataImpl _value, $Res Function(_$DetailDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? title = null,
    Object? content = null,
    Object? authorNickname = null,
    Object? authorNation = null,
    Object? authorPic = null,
    Object? userType = null,
    Object? capacityLocal = null,
    Object? capacityTravel = null,
    Object? meetingPic = null,
    Object? meetingLocation = null,
    Object? meetingStartTime = null,
    Object? category = null,
    Object? userUniqId = null,
    Object? likeCount = null,
    Object? likeCheck = null,
    Object? participationStatus = null,
  }) {
    return _then(_$DetailDataImpl(
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
      authorNickname: null == authorNickname
          ? _value.authorNickname
          : authorNickname // ignore: cast_nullable_to_non_nullable
              as String,
      authorNation: null == authorNation
          ? _value.authorNation
          : authorNation // ignore: cast_nullable_to_non_nullable
              as int,
      authorPic: null == authorPic
          ? _value._authorPic
          : authorPic // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as int,
      capacityLocal: null == capacityLocal
          ? _value.capacityLocal
          : capacityLocal // ignore: cast_nullable_to_non_nullable
              as int,
      capacityTravel: null == capacityTravel
          ? _value.capacityTravel
          : capacityTravel // ignore: cast_nullable_to_non_nullable
              as int,
      meetingPic: null == meetingPic
          ? _value._meetingPic
          : meetingPic // ignore: cast_nullable_to_non_nullable
              as List<String>,
      meetingLocation: null == meetingLocation
          ? _value.meetingLocation
          : meetingLocation // ignore: cast_nullable_to_non_nullable
              as String,
      meetingStartTime: null == meetingStartTime
          ? _value.meetingStartTime
          : meetingStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as int,
      userUniqId: null == userUniqId
          ? _value.userUniqId
          : userUniqId // ignore: cast_nullable_to_non_nullable
              as String,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      likeCheck: null == likeCheck
          ? _value.likeCheck
          : likeCheck // ignore: cast_nullable_to_non_nullable
              as int,
      participationStatus: null == participationStatus
          ? _value.participationStatus
          : participationStatus // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DetailDataImpl implements _DetailData {
  const _$DetailDataImpl(
      {@JsonKey(name: 'post_id') required this.postId,
      @JsonKey(name: 'title') required this.title,
      @JsonKey(name: 'content') required this.content,
      @JsonKey(name: 'author_nickname') required this.authorNickname,
      @JsonKey(name: 'author_nation') required this.authorNation,
      @JsonKey(name: 'author_picture')
      @PicListConverter()
      required final List<String> authorPic,
      @JsonKey(name: 'user_type') required this.userType,
      @JsonKey(name: 'capacity_local') required this.capacityLocal,
      @JsonKey(name: 'capacity_travel') required this.capacityTravel,
      @JsonKey(name: 'meeting_pic')
      @PicListConverter()
      required final List<String> meetingPic,
      @JsonKey(name: 'meeting_location') required this.meetingLocation,
      @JsonKey(name: 'meeting_start_time')
      @DateTimeConverter()
      required this.meetingStartTime,
      @JsonKey(name: 'category') required this.category,
      @JsonKey(name: 'user_uniq_id') required this.userUniqId,
      @JsonKey(name: "like_count") required this.likeCount,
      @JsonKey(name: "like_check") required this.likeCheck,
      @JsonKey(name: "participation_status") required this.participationStatus})
      : _authorPic = authorPic,
        _meetingPic = meetingPic;

  factory _$DetailDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DetailDataImplFromJson(json);

  @override
  @JsonKey(name: 'post_id')
  final int postId;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'content')
  final String content;
  @override
  @JsonKey(name: 'author_nickname')
  final String authorNickname;
  @override
  @JsonKey(name: 'author_nation')
  final int authorNation;
  final List<String> _authorPic;
  @override
  @JsonKey(name: 'author_picture')
  @PicListConverter()
  List<String> get authorPic {
    if (_authorPic is EqualUnmodifiableListView) return _authorPic;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_authorPic);
  }

  @override
  @JsonKey(name: 'user_type')
  final int userType;
  @override
  @JsonKey(name: 'capacity_local')
  final int capacityLocal;
  @override
  @JsonKey(name: 'capacity_travel')
  final int capacityTravel;
//@JsonKey(name: 'amount_local') required int amountLocal,
//@JsonKey(name: 'amount_travel') required int amountTravel,
  final List<String> _meetingPic;
//@JsonKey(name: 'amount_local') required int amountLocal,
//@JsonKey(name: 'amount_travel') required int amountTravel,
  @override
  @JsonKey(name: 'meeting_pic')
  @PicListConverter()
  List<String> get meetingPic {
    if (_meetingPic is EqualUnmodifiableListView) return _meetingPic;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_meetingPic);
  }

  @override
  @JsonKey(name: 'meeting_location')
  final String meetingLocation;
  @override
  @JsonKey(name: 'meeting_start_time')
  @DateTimeConverter()
  final DateTime meetingStartTime;
  @override
  @JsonKey(name: 'category')
  final int category;
  @override
  @JsonKey(name: 'user_uniq_id')
  final String userUniqId;
  @override
  @JsonKey(name: "like_count")
  final int likeCount;
  @override
  @JsonKey(name: "like_check")
  final int likeCheck;
  @override
  @JsonKey(name: "participation_status")
  final int participationStatus;

  @override
  String toString() {
    return 'DetailData(postId: $postId, title: $title, content: $content, authorNickname: $authorNickname, authorNation: $authorNation, authorPic: $authorPic, userType: $userType, capacityLocal: $capacityLocal, capacityTravel: $capacityTravel, meetingPic: $meetingPic, meetingLocation: $meetingLocation, meetingStartTime: $meetingStartTime, category: $category, userUniqId: $userUniqId, likeCount: $likeCount, likeCheck: $likeCheck, participationStatus: $participationStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetailDataImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.authorNickname, authorNickname) ||
                other.authorNickname == authorNickname) &&
            (identical(other.authorNation, authorNation) ||
                other.authorNation == authorNation) &&
            const DeepCollectionEquality()
                .equals(other._authorPic, _authorPic) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.capacityLocal, capacityLocal) ||
                other.capacityLocal == capacityLocal) &&
            (identical(other.capacityTravel, capacityTravel) ||
                other.capacityTravel == capacityTravel) &&
            const DeepCollectionEquality()
                .equals(other._meetingPic, _meetingPic) &&
            (identical(other.meetingLocation, meetingLocation) ||
                other.meetingLocation == meetingLocation) &&
            (identical(other.meetingStartTime, meetingStartTime) ||
                other.meetingStartTime == meetingStartTime) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.userUniqId, userUniqId) ||
                other.userUniqId == userUniqId) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.likeCheck, likeCheck) ||
                other.likeCheck == likeCheck) &&
            (identical(other.participationStatus, participationStatus) ||
                other.participationStatus == participationStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      postId,
      title,
      content,
      authorNickname,
      authorNation,
      const DeepCollectionEquality().hash(_authorPic),
      userType,
      capacityLocal,
      capacityTravel,
      const DeepCollectionEquality().hash(_meetingPic),
      meetingLocation,
      meetingStartTime,
      category,
      userUniqId,
      likeCount,
      likeCheck,
      participationStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DetailDataImplCopyWith<_$DetailDataImpl> get copyWith =>
      __$$DetailDataImplCopyWithImpl<_$DetailDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DetailDataImplToJson(
      this,
    );
  }
}

abstract class _DetailData implements DetailData {
  const factory _DetailData(
      {@JsonKey(name: 'post_id') required final int postId,
      @JsonKey(name: 'title') required final String title,
      @JsonKey(name: 'content') required final String content,
      @JsonKey(name: 'author_nickname') required final String authorNickname,
      @JsonKey(name: 'author_nation') required final int authorNation,
      @JsonKey(name: 'author_picture')
      @PicListConverter()
      required final List<String> authorPic,
      @JsonKey(name: 'user_type') required final int userType,
      @JsonKey(name: 'capacity_local') required final int capacityLocal,
      @JsonKey(name: 'capacity_travel') required final int capacityTravel,
      @JsonKey(name: 'meeting_pic')
      @PicListConverter()
      required final List<String> meetingPic,
      @JsonKey(name: 'meeting_location') required final String meetingLocation,
      @JsonKey(name: 'meeting_start_time')
      @DateTimeConverter()
      required final DateTime meetingStartTime,
      @JsonKey(name: 'category') required final int category,
      @JsonKey(name: 'user_uniq_id') required final String userUniqId,
      @JsonKey(name: "like_count") required final int likeCount,
      @JsonKey(name: "like_check") required final int likeCheck,
      @JsonKey(name: "participation_status")
      required final int participationStatus}) = _$DetailDataImpl;

  factory _DetailData.fromJson(Map<String, dynamic> json) =
      _$DetailDataImpl.fromJson;

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
  @JsonKey(name: 'author_nickname')
  String get authorNickname;
  @override
  @JsonKey(name: 'author_nation')
  int get authorNation;
  @override
  @JsonKey(name: 'author_picture')
  @PicListConverter()
  List<String> get authorPic;
  @override
  @JsonKey(name: 'user_type')
  int get userType;
  @override
  @JsonKey(name: 'capacity_local')
  int get capacityLocal;
  @override
  @JsonKey(name: 'capacity_travel')
  int get capacityTravel;
  @override //@JsonKey(name: 'amount_local') required int amountLocal,
//@JsonKey(name: 'amount_travel') required int amountTravel,
  @JsonKey(name: 'meeting_pic')
  @PicListConverter()
  List<String> get meetingPic;
  @override
  @JsonKey(name: 'meeting_location')
  String get meetingLocation;
  @override
  @JsonKey(name: 'meeting_start_time')
  @DateTimeConverter()
  DateTime get meetingStartTime;
  @override
  @JsonKey(name: 'category')
  int get category;
  @override
  @JsonKey(name: 'user_uniq_id')
  String get userUniqId;
  @override
  @JsonKey(name: "like_count")
  int get likeCount;
  @override
  @JsonKey(name: "like_check")
  int get likeCheck;
  @override
  @JsonKey(name: "participation_status")
  int get participationStatus;
  @override
  @JsonKey(ignore: true)
  _$$DetailDataImplCopyWith<_$DetailDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
