import 'package:json_annotation/json_annotation.dart';

part 'account_info.g.dart';

@JsonSerializable(explicitToJson: true)
class AccountInfo {
  String? initCode;
  String? eoa;
  String? aa;
  String? email;
  String? privateKey;

  AccountInfo({this.initCode, this.eoa, this.aa, this.email, this.privateKey});

  factory AccountInfo.fromJson(Map<String, dynamic> json) => _$AccountInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInfoToJson(this);
}