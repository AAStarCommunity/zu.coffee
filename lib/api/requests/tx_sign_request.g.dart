// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tx_sign_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TxSignRequest _$TxSignRequestFromJson(Map<String, dynamic> json) =>
    TxSignRequest(
      nonce: json['nonce'] as String?,
      origin: json['origin'] as String?,
      txdata: json['txdata'] as String?,
    );

Map<String, dynamic> _$TxSignRequestToJson(TxSignRequest instance) =>
    <String, dynamic>{
      'nonce': instance.nonce,
      'origin': instance.origin,
      'txdata': instance.txdata,
    };
