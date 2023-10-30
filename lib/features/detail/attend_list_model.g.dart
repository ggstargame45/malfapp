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
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$$AttendListDataImplToJson(
        _$AttendListDataImpl instance) =>
    <String, dynamic>{
      'user_uniq_id': instance.userUniqId,
      'user_type': instance.userType,
      'nation': instance.nation,
      'nickname': instance.nickname,
    };
