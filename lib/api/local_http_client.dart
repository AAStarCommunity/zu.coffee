import 'dart:io';
import 'package:HexagonWarrior/api/request_interceptor.dart';
import 'package:dio/io.dart' ;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio/dio.dart';

class LocalHttpClient {

  static final LocalHttpClient _instance = LocalHttpClient._internal();

  factory LocalHttpClient() => _instance;

  static late final Dio dio;

  LocalHttpClient._internal() {
    dio = Dio();
    dio.interceptors.add(RequestInterceptor());
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        //compact: false,
        //logPrint: (log) => simple(text: '$log')
    ));

    //dio.interceptors.add(EncryptInterceptor());

    const proxy = String.fromEnvironment("proxy", defaultValue: "");

    if (proxy.isNotEmpty) {
      (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        var client = HttpClient();
        client.findProxy = (uri) {
          return "PROXY $proxy";
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  void init({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Map<String, String>? headers,
    List<Interceptor>? interceptors,
  }) {
    dio.options = dio.options.copyWith(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout ?? const Duration(seconds: 30),
      receiveTimeout: receiveTimeout ?? const Duration(minutes: 2),
      headers: headers,
    );
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }
  }
}