// import 'package:json_annotation/json_annotation.dart';
//
// @JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class SignResponse {
  String? challenge;
  int? timeout;
  String? rpId;
  List<AllowCredentials>? allowCredentials;
  String? userVerification;
  Extensions? extensions;

  SignResponse(
      {this.challenge,
        this.timeout,
        this.rpId,
        this.allowCredentials,
        this.userVerification,
        this.extensions});

  SignResponse.fromJson(Map<String, dynamic> json) {
    challenge = json['challenge'];
    timeout = json['timeout'];
    rpId = json['rpId'];
    if (json['allowCredentials'] != null) {
      allowCredentials = <AllowCredentials>[];
      json['allowCredentials'].forEach((v) {
        allowCredentials!.add(new AllowCredentials.fromJson(v));
      });
    }
    userVerification = json['userVerification'];
    extensions = json['extensions'] != null
        ? new Extensions.fromJson(json['extensions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['challenge'] = this.challenge;
    data['timeout'] = this.timeout;
    data['rpId'] = this.rpId;
    if (this.allowCredentials != null) {
      data['allowCredentials'] =
          this.allowCredentials!.map((v) => v.toJson()).toList();
    }
    data['userVerification'] = this.userVerification;
    if (this.extensions != null) {
      data['extensions'] = this.extensions!.toJson();
    }
    return data;
  }
}

class AllowCredentials {
  String? type;
  String? id;
  List<String>? transports;

  AllowCredentials({this.type, this.id, this.transports});

  AllowCredentials.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    transports = json['transports'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['transports'] = this.transports;
    return data;
  }
}

class Extensions {
  String? nonce;
  String? txdata;

  Extensions({this.nonce, this.txdata});

  Extensions.fromJson(Map<String, dynamic> json) {
    nonce = json['nonce'];
    txdata = json['txdata'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nonce'] = this.nonce;
    data['txdata'] = this.txdata;
    return data;
  }
}
