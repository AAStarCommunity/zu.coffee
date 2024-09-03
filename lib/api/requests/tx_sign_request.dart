import 'package:json_annotation/json_annotation.dart';

part 'tx_sign_request.g.dart';

@JsonSerializable()
class TxSignRequest {
  String? nonce;
  String? origin;
  String? txdata;

  TxSignRequest({
    this.nonce,
    this.origin,
    this.txdata,
  });

  factory TxSignRequest.fromJson(Map<String, dynamic> json) => _$TxSignRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TxSignRequestToJson(this);

}