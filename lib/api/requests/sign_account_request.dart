import 'package:json_annotation/json_annotation.dart';

part 'sign_account_request.g.dart';

@JsonSerializable()
class SignAccountRequest {

  SignAccountRequest();

  factory SignAccountRequest.fromJson(Map<String, dynamic> json) => _$SignAccountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignAccountRequestToJson(this);
}