import 'package:json_annotation/json_annotation.dart';

part 'verify_request_body.g.dart';

@JsonSerializable(explicitToJson: true)
class VerifyRequestBody {
  String? authenticatorAttachment;
  Map<String, dynamic>? clientExtensionResults;
  String? id;
  String? rawId;
  VerifyResponse? response;
  List<String>? transports;
  String? type;

  VerifyRequestBody(
      {this.authenticatorAttachment,
        this.clientExtensionResults,
        this.id,
        this.rawId,
        this.response,
        this.transports,
        this.type});

  factory VerifyRequestBody.fromJson(Map<String, dynamic> json) => _$VerifyRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyRequestBodyToJson(this);
}

@JsonSerializable()
class VerifyResponse {
  String? attestationObject;
  String? clientDataJSON;
  List<String>? transports;
  int? publicKeyAlgorithm;
  String? publicKey;
  String? authenticatorData;

  VerifyResponse({this.attestationObject, this.clientDataJSON, this.transports, this.publicKey, this.publicKeyAlgorithm, this.authenticatorData});

  factory VerifyResponse.fromJson(Map<String, dynamic> json) => _$VerifyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResponseToJson(this);
}