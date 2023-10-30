// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ListItemData _$ListItemDataFromJson(Map<String, dynamic> json) {
  return _ListItemData.fromJson(json);
}

/// @nodoc
mixin _$ListItemData {
  @JsonKey(name: 'post_id')
  int get postId => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_nickname')
  String get authorNickname => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_nation')
  int get authorNation => throw _privateConstructorUsedError;
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
  List<String> get meetingPic =>
      throw _privateConstructorUsedError; //@TODO : meetingPic과 meetingStartTime은 String으로 받아서 앞쪽에서 한번 더 파싱 해야함
  @JsonKey(name: 'meeting_location')
  String get meetingLocation =>
      throw _privateConstructorUsedError; //@TODO : meetingPic과 meetingStartTime은 String으로 받아서 앞에서 한번 더 파싱 해야함
  @JsonKey(name: 'meeting_start_time')
  @DateTimeConverter()
  DateTime get meetingStartTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ListItemDataCopyWith<ListItemData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListItemDataCopyWith<$Res> {
  factory $ListItemDataCopyWith(
          ListItemData value, $Res Function(ListItemData) then) =
      _$ListItemDataCopyWithImpl<$Res, ListItemData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'post_id') int postId,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'author_nickname') String authorNickname,
      @JsonKey(name: 'author_nation') int authorNation,
      @JsonKey(name: 'user_type') int userType,
      @JsonKey(name: 'capacity_local') int capacityLocal,
      @JsonKey(name: 'capacity_travel') int capacityTravel,
      @JsonKey(name: 'meeting_pic') @PicListConverter() List<String> meetingPic,
      @JsonKey(name: 'meeting_location') String meetingLocation,
      @JsonKey(name: 'meeting_start_time')
      @DateTimeConverter()
      DateTime meetingStartTime});
}

/// @nodoc
class _$ListItemDataCopyWithImpl<$Res, $Val extends ListItemData>
    implements $ListItemDataCopyWith<$Res> {
  _$ListItemDataCopyWithImpl(this._value, this._then);

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
    Object? authorNation = null,
    Object? userType = null,
    Object? capacityLocal = null,
    Object? capacityTravel = null,
    Object? meetingPic = null,
    Object? meetingLocation = null,
    Object? meetingStartTime = null,
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
      authorNickname: null == authorNickname
          ? _value.authorNickname
          : authorNickname // ignore: cast_nullable_to_non_nullable
              as String,
      authorNation: null == authorNation
          ? _value.authorNation
          : authorNation // ignore: cast_nullable_to_non_nullable
              as int,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListItemDataImplCopyWith<$Res>
    implements $ListItemDataCopyWith<$Res> {
  factory _$$ListItemDataImplCopyWith(
          _$ListItemDataImpl value, $Res Function(_$ListItemDataImpl) then) =
      __$$ListItemDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'post_id') int postId,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'author_nickname') String authorNickname,
      @JsonKey(name: 'author_nation') int authorNation,
      @JsonKey(name: 'user_type') int userType,
      @JsonKey(name: 'capacity_local') int capacityLocal,
      @JsonKey(name: 'capacity_travel') int capacityTravel,
      @JsonKey(name: 'meeting_pic') @PicListConverter() List<String> meetingPic,
      @JsonKey(name: 'meeting_location') String meetingLocation,
      @JsonKey(name: 'meeting_start_time')
      @DateTimeConverter()
      DateTime meetingStartTime});
}

