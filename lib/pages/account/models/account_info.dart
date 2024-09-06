import 'package:json_annotation/json_annotation.dart';

part 'account_info.g.dart';

@JsonSerializable(explicitToJson: true)
class AccountInfo {
  @JsonKey(name: "init_code")
  String? initCode;
  String? eoa;
  String? aa;
  String? email;
  String? usdtBalance;
  String? nftBalance;
  @JsonKey(name: "private_key")
  String? privateKey;

  AccountInfo({this.initCode, this.eoa, this.aa, this.email, this.privateKey});

  factory AccountInfo.fromJson(Map<String, dynamic> json) => _$AccountInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInfoToJson(this);
}