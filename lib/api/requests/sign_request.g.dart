// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignRequest _$SignRequestFromJson(Map<String, dynamic> json) => SignRequest(
      captcha: json['captcha'] as String?,
      email: json['email'] as String?,
      origin: json['origin'] as String?,
    );

Map<String, dynamic> _$SignRequestToJson(SignRequest instance) =>
    <String, dynamic>{
      'captcha': instance.captcha,
      'email': instance.email,
      'origin': instance.origin,
    };
