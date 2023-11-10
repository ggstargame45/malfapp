import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'block_meeting_model.freezed.dart';
part 'block_meeting_model.g.dart';


@freezed
class BlockMeetingData with _$BlockMeetingData {
  const factory BlockMeetingData({
    @JsonKey(name: 'post_id') required String postId,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'author_nickname') required String authorNickname,
    
  }) = _BlockMeetingData;

  factory BlockMeetingData.fromJson(Map<String, dynamic> json) =>
      _$BlockMeetingDataFromJson(json);
}