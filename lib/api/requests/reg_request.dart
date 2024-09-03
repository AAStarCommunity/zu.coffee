import 'package:json_annotation/json_annotation.dart';

part 'reg_request.g.dart';

@JsonSerializable()
class RegRequest {
  final String captcha;
  final String email;
  final String origin;


  RegRequest({required this.captcha, required this.email, required this.origin});

  factory RegRequest.fromJson(Map<String, dynamic> json) => _$RegRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegRequestToJson(this);
}
