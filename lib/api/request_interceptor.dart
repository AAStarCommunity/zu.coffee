import 'package:HexagonWarrior/extensions/extensions.dart';
import 'package:HexagonWarrior/pages/account/login_page.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as Getx;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/validate_util.dart';

class RequestInterceptor extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = "Bearer ${Getx.Get.find<SharedPreferences>().token}";
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if(response.data is Map) {
      if(isNotNull(response.data['token'])) {
        Getx.Get.find<SharedPreferences>().token = response.data['token'];
      }
      if('${response.data['code']}' == '401') {
        Getx.Get.offAllNamed(LoginPage.routeName);
      }
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if(err.response?.data != null && err.response!.data is Map) {
      if('${err.response?.data['code']}' == '401') {
        Getx.Get.offAllNamed(LoginPage.routeName);
      }
    }
    super.onError(err, handler);
  }
}