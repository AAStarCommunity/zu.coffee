import 'dart:async';
import 'dart:convert';
import 'package:HexagonWarrior/api/api.dart';
import 'package:HexagonWarrior/api/generic_response.dart';
import 'package:HexagonWarrior/api/requests/reg_request.dart';
import 'package:HexagonWarrior/api/requests/sign_request.dart';
import 'package:HexagonWarrior/api/requests/verify_request_body.dart';
import 'package:HexagonWarrior/api/response/reg_response.dart';
import 'package:HexagonWarrior/extensions/extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/requests/prepare_request.dart';
import 'package:webauthn/webauthn.dart';
import '../../utils/validate_util.dart';
import '../../utils/webauthn/uint8list_converter.dart';

const _ORIGIN_DOMAIN = "https://demoweb.aastar.io";
const _network = "optimism-sepolia";

class AccountController extends GetxController {

  Future<void> getAccountInfo() async{
    final resp = await Api().getAccountInfo();
  }

  Future<GenericResponse> register(String email, {String? captcha, String? network = _network}) async{
    try {
      GenericResponse<RegResponse> res = await Api().reg(RegRequest(captcha: captcha!, email: email, origin: _ORIGIN_DOMAIN));
      if(res.success) {
        final webApi = WebAPI();
        final ccop = CreateCredentialOptions.fromJson({"publicKey" : res.data!.toJson()});
        final (clientData, options) = await webApi.createMakeCredentialOptions(_ORIGIN_DOMAIN, ccop, true);

        final attestation = await Authenticator.handleMakeCredential(options);
        final responseObj = await webApi.createAttestationResponse(clientData, attestation);

        final json = attestation.asJSON();
        final jsonObj = jsonDecode(json);

        final body = VerifyRequestBody(
            authenticatorAttachment: res.data?.authenticatorSelection?.authenticatorAttachment,
            clientExtensionResults: <String, dynamic>{},
            id: const Uint8ListConverter().toJson(responseObj.rawId),
            rawId: const Uint8ListConverter().toJson(responseObj.rawId),
            response: VerifyResponse(
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

        final resp = await Api().regVerify(email, _ORIGIN_DOMAIN, network, body);
        if(isNotNull(resp.token)){

          return GenericResponse.success("ok");
        }
      }
      return res;
    } catch(e, s) {
      debugPrintStack(stackTrace: s, label: e.toString());
      return GenericResponse.errorWithDioException(e as DioException);
    }
  }

  Future<GenericResponse> prepare(String email) async{
    var res = await Api().prepare(PrepareRequest(email: email));
    return res;
  }


  Future<GenericResponse> login(String email, VerifyRequestBody body, {String? captcha}) async{
      var res = await Api().sign(SignRequest(captcha: captcha, email: email, origin: _ORIGIN_DOMAIN));
      if(res.success) {
        res = await Api().signVerify(email, _ORIGIN_DOMAIN, body);
      }

    return res;
  }

  @override
  void onClose() {
    super.onClose();

  }

  Future<GenericResponse> logout() async{
    Get.find<SharedPreferences>().token = null;
    await Future.delayed(const Duration(seconds: 3));
    final res = GenericResponse.success("ok");
    return res;
  }
}