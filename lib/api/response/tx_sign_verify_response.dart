

class SignVerifyResponse {
  int? code;
  String? txdata;
  String? sign;
  String? privateKey;
  String? address;

  SignVerifyResponse(
      {this.code, this.txdata, this.sign, this.privateKey, this.address});

  SignVerifyResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    txdata = json['txdata'];
    sign = json['sign'];
    privateKey = json['privateKey'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['txdata'] = this.txdata;
    data['sign'] = this.sign;
    data['privateKey'] = this.privateKey;
    data['address'] = this.address;
    return data;
  }
}
