
class AssertionVerifyRequestBody {
  String? authenticatorAttachment;
  Map<String, dynamic>? clientExtensionResults;
  String? id;
  String? rawId;
  AssertionVerifyResponse? response;
  String? type;

  AssertionVerifyRequestBody(
      {this.authenticatorAttachment,
        this.clientExtensionResults,
        this.id,
        this.rawId,
        this.response,
        this.type});

  AssertionVerifyRequestBody.fromJson(Map<String, dynamic> json) {
    authenticatorAttachment = json['authenticatorAttachment'];
    clientExtensionResults = json['clientExtensionResults'];
    id = json['id'];
    rawId = json['rawId'];
    response = json['response'] != null
        ? new AssertionVerifyResponse.fromJson(json['response'])
        : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authenticatorAttachment'] = this.authenticatorAttachment;
    if (this.clientExtensionResults != null) {
      data['clientExtensionResults'] = this.clientExtensionResults;
    }
    data['id'] = this.id;
    data['rawId'] = this.rawId;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    data['type'] = this.type;
    return data;
  }
}

class AssertionVerifyResponse {
  String? authenticatorData;
  String? clientDataJSON;
  String? signature;
  String? userHandle;

  AssertionVerifyResponse(
      {this.authenticatorData,
        this.clientDataJSON,
        this.signature,
        this.userHandle});

  AssertionVerifyResponse.fromJson(Map<String, dynamic> json) {
    authenticatorData = json['authenticatorData'].cast<int>();
    clientDataJSON = json['clientDataJSON'].cast<int>();
    signature = json['signature'].cast<int>();
    userHandle = json['userHandle'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authenticatorData'] = this.authenticatorData;
    data['clientDataJSON'] = this.clientDataJSON;
    data['signature'] = this.signature;
    data['userHandle'] = this.userHandle;
    return data;
  }
}