/// @nodoc
class __$$ListItemDataImplCopyWithImpl<$Res>
    extends _$ListItemDataCopyWithImpl<$Res, _$ListItemDataImpl>
    implements _$$ListItemDataImplCopyWith<$Res> {
  __$$ListItemDataImplCopyWithImpl(
      _$ListItemDataImpl _value, $Res Function(_$ListItemDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? title = null,
    Object? authorNickname = null,
    Object? authorNation = null,
    Object? userType = null,
    Object? capacityLocal = null,
    Object? capacityTravel = null,
    Object? meetingPic = null,
    Object? meetingLocation = null,
    Object? meetingStartTime = null,
  }) {
    return _then(_$ListItemDataImpl(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authorNickname: null == authorNickname
          ? _value.authorNickname
          : authorNickname // ignore: cast_nullable_to_non_nullable
              as String,
      authorNation: null == authorNation
          ? _value.authorNation
          : authorNation // ignore: cast_nullable_to_non_nullable
              as int,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListItemDataImpl implements _ListItemData {
  const _$ListItemDataImpl(
      {@JsonKey(name: 'post_id') required this.postId,
      @JsonKey(name: 'title') required this.title,
      @JsonKey(name: 'author_nickname') required this.authorNickname,
      @JsonKey(name: 'author_nation') required this.authorNation,
      @JsonKey(name: 'user_type') required this.userType,
      @JsonKey(name: 'capacity_local') required this.capacityLocal,
      @JsonKey(name: 'capacity_travel') required this.capacityTravel,
      @JsonKey(name: 'meeting_pic')
      @PicListConverter()
      required final List<String> meetingPic,
      @JsonKey(name: 'meeting_location') required this.meetingLocation,
      @JsonKey(name: 'meeting_start_time')
      @DateTimeConverter()
      required this.meetingStartTime})
      : _meetingPic = meetingPic;

  factory _$ListItemDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListItemDataImplFromJson(json);

  @override
  @JsonKey(name: 'post_id')
  final int postId;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'author_nickname')
  final String authorNickname;
  @override
  @JsonKey(name: 'author_nation')
  final int authorNation;
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

//@TODO : meetingPic과 meetingStartTime은 String으로 받아서 앞쪽에서 한번 더 파싱 해야함
  @override
  @JsonKey(name: 'meeting_location')
  final String meetingLocation;
//@TODO : meetingPic과 meetingStartTime은 String으로 받아서 앞에서 한번 더 파싱 해야함
  @override
  @JsonKey(name: 'meeting_start_time')
  @DateTimeConverter()
  final DateTime meetingStartTime;

  @override
  String toString() {
    return 'ListItemData(postId: $postId, title: $title, authorNickname: $authorNickname, authorNation: $authorNation, userType: $userType, capacityLocal: $capacityLocal, capacityTravel: $capacityTravel, meetingPic: $meetingPic, meetingLocation: $meetingLocation, meetingStartTime: $meetingStartTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListItemDataImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.authorNickname, authorNickname) ||
                other.authorNickname == authorNickname) &&
            (identical(other.authorNation, authorNation) ||
                other.authorNation == authorNation) &&
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
                other.meetingStartTime == meetingStartTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      postId,
      title,
      authorNickname,
      authorNation,
      userType,
      capacityLocal,
      capacityTravel,
      const DeepCollectionEquality().hash(_meetingPic),
      meetingLocation,
      meetingStartTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListItemDataImplCopyWith<_$ListItemDataImpl> get copyWith =>
      __$$ListItemDataImplCopyWithImpl<_$ListItemDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListItemDataImplToJson(
      this,
    );
  }
}

abstract class _ListItemData implements ListItemData {
  const factory _ListItemData(
      {@JsonKey(name: 'post_id') required final int postId,
      @JsonKey(name: 'title') required final String title,
      @JsonKey(name: 'author_nickname') required final String authorNickname,
      @JsonKey(name: 'author_nation') required final int authorNation,
      @JsonKey(name: 'user_type') required final int userType,
      @JsonKey(name: 'capacity_local') required final int capacityLocal,
      @JsonKey(name: 'capacity_travel') required final int capacityTravel,
      @JsonKey(name: 'meeting_pic')
      @PicListConverter()
      required final List<String> meetingPic,
      @JsonKey(name: 'meeting_location') required final String meetingLocation,
      @JsonKey(name: 'meeting_start_time')
      @DateTimeConverter()
      required final DateTime meetingStartTime}) = _$ListItemDataImpl;

  factory _ListItemData.fromJson(Map<String, dynamic> json) =
      _$ListItemDataImpl.fromJson;

  @override
  @JsonKey(name: 'post_id')
  int get postId;
  @override
  @JsonKey(name: 'title')
  String get title;
  @override
  @JsonKey(name: 'author_nickname')
  String get authorNickname;
  @override
  @JsonKey(name: 'author_nation')
  int get authorNation;
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
  @override //@TODO : meetingPic과 meetingStartTime은 String으로 받아서 앞쪽에서 한번 더 파싱 해야함
  @JsonKey(name: 'meeting_location')
  String get meetingLocation;
  @override //@TODO : meetingPic과 meetingStartTime은 String으로 받아서 앞에서 한번 더 파싱 해야함
  @JsonKey(name: 'meeting_start_time')
  @DateTimeConverter()
  DateTime get meetingStartTime;
  @override
  @JsonKey(ignore: true)
  _$$ListItemDataImplCopyWith<_$ListItemDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
