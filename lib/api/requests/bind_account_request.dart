import 'package:json_annotation/json_annotation.dart';

part 'bind_account_request.g.dart';

@JsonSerializable()
class BindAccountRequest {
  String? account;
  String? publicKey;

  BindAccountRequest({
    this.account,
    this.publicKey,
  });


  factory BindAccountRequest.fromJson(Map<String ,dynamic> json) => _$BindAccountRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BindAccountRequestToJson(this);

}