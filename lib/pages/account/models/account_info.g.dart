// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInfo _$AccountInfoFromJson(Map<String, dynamic> json) => AccountInfo(
      initCode: json['initCode'] as String?,
      eoa: json['eoa'] as String?,
      aa: json['aa'] as String?,
      email: json['email'] as String?,
      privateKey: json['privateKey'] as String?,
    );

Map<String, dynamic> _$AccountInfoToJson(AccountInfo instance) =>
    <String, dynamic>{
      'initCode': instance.initCode,
      'eoa': instance.eoa,
      'aa': instance.aa,
      'email': instance.email,
      'privateKey': instance.privateKey,
    };
