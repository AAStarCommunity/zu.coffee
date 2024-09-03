// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyRequestBody _$VerifyRequestBodyFromJson(Map<String, dynamic> json) =>
    VerifyRequestBody(
      authenticatorAttachment: json['authenticatorAttachment'] as String?,
      clientExtensionResults: json['clientExtensionResults'] == null
          ? null
          : ClientExtensionResults.fromJson(
              json['clientExtensionResults'] as Map<String, dynamic>),
      id: json['id'] as String?,
      rawId: (json['rawId'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      response: json['response'] == null
          ? null
          : Response.fromJson(json['response'] as Map<String, dynamic>),
      transports: (json['transports'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$VerifyRequestBodyToJson(VerifyRequestBody instance) =>
    <String, dynamic>{
      'authenticatorAttachment': instance.authenticatorAttachment,
      'clientExtensionResults': instance.clientExtensionResults,
      'id': instance.id,
      'rawId': instance.rawId,
      'response': instance.response,
      'transports': instance.transports,
      'type': instance.type,
    };

ClientExtensionResults _$ClientExtensionResultsFromJson(
        Map<String, dynamic> json) =>
    ClientExtensionResults(
      property1: json['property1'] as String?,
      property2: json['property2'] as String?,
    );

Map<String, dynamic> _$ClientExtensionResultsToJson(
        ClientExtensionResults instance) =>
    <String, dynamic>{
      'property1': instance.property1,
      'property2': instance.property2,
    };

Response _$ResponseFromJson(Map<String, dynamic> json) => Response(
      attestationObject: (json['attestationObject'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      clientDataJSON: (json['clientDataJSON'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      transports: (json['transports'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'attestationObject': instance.attestationObject,
      'clientDataJSON': instance.clientDataJSON,
      'transports': instance.transports,
    };
