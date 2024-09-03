
import 'package:HexagonWarrior/api/requests/bind_account_request.dart';
import 'package:HexagonWarrior/api/requests/sign_account_request.dart';
import 'package:HexagonWarrior/api/requests/tx_sign_request.dart';
import 'package:HexagonWarrior/api/response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'local_http_client.dart';
import 'requests/prepare_request.dart';
import 'requests/reg_request.dart';
import 'requests/reg_verify_request.dart';
import 'requests/sign_request.dart';
import 'requests/sign_verify_request.dart';
import 'requests/tx_sign_verify_request.dart';

part 'api.g.dart';

@RestApi(baseUrl: 'https://airaccount.aastar.io')
abstract class Api{
  factory Api({Dio? dio, String? baseUrl}) {
    LocalHttpClient().init(baseUrl: baseUrl);
    return _Api(dio ?? LocalHttpClient.dio, baseUrl: baseUrl);
  }

  @POST("/api/passkey/v1/reg/prepare")
  Future<VoidModel> prepare(@Body() PrepareRequest req);

  @POST('/api/passkey/v1/reg')
  Future<VoidModel> reg(@Body() RegRequest req);

  @POST("/api/passkey/v1/reg/verify")
  Future<VoidModel> regVerify(@Body() RegVerifyRequest req);

  @POST("/api/passkey/v1/sign")
  Future<VoidModel> sign(@Body() SignRequest req);

  @POST("/api/passkey/v1/sign/verify")
  Future<VoidModel> signVerify(@Body() SignVerifyRequest req);

  @GET("/api/passkey/v1/account/info")
  Future<VoidModel> getAccountInfo();

  @POST("/api/passkey/v1/tx/sign")
  Future<VoidModel> txSign(@Body() TxSignRequest req);

  @POST("/api/passkey/v1/tx/sign/verify")
  Future<VoidModel> txSignVerify(@Body() TxSignVerifyRequest req);

  @POST("/api/account/v1/transfer")
  Future<VoidModel> transfer(@Query("apiKey") String apiKey);

  @POST("/api/account/v1/bind")
  Future<VoidModel> bind(@Body() BindAccountRequest req);

  @POST("/api/account/v1/sign")
  Future<VoidModel> signAccount(@Body() SignAccountRequest req);
}