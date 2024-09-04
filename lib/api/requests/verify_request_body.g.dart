// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttestationVerifyRequestBody _$VerifyRequestBodyFromJson(Map<String, dynamic> json) =>
    AttestationVerifyRequestBody(
      authenticatorAttachment: json['authenticatorAttachment'] as String?,
      clientExtensionResults:
          json['clientExtensionResults'] as Map<String, dynamic>?,
      id: json['id'] as String?,
      rawId: json['rawId'] as String?,
      response: json['response'] == null
          ? null
          : AttestationVerifyResponse.fromJson(json['response'] as Map<String, dynamic>),
      transports: (json['transports'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$VerifyRequestBodyToJson(AttestationVerifyRequestBody instance) =>
    <String, dynamic>{
      'authenticatorAttachment': instance.authenticatorAttachment,
      'clientExtensionResults': instance.clientExtensionResults,
      'id': instance.id,
      'rawId': instance.rawId,
      'response': instance.response?.toJson(),
      'transports': instance.transports,
      'type': instance.type,
    };

AttestationVerifyResponse _$VerifyResponseFromJson(Map<String, dynamic> json) =>
    AttestationVerifyResponse(
      attestationObject: json['attestationObject'] as String?,
      clientDataJSON: json['clientDataJSON'] as String?,
      transports: (json['transports'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      publicKey: json['publicKey'] as String?,
      publicKeyAlgorithm: (json['publicKeyAlgorithm'] as num?)?.toInt(),
      authenticatorData: json['authenticatorData'] as String?,
    );

Map<String, dynamic> _$VerifyResponseToJson(AttestationVerifyResponse instance) =>
    <String, dynamic>{
      'attestationObject': instance.attestationObject,
      'clientDataJSON': instance.clientDataJSON,
      'transports': instance.transports,
      'publicKeyAlgorithm': instance.publicKeyAlgorithm,
      'publicKey': instance.publicKey,
      'authenticatorData': instance.authenticatorData,
    };
