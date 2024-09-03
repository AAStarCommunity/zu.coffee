import 'package:HexagonWarrior/api/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {

  TextEditingController emailCtrl = TextEditingController();

  Future<HttpResult> login() async{
    await Future.delayed(const Duration(seconds: 3));
    final res = HttpResult.success(1, "ok", null);
    return res;
  }

  @override
  void onClose() {
    super.onClose();
    emailCtrl.dispose();
  }

  Future<HttpResult> logout() async{
    await Future.delayed(const Duration(seconds: 3));
    final res = HttpResult.success(1, "ok", null);
    return res;
  }
}