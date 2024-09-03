// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reg_verify_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegVerifyRequest _$RegVerifyRequestFromJson(Map<String, dynamic> json) =>
    RegVerifyRequest(
      email: json['email'] as String,
      network: json['network'] as String?,
      origin: json['origin'] as String,
    );

Map<String, dynamic> _$RegVerifyRequestToJson(RegVerifyRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'network': instance.network,
      'origin': instance.origin,
    };
