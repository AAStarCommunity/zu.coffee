// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInfoResponse _$AccountInfoResponseFromJson(Map<String, dynamic> json) =>
    AccountInfoResponse(
      initCode: json['initCode'] as String?,
      eoa: json['eoa'] as String?,
      aa: json['aa'] as String?,
      email: json['email'] as String?,
      privateKey: json['privateKey'] as String?,
    );

Map<String, dynamic> _$AccountInfoResponseToJson(
        AccountInfoResponse instance) =>
    <String, dynamic>{
      'initCode': instance.initCode,
      'eoa': instance.eoa,
      'aa': instance.aa,
      'email': instance.email,
      'privateKey': instance.privateKey,
    };
