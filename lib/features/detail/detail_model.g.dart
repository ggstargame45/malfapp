// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DetailDataImpl _$$DetailDataImplFromJson(Map<String, dynamic> json) =>
    _$DetailDataImpl(
      postId: json['post_id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      authorNickname: json['author_nickname'] as String,
      authorNation: json['author_nation'] as int,
      authorPic:
          const PicListConverter().fromJson(json['author_picture'] as String),
      userType: json['user_type'] as int,
      capacityLocal: json['capacity_local'] as int,
      capacityTravel: json['capacity_travel'] as int,
      meetingPic:
          const PicListConverter().fromJson(json['meeting_pic'] as String),
      meetingLocation: json['meeting_location'] as String,
      meetingStartTime: const DateTimeConverter()
          .fromJson(json['meeting_start_time'] as String),
      category: json['category'] as int,
      userUniqId: json['user_uniq_id'] as String,
      likeCount: json['like_count'] as int,
      likeCheck: json['like_check'] as int,
      participationStatus: json['participation_status'] as int,
    );

Map<String, dynamic> _$$DetailDataImplToJson(_$DetailDataImpl instance) =>
    <String, dynamic>{
      'post_id': instance.postId,
      'title': instance.title,
      'content': instance.content,
      'author_nickname': instance.authorNickname,
      'author_nation': instance.authorNation,
      'author_picture': const PicListConverter().toJson(instance.authorPic),
      'user_type': instance.userType,
      'capacity_local': instance.capacityLocal,
      'capacity_travel': instance.capacityTravel,
      'meeting_pic': const PicListConverter().toJson(instance.meetingPic),
      'meeting_location': instance.meetingLocation,
      'meeting_start_time':
          const DateTimeConverter().toJson(instance.meetingStartTime),
      'category': instance.category,
      'user_uniq_id': instance.userUniqId,
      'like_count': instance.likeCount,
      'like_check': instance.likeCheck,
      'participation_status': instance.participationStatus,
    };
