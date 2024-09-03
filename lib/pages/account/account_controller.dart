import 'dart:async';

import 'package:HexagonWarrior/api/api.dart';
import 'package:HexagonWarrior/api/requests/reg_request.dart';
import 'package:HexagonWarrior/api/requests/reg_verify_request.dart';
import 'package:HexagonWarrior/api/requests/sign_request.dart';
import 'package:HexagonWarrior/api/requests/sign_verify_request.dart';
import 'package:HexagonWarrior/api/response.dart';
import 'package:HexagonWarrior/extensions/extensions.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/requests/prepare_request.dart';

class AccountController extends GetxController {

  Future<HttpResult> register(String email) async{

     var res = await Api().reg(RegRequest(captcha: "", email: "", origin: ""));
      if(res.success) {
        res = await Api().regVerify(RegVerifyRequest(email: "", origin: ""));
        if(res.success) {

        }
     }

    return res;
  }

  Future<HttpResult> prepare(String email) async{
    var res = await Api().prepare(PrepareRequest(email: email));
    return res;
  }


  Future<HttpResult> login(String email, {String? captcha}) async{
      var res = await Api().sign(SignRequest(captcha: captcha, email: email, origin: ""));
      if(res.success) {
        res = await Api().signVerify(SignVerifyRequest(email: email, origin: ""));
      }

    return res;
  }

  @override
  void onClose() {
    super.onClose();

  }

  Future<HttpResult> logout() async{
    Get.find<SharedPreferences>().token = null;
    await Future.delayed(const Duration(seconds: 3));
    final res = HttpResult.success(1, "ok", null);
    return res;
  }
}