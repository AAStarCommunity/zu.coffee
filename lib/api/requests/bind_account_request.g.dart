// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bind_account_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BindAccountRequest _$BindAccountRequestFromJson(Map<String, dynamic> json) =>
    BindAccountRequest(
      account: json['account'] as String?,
      publicKey: json['publicKey'] as String?,
    );

Map<String, dynamic> _$BindAccountRequestToJson(BindAccountRequest instance) =>
    <String, dynamic>{
      'account': instance.account,
      'publicKey': instance.publicKey,
    };
