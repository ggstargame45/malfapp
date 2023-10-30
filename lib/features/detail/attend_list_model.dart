import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attend_list_model.freezed.dart';
part 'attend_list_model.g.dart';

@freezed
class AttendListData with _$AttendListData {
  const factory AttendListData({
    @JsonKey(name: 'user_uniq_id') required String userUniqId,
    // @JsonKey(name: 'user_status') required int userStatus,
    @JsonKey(name: 'user_type') required int userType,
    @JsonKey(name: 'nation') required int nation,
    @JsonKey(name: 'nickname') required String nickname,
    // @JsonKey(name: 'profile_pic')
    // @PicListConverter()
    // required List<String> profilePic,
  }) = _AttendListData;

  factory AttendListData.fromJson(Map<String, dynamic> json) =>
      _$AttendListDataFromJson(json);
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
