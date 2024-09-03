// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_verify_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignVerifyRequest _$SignVerifyRequestFromJson(Map<String, dynamic> json) =>
    SignVerifyRequest(
      email: json['email'] as String,
      origin: json['origin'] as String,
    );

Map<String, dynamic> _$SignVerifyRequestToJson(SignVerifyRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'origin': instance.origin,
    };
