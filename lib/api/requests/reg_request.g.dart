// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reg_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegRequest _$RegRequestFromJson(Map<String, dynamic> json) => RegRequest(
      captcha: json['captcha'] as String,
      email: json['email'] as String,
      origin: json['origin'] as String,
    );

Map<String, dynamic> _$RegRequestToJson(RegRequest instance) =>
    <String, dynamic>{
      'captcha': instance.captcha,
      'email': instance.email,
      'origin': instance.origin,
    };
