import 'package:json_annotation/json_annotation.dart';

part 'verify_request_body.g.dart';

@JsonSerializable()
class VerifyRequestBody {
  String? authenticatorAttachment;
  ClientExtensionResults? clientExtensionResults;
  String? id;
  List<int>? rawId;
  Response? response;
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
class ClientExtensionResults {
  String? property1;
  String? property2;

  ClientExtensionResults({this.property1, this.property2});

  factory ClientExtensionResults.fromJson(Map<String, dynamic> json) => _$ClientExtensionResultsFromJson(json);

  Map<String, dynamic> toJson() => _$ClientExtensionResultsToJson(this);
}

@JsonSerializable()
class Response {
  List<int>? attestationObject;
  List<int>? clientDataJSON;
  List<String>? transports;

  Response({this.attestationObject, this.clientDataJSON, this.transports});

  factory Response.fromJson(Map<String, dynamic> json) => _$ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}