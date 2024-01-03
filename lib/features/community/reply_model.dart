import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'reply_model.freezed.dart';
part 'reply_model.g.dart';

@freezed
class ReplyData with _$ReplyData {
  const factory ReplyData({
    @JsonKey(name: 'reply_id') required int replyId,
    @JsonKey(name: 'content') required String content,
    @JsonKey(name: 'status') required int authorStatus,
    @JsonKey(name: 'post_status') int? postStatus,
    @JsonKey(name: 'author_picture')
    @PicListConverter()
    required List<String> authorPicture,
    @JsonKey(name: 'author_nickname') required String authorNickname,
    @JsonKey(name: 'author_nation') int? authorNation,
    @JsonKey(name: 'user_type') int? userType,
    @JsonKey(name: 'user_uniq_id') required String userUniqId,
    @JsonKey(name: 'create_at') @DateTimeConverter() required DateTime createAt,
    @JsonKey(name: 'update_at') @DateTimeConverter() DateTime? updateAt,
  }) = _ReplyData;

  factory ReplyData.fromJson(Map<String, dynamic> json) =>
      _$ReplyDataFromJson(json);
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
