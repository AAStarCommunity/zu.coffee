// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tx_sign_verify_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TxSignVerifyRequest _$TxSignVerifyRequestFromJson(Map<String, dynamic> json) =>
    TxSignVerifyRequest(
      nonce: json['nonce'] as String,
      origin: json['origin'] as String,
    );

Map<String, dynamic> _$TxSignVerifyRequestToJson(
        TxSignVerifyRequest instance) =>
    <String, dynamic>{
      'nonce': instance.nonce,
      'origin': instance.origin,
    };
