// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ListItemDataImpl _$$ListItemDataImplFromJson(Map<String, dynamic> json) =>
    _$ListItemDataImpl(
      postId: json['post_id'] as int,
      title: json['title'] as String,
      authorNickname: json['author_nickname'] as String,
      authorNation: json['author_nation'] as int,
      userType: json['user_type'] as int,
      capacityLocal: json['capacity_local'] as int,
      capacityTravel: json['capacity_travel'] as int,
      userUniqId: json['user_uniq_id'] as String,
      meetingPic:
          const PicListConverter().fromJson(json['meeting_pic'] as String),
      meetingLocation: json['meeting_location'] as String,
      meetingStartTime: const DateTimeConverter()
          .fromJson(json['meeting_start_time'] as String),
      postStatus: json['post_status'] as int,
      likeCount: json['like_count'] as int,
      localParticipation: json['local_participation'] as int,
      travelParticipation: json['travel_participation'] as int,
    );

Map<String, dynamic> _$$ListItemDataImplToJson(_$ListItemDataImpl instance) =>
    <String, dynamic>{
      'post_id': instance.postId,
      'title': instance.title,
      'author_nickname': instance.authorNickname,
      'author_nation': instance.authorNation,
      'user_type': instance.userType,
      'capacity_local': instance.capacityLocal,
      'capacity_travel': instance.capacityTravel,
      'user_uniq_id': instance.userUniqId,
      'meeting_pic': const PicListConverter().toJson(instance.meetingPic),
      'meeting_location': instance.meetingLocation,
      'meeting_start_time':
          const DateTimeConverter().toJson(instance.meetingStartTime),
      'post_status': instance.postStatus,
      'like_count': instance.likeCount,
      'local_participation': instance.localParticipation,
      'travel_participation': instance.travelParticipation,
    };
