import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'block_user_model.freezed.dart';
part 'block_user_model.g.dart';


@freezed
class BlockUserData with _$BlockUserData {
  const factory BlockUserData({
    @JsonKey(name: 'user_uniq_id') required String userUniqId,
    @JsonKey(name: 'nickname') required String nickname,
  }) = _BlockUserData;

  factory BlockUserData.fromJson(Map<String, dynamic> json) =>
      _$BlockUserDataFromJson(json);
}