// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reg_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegResponse _$RegResponseFromJson(Map<String, dynamic> json) => RegResponse(
      attestation: json['attestation'] as String?,
      authenticatorSelection: json['authenticatorSelection'] == null
          ? null
          : AuthenticatorSelection.fromJson(
              json['authenticatorSelection'] as Map<String, dynamic>),
      challenge: (json['challenge'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      excludeCredentials: (json['excludeCredentials'] as List<dynamic>?)
          ?.map((e) => ExcludeCredentials.fromJson(e as Map<String, dynamic>))
          .toList(),
      extensions: json['extensions'] == null
          ? null
          : Extensions.fromJson(json['extensions'] as Map<String, dynamic>),
      pubKeyCredParams: (json['pubKeyCredParams'] as List<dynamic>?)
          ?.map((e) => PubKeyCredParams.fromJson(e as Map<String, dynamic>))
          .toList(),
      rp: json['rp'] == null
          ? null
          : Rp.fromJson(json['rp'] as Map<String, dynamic>),
      timeout: (json['timeout'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegResponseToJson(RegResponse instance) =>
    <String, dynamic>{
      'attestation': instance.attestation,
      'authenticatorSelection': instance.authenticatorSelection,
      'challenge': instance.challenge,
      'excludeCredentials': instance.excludeCredentials,
      'extensions': instance.extensions,
      'pubKeyCredParams': instance.pubKeyCredParams,
      'rp': instance.rp,
      'timeout': instance.timeout,
      'user': instance.user,
    };

AuthenticatorSelection _$AuthenticatorSelectionFromJson(
        Map<String, dynamic> json) =>
    AuthenticatorSelection(
      authenticatorAttachment: json['authenticatorAttachment'] as String?,
      requireResidentKey: json['requireResidentKey'] as bool?,
      residentKey: json['residentKey'] as String?,
      userVerification: json['userVerification'] as String?,
    );

Map<String, dynamic> _$AuthenticatorSelectionToJson(
        AuthenticatorSelection instance) =>
    <String, dynamic>{
      'authenticatorAttachment': instance.authenticatorAttachment,
      'requireResidentKey': instance.requireResidentKey,
      'residentKey': instance.residentKey,
      'userVerification': instance.userVerification,
    };

ExcludeCredentials _$ExcludeCredentialsFromJson(Map<String, dynamic> json) =>
    ExcludeCredentials(
      id: (json['id'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      transports: (json['transports'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$ExcludeCredentialsToJson(ExcludeCredentials instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transports': instance.transports,
      'type': instance.type,
    };

Extensions _$ExtensionsFromJson(Map<String, dynamic> json) => Extensions(
      property1: json['property1'] as String?,
      property2: json['property2'] as String?,
    );

Map<String, dynamic> _$ExtensionsToJson(Extensions instance) =>
    <String, dynamic>{
      'property1': instance.property1,
      'property2': instance.property2,
    };

PubKeyCredParams _$PubKeyCredParamsFromJson(Map<String, dynamic> json) =>
    PubKeyCredParams(
      alg: (json['alg'] as num?)?.toInt(),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$PubKeyCredParamsToJson(PubKeyCredParams instance) =>
    <String, dynamic>{
      'alg': instance.alg,
      'type': instance.type,
    };

Rp _$RpFromJson(Map<String, dynamic> json) => Rp(
      icon: json['icon'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$RpToJson(Rp instance) => <String, dynamic>{
      'icon': instance.icon,
      'id': instance.id,
      'name': instance.name,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      displayName: json['displayName'] as String?,
      icon: json['icon'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'displayName': instance.displayName,
      'icon': instance.icon,
      'id': instance.id,
      'name': instance.name,
    };
