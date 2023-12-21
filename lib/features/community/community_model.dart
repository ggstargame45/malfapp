import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_model.freezed.dart';
part 'community_model.g.dart';

@freezed
class CommunityData with _$CommunityData {
  const factory CommunityData({
    @JsonKey(name: 'post_id') required int postId,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'content') required String content,
    @JsonKey(name: 'picture') @PicListConverter() required List<String> picture,
    @JsonKey(name: 'status') required int authorStatus,
    @JsonKey(name: 'post_status') required int postStatus,
    @JsonKey(name: 'author_nickname') required String authorNickname,
    @JsonKey(name: 'author_nation') int? authorNation,
    @JsonKey(name: 'author_picture')
    @PicListConverter()
    List<String>? authorPic,
    @JsonKey(name: 'user_type') int? userType,
    
    @JsonKey(name: 'create_at') @DateTimeConverter() required DateTime createAt,
    @JsonKey(name: 'update_at') @DateTimeConverter() DateTime? updateAt,
    @JsonKey(name: 'user_uniq_id') required String userUniqId,
    @JsonKey(name: "scrap_check") int? scrapCheck,
    
  }) = _CommunityData;

  factory CommunityData.fromJson(Map<String, dynamic> json) =>
      _$CommunityDataFromJson(json);
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
