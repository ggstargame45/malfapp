import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class ProfileData with _$ProfileData {
  const factory ProfileData({
    @JsonKey(name: 'user_uniq_id') required String userUniqId,
    @JsonKey(name: 'user_status') required int userStatus,
    @JsonKey(name: 'user_type') required int userType,
    @JsonKey(name: 'nation') required int nation,
    @JsonKey(name: 'gender') required int gender,
    @JsonKey(name: 'nickname') required String nickname,
    @JsonKey(name: 'birthday')
    @DateTimeConverter()
    required DateTime birthday,
    @JsonKey(name: 'description')
     required String description,
    @JsonKey(name: 'default_language') required String? defaultLanguage,
    @JsonKey(name: 'profile_pic')
    @PicListConverter()
    required List<String> profilePic,
    @JsonKey(name: 'interests')
     required String? interests,
    @JsonKey(name: 'created_at')
    @DateTimeConverter()
    required DateTime createdAt,
    @JsonKey(name: 'updated_at')
    @DateTimeConverter()
    required DateTime updatedAt,
    @JsonKey(name: "able_language")
    @IntListConverter()
    required List<int> ableLanguage,
    @JsonKey(name: "user_temperature")
    required int userTemperature
  }) = _ProfileData;

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);
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

class IntListConverter implements JsonConverter<List<int>, String> {
  const IntListConverter();

  @override
  List<int> fromJson(String jsonData) {
    return List<int>.from(jsonDecode(jsonData));
  }

  @override
  String toJson(List<int> object) {
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
