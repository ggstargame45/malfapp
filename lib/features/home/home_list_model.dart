import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_list_model.freezed.dart';
part 'home_list_model.g.dart';

@freezed
class ListItemData with _$ListItemData {
  const factory ListItemData({
    @JsonKey(name: 'post_id') required int postId,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'author_nickname') required String authorNickname,
    @JsonKey(name: 'author_nation') required int authorNation,
    @JsonKey(name: 'user_type') required int userType,
    @JsonKey(name: 'capacity_local') required int capacityLocal,
    @JsonKey(name: 'capacity_travel') required int capacityTravel,
    //@JsonKey(name: 'amount_local') required int amountLocal,
    //@JsonKey(name: 'amount_travel') required int amountTravel,
    @JsonKey(name: 'meeting_pic')
    @PicListConverter()
    required List<String> meetingPic,
    //@TODO : meetingPic과 meetingStartTime은 String으로 받아서 앞쪽에서 한번 더 파싱 해야함
    @JsonKey(name: 'meeting_location') required String meetingLocation,
    //@TODO : meetingPic과 meetingStartTime은 String으로 받아서 앞에서 한번 더 파싱 해야함
    @JsonKey(name: 'meeting_start_time')
    @DateTimeConverter()
    required DateTime meetingStartTime,
  }) = _ListItemData;

  factory ListItemData.fromJson(Map<String, dynamic> json) =>
      _$ListItemDataFromJson(json);
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