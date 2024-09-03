import 'package:json_annotation/json_annotation.dart';

part 'reg_verify_request.g.dart';

@JsonSerializable()
class RegVerifyRequest {

  String email;

  String? network;

  String origin;

  RegVerifyRequest({
    required this.email,
    this.network,
    required this.origin,
  });

  factory RegVerifyRequest.fromJson(Map<String, dynamic> json) => _$RegVerifyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegVerifyRequestToJson(this);

}