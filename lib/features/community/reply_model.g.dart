// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReplyDataImpl _$$ReplyDataImplFromJson(Map<String, dynamic> json) =>
    _$ReplyDataImpl(
      replyId: json['reply_id'] as int,
      content: json['content'] as String,
      authorStatus: json['status'] as int,
      postStatus: json['post_status'] as int?,
      authorPicture:
          const PicListConverter().fromJson(json['author_picture'] as String),
      authorNickname: json['author_nickname'] as String,
      authorNation: json['author_nation'] as int?,
      userType: json['user_type'] as int?,
      userUniqId: json['user_uniq_id'] as String,
      createAt: const DateTimeConverter().fromJson(json['create_at'] as String),
      updateAt: _$JsonConverterFromJson<String, DateTime>(
          json['update_at'], const DateTimeConverter().fromJson),
    );

Map<String, dynamic> _$$ReplyDataImplToJson(_$ReplyDataImpl instance) =>
    <String, dynamic>{
      'reply_id': instance.replyId,
      'content': instance.content,
      'status': instance.authorStatus,
      'post_status': instance.postStatus,
      'author_picture': const PicListConverter().toJson(instance.authorPicture),
      'author_nickname': instance.authorNickname,
      'author_nation': instance.authorNation,
      'user_type': instance.userType,
      'user_uniq_id': instance.userUniqId,
      'create_at': const DateTimeConverter().toJson(instance.createAt),
      'update_at': _$JsonConverterToJson<String, DateTime>(
          instance.updateAt, const DateTimeConverter().toJson),
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
