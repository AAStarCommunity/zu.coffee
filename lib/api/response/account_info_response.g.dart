// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInfoResponse _$AccountInfoResponseFromJson(Map<String, dynamic> json) =>
    AccountInfoResponse(
      initCode: json['init_code'] as String?,
      eoa: json['eoa'] as String?,
      aa: json['aa'] as String?,
      email: json['email'] as String?,
      privateKey: json['private_key'] as String?,
    );

Map<String, dynamic> _$AccountInfoResponseToJson(
        AccountInfoResponse instance) =>
    <String, dynamic>{
      'init_code': instance.initCode,
      'eoa': instance.eoa,
      'aa': instance.aa,
      'email': instance.email,
      'private_key': instance.privateKey,
    };
