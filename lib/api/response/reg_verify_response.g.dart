// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reg_verify_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegVerifyResponse _$RegVerifyResponseFromJson(Map<String, dynamic> json) =>
    RegVerifyResponse(
      code: (json['code'] as num?)?.toInt(),
      expire: json['expire'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$RegVerifyResponseToJson(RegVerifyResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'expire': instance.expire,
      'token': instance.token,
    };
