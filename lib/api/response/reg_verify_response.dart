import 'package:json_annotation/json_annotation.dart';

part 'reg_verify_response.g.dart';

@JsonSerializable(explicitToJson: true)
class RegVerifyResponse {
  int? code;
  String? expire;
  String? token;

  RegVerifyResponse({this.code, this.expire, this.token});

  factory RegVerifyResponse.fromJson(Map<String, dynamic> json) => _$RegVerifyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegVerifyResponseToJson(this);
}


