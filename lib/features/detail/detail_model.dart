import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_model.freezed.dart';
part 'detail_model.g.dart';



@freezed
class DetailData with _$DetailData {
  const factory DetailData({
    @JsonKey(name: 'post_id') required int postId,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'content') required String content,
    @JsonKey(name: 'author_nickname') required String authorNickname,
    @JsonKey(name: 'author_nation') required int authorNation,
    @JsonKey(name: 'author_picture') 
    @PicListConverter()
    required List<String> authorPic,
    @JsonKey(name: 'user_type') required int userType,
    @JsonKey(name: 'capacity_local') required int capacityLocal,
    @JsonKey(name: 'capacity_travel') required int capacityTravel,
    //@JsonKey(name: 'amount_local') required int amountLocal,
    //@JsonKey(name: 'amount_travel') required int amountTravel,
    @JsonKey(name: 'meeting_pic')
    @PicListConverter()
    required List<String> meetingPic,
    @JsonKey(name: 'meeting_location') required String meetingLocation,
    @JsonKey(name: 'meeting_start_time')
    @DateTimeConverter()
    required DateTime meetingStartTime,
    @JsonKey(name: 'category') required int category,
    @JsonKey(name: 'user_uniq_id') required String userUniqId,
    @JsonKey(name: "like_count") required int likeCount,
    @JsonKey(name: "like_check") required int likeCheck,
    @JsonKey(name: "participation_status") required int participationStatus,
  }) = _DetailData;

  factory DetailData.fromJson(Map<String, dynamic> json) =>
      _$DetailDataFromJson(json);
}

class PicListConverter implements JsonConverter<List<String>, String> {
  const PicListConverter();

  @override
  List<String> fromJson(String jsonData) {
    return List<String>.from(jsonDecode(jsonData));
  }

  @override
  String toJson(List<String> object) {
    return jsonEncode(object);
  }
}

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime object) {
    return object.toIso8601String();
  }
}