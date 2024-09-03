import 'package:json_annotation/json_annotation.dart';

part 'reg_response.g.dart';

@JsonSerializable()
class RegResponse {
  String? attestation;
  AuthenticatorSelection? authenticatorSelection;
  List<int>? challenge;
  List<ExcludeCredentials>? excludeCredentials;
  Extensions? extensions;
  List<PubKeyCredParams>? pubKeyCredParams;
  Rp? rp;
  int? timeout;
  User? user;

  RegResponse(
      {this.attestation,
        this.authenticatorSelection,
        this.challenge,
        this.excludeCredentials,
        this.extensions,
        this.pubKeyCredParams,
        this.rp,
        this.timeout,
        this.user});

  factory RegResponse.fromJson(Map<String, dynamic> json) => _$RegResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegResponseToJson(this);
}


@JsonSerializable()
class AuthenticatorSelection {
  String? authenticatorAttachment;
  bool? requireResidentKey;
  String? residentKey;
  String? userVerification;

  AuthenticatorSelection(
      {this.authenticatorAttachment,
        this.requireResidentKey,
        this.residentKey,
        this.userVerification});

  factory AuthenticatorSelection.fromJson(Map<String, dynamic> json) => _$AuthenticatorSelectionFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticatorSelectionToJson(this);

}


@JsonSerializable()
class ExcludeCredentials {
  List<int>? id;
  List<String>? transports;
  String? type;

  ExcludeCredentials({this.id, this.transports, this.type});

  factory ExcludeCredentials.fromJson(Map<String, dynamic> json) => _$ExcludeCredentialsFromJson(json);

  Map<String, dynamic> toJson() => _$ExcludeCredentialsToJson(this);
}


@JsonSerializable()
class Extensions {
  String? property1;
  String? property2;

  Extensions({this.property1, this.property2});

  factory Extensions.fromJson(Map<String, dynamic> json) => _$ExtensionsFromJson(json);

  Map<String, dynamic> toJson() => _$ExtensionsToJson(this);
}


@JsonSerializable()
class PubKeyCredParams {
  int? alg;
  String? type;

  PubKeyCredParams({this.alg, this.type});

  factory PubKeyCredParams.fromJson(Map<String, dynamic> json) => _$PubKeyCredParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PubKeyCredParamsToJson(this);
}


@JsonSerializable()
class Rp {
  String? icon;
  String? id;
  String? name;

  Rp({this.icon, this.id, this.name});

  factory Rp.fromJson(Map<String, dynamic> json) => _$RpFromJson(json);

  Map<String, dynamic> toJson() => _$RpToJson(this);
}


@JsonSerializable()
class User {
  String? displayName;
  String? icon;
  String? id;
  String? name;

  User({this.displayName, this.icon, this.id, this.name});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}
