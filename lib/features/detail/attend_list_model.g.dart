// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attend_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendListDataImpl _$$AttendListDataImplFromJson(Map<String, dynamic> json) =>
    _$AttendListDataImpl(
      userUniqId: json['user_uniq_id'] as String,
      userType: json['user_type'] as int,
      nation: json['nation'] as int,
      nickname: json['nick_name'] as String,
      profilePic:
          const PicListConverter().fromJson(json['profile_pic'] as String),
    );

Map<String, dynamic> _$$AttendListDataImplToJson(
        _$AttendListDataImpl instance) =>
    <String, dynamic>{
      'user_uniq_id': instance.userUniqId,
      'user_type': instance.userType,
      'nation': instance.nation,
      'nick_name': instance.nickname,
      'profile_pic': const PicListConverter().toJson(instance.profilePic),
    };
