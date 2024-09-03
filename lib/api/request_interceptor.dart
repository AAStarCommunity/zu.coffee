import 'package:HexagonWarrior/extensions/extensions.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as GET;
import 'package:shared_preferences/shared_preferences.dart';

class RequestInterceptor extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = GET.Get.find<SharedPreferences>().token;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}