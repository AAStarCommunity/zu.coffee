import 'package:json_annotation/json_annotation.dart';

part 'tx_sign_verify_request.g.dart';

@JsonSerializable()
class TxSignVerifyRequest {

  String nonce;

  String origin;

  TxSignVerifyRequest({
    required this.nonce,
    required this.origin,
  });

  factory TxSignVerifyRequest.fromJson(Map<String, dynamic> json) => _$TxSignVerifyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TxSignVerifyRequestToJson(this);

}