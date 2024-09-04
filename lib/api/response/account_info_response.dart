import 'package:json_annotation/json_annotation.dart';

part 'account_info_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AccountInfoResponse {

  @JsonKey(name: "init_code")
  String? initCode;
  String? eoa;
  String? aa;
  String? email;
  @JsonKey(name: "private_key")
  String? privateKey;

  AccountInfoResponse({this.initCode, this.eoa, this.aa, this.email, this.privateKey});

  factory AccountInfoResponse.fromJson(Map<String, dynamic> json) => _$AccountInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInfoResponseToJson(this);
}