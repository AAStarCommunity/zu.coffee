
import 'dart:convert';
import 'package:HexagonWarrior/api/api.dart';
import 'package:HexagonWarrior/api/requests/verify_request_body.dart';
import 'package:webauthn/webauthn.dart';

import '../utils/webauthn/uint8list_converter.dart';
import 'requests/assertion_verify_request_body.dart';

extension ApiExt on Api {

 Future<AssertionVerifyRequestBody> createAssertionFromPublic(Map<String, dynamic> publicKey, String origin) async{
   final webApi = WebAPI();
   final rpOptions = CredentialRequestOptions.fromJson({"publicKey" : publicKey});
   final (clientData, getAssertionOptions) = await webApi.createGetAssertionOptions(
     origin,
     rpOptions,
     true,
   );
   final assertion = await Authenticator.handleGetAssertion(getAssertionOptions);
   final responseObj = await webApi.createAssertionResponse(clientData, assertion);

   final body = AssertionVerifyRequestBody(
       id: const Uint8ListConverter().toJson(responseObj.rawId),
       rawId: const Uint8ListConverter().toJson(responseObj.rawId),
       response: AssertionVerifyResponse(
          authenticatorData: const Uint8ListConverter().toJson(responseObj.response.authenticatorData),
          clientDataJSON: const Uint8ListConverter().toJson(responseObj.response.clientDataJSON),
          signature: const Uint8ListConverter().toJson(responseObj.response.signature),
          userHandle: const Uint8ListConverter().toJson(responseObj.response.userHandle)
       ),
       type: responseObj.type.value,
   );
   return body;
 }

 Future<AttestationVerifyRequestBody> createAttestationFromPublicKey(Map<String, dynamic> publicKey, String? authenticatorAttachment, String origin) async{

    final webApi = WebAPI();
    final ccop = CreateCredentialOptions.fromJson({"publicKey" : publicKey});
    final (clientData, options) = await webApi.createMakeCredentialOptions(origin, ccop, true);

    final attestation = await Authenticator.handleMakeCredential(options);
    final responseObj = await webApi.createAttestationResponse(clientData, attestation);

    final json = attestation.asJSON();
    final jsonObj = jsonDecode(json);

    final body = AttestationVerifyRequestBody(
        authenticatorAttachment: authenticatorAttachment,
        clientExtensionResults: <String, dynamic>{},
        id: const Uint8ListConverter().toJson(responseObj.rawId),
        rawId: const Uint8ListConverter().toJson(responseObj.rawId),
        response: AttestationVerifyResponse(
            attestationObject: const Uint8ListConverter().toJson(responseObj.response.attestationObject),
            clientDataJSON: const Uint8ListConverter().toJson(responseObj.response.clientDataJSON),//const Uint8ListConverter().toJson(utf8.encode(jsonEncode({"type": "webauthn.create", "challenge": res.data!.challenge, "origin": _ORIGIN_DOMAIN, "crossOrigin": false}))),
            transports: ["hybrid", AuthenticatorTransports.internal.value],
            authenticatorData: jsonObj['authData'],
            publicKey: const Uint8ListConverter().toJson(utf8.encode(jsonEncode(ccop.publicKey.toJson()))),//publicKey,
            publicKeyAlgorithm: jsonObj['attStmt']['alg']
        ),
        type: responseObj.type.value,
        transports: ["hybrid", AuthenticatorTransports.internal.value]
    );

    return body;
  }
}