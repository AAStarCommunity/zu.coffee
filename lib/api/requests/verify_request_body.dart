import 'package:json_annotation/json_annotation.dart';

part 'verify_request_body.g.dart';

@JsonSerializable(explicitToJson: true)
class AttestationVerifyRequestBody {
  String? authenticatorAttachment;
  Map<String, dynamic>? clientExtensionResults;
  String? id;
  String? rawId;
  AttestationVerifyResponse? response;
  List<String>? transports;
  String? type;

  AttestationVerifyRequestBody(
      {this.authenticatorAttachment,
        this.clientExtensionResults,
        this.id,
        this.rawId,
        this.response,
        this.transports,
        this.type});

  factory AttestationVerifyRequestBody.fromJson(Map<String, dynamic> json) => _$VerifyRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyRequestBodyToJson(this);
}

@JsonSerializable()
class AttestationVerifyResponse {
  String? attestationObject;
  String? clientDataJSON;
  List<String>? transports;
  int? publicKeyAlgorithm;
  String? publicKey;
  String? authenticatorData;

  AttestationVerifyResponse({this.attestationObject, this.clientDataJSON, this.transports, this.publicKey, this.publicKeyAlgorithm, this.authenticatorData});

  factory AttestationVerifyResponse.fromJson(Map<String, dynamic> json) => _$VerifyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResponseToJson(this);
}