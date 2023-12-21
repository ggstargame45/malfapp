// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommunityDataImpl _$$CommunityDataImplFromJson(Map<String, dynamic> json) =>
    _$CommunityDataImpl(
      postId: json['post_id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      picture: const PicListConverter().fromJson(json['picture'] as String),
      authorStatus: json['status'] as int,
      postStatus: json['post_status'] as int,
      authorNickname: json['author_nickname'] as String,
      authorNation: json['author_nation'] as int?,
      authorPic: _$JsonConverterFromJson<String, List<String>>(
          json['author_picture'], const PicListConverter().fromJson),
      userType: json['user_type'] as int?,
      createAt: const DateTimeConverter().fromJson(json['create_at'] as String),
      updateAt: _$JsonConverterFromJson<String, DateTime>(
          json['update_at'], const DateTimeConverter().fromJson),
      userUniqId: json['user_uniq_id'] as String,
      scrapCheck: json['scrap_check'] as int?,
    );

Map<String, dynamic> _$$CommunityDataImplToJson(_$CommunityDataImpl instance) =>
    <String, dynamic>{
      'post_id': instance.postId,
      'title': instance.title,
      'content': instance.content,
      'picture': const PicListConverter().toJson(instance.picture),
      'status': instance.authorStatus,
      'post_status': instance.postStatus,
      'author_nickname': instance.authorNickname,
      'author_nation': instance.authorNation,
      'author_picture': _$JsonConverterToJson<String, List<String>>(
          instance.authorPic, const PicListConverter().toJson),
      'user_type': instance.userType,
      'create_at': const DateTimeConverter().toJson(instance.createAt),
      'update_at': _$JsonConverterToJson<String, DateTime>(
          instance.updateAt, const DateTimeConverter().toJson),
      'user_uniq_id': instance.userUniqId,
      'scrap_check': instance.scrapCheck,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
