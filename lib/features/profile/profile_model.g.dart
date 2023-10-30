// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileDataImpl _$$ProfileDataImplFromJson(Map<String, dynamic> json) =>
    _$ProfileDataImpl(
      userUniqId: json['user_uniq_id'] as String,
      userStatus: json['user_status'] as int,
      userType: json['user_type'] as int,
      nation: json['nation'] as int,
      gender: json['gender'] as int,
      nickname: json['nickname'] as String,
      birthday: const DateTimeConverter().fromJson(json['birthday'] as String),
      description: json['description'] as String,
      defaultLanguage: json['default_language'] as String?,
      profilePic:
          const PicListConverter().fromJson(json['profile_pic'] as String),
      interests: json['interests'] as String?,
      createdAt:
          const DateTimeConverter().fromJson(json['created_at'] as String),
      updatedAt:
          const DateTimeConverter().fromJson(json['updated_at'] as String),
      ableLanguage:
          const IntListConverter().fromJson(json['able_language'] as String),
      userTemperature: json['user_temperature'] as int,
    );

Map<String, dynamic> _$$ProfileDataImplToJson(_$ProfileDataImpl instance) =>
    <String, dynamic>{
      'user_uniq_id': instance.userUniqId,
      'user_status': instance.userStatus,
      'user_type': instance.userType,
      'nation': instance.nation,
      'gender': instance.gender,
      'nickname': instance.nickname,
      'birthday': const DateTimeConverter().toJson(instance.birthday),
      'description': instance.description,
      'default_language': instance.defaultLanguage,
      'profile_pic': const PicListConverter().toJson(instance.profilePic),
      'interests': instance.interests,
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
      'updated_at': const DateTimeConverter().toJson(instance.updatedAt),
      'able_language': const IntListConverter().toJson(instance.ableLanguage),
      'user_temperature': instance.userTemperature,
    };
