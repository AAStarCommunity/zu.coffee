import 'package:json_annotation/json_annotation.dart';

part 'sign_request.g.dart';

@JsonSerializable()
class SignRequest {
  String? captcha;
  String? email;
  String? origin;

  SignRequest({
    this.captcha,
    this.email,
    this.origin,
  });

  factory SignRequest.fromJson(Map<String, dynamic> json) => _$SignRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignRequestToJson(this);
}