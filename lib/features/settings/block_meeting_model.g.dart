// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_meeting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BlockMeetingDataImpl _$$BlockMeetingDataImplFromJson(
        Map<String, dynamic> json) =>
    _$BlockMeetingDataImpl(
      postId: json['post_id'] as String,
      title: json['title'] as String,
      authorNickname: json['author_nickname'] as String,
    );

Map<String, dynamic> _$$BlockMeetingDataImplToJson(
        _$BlockMeetingDataImpl instance) =>
    <String, dynamic>{
      'post_id': instance.postId,
      'title': instance.title,
      'author_nickname': instance.authorNickname,
    };
