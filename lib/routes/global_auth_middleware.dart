import 'package:HexagonWarrior/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/account/login_page.dart';
import '../utils/validate_util.dart';

class GlobalAuthMiddleware extends GetMiddleware {

  @override
  RouteSettings? redirect(String? route) {
    if(!isNotNull(Get.find<SharedPreferences>().token)){
      return RouteSettings(name: LoginPage.routeName);
    }
    return super.redirect(route);
  }
}