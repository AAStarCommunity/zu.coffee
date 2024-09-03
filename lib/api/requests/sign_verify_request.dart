import 'package:json_annotation/json_annotation.dart';

part 'sign_verify_request.g.dart';

@JsonSerializable()
class SignVerifyRequest {

  String email;

  String origin;

  SignVerifyRequest({
    required this.email,
    required this.origin,
  });

}