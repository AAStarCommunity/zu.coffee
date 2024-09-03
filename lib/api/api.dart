import 'package:HexagonWarrior/api/response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'local_http_client.dart';

part 'api.g.dart';

@RestApi(baseUrl: 'base')
abstract class Api{
  factory Api({Dio? dio, String? baseUrl}) {
    LocalHttpClient().init(baseUrl: baseUrl);
    return _Api(dio ?? LocalHttpClient.dio, baseUrl: baseUrl);
  }

  @POST("/create")
  Future<VoidModel> create(@Body() Map<String, dynamic> req);
}