import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generic_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class GenericResponse<T> {
  final int? code;
  final T? data;
  final String? message;
  final String? cost;

  String get msg => message ?? "";

  GenericResponse({this.code, this.data, this.message, this.cost});

  factory GenericResponse.error(String message) => GenericResponse(code: -1, data: null, message: message);

  factory GenericResponse.errorWithDioException(DioException e) {
    if(e.type == DioExceptionType.badResponse && e.response?.data != null && e.response!.data is Map) {
      return GenericResponse<T>.fromJson(e.response!.data, (data) => data as T);
    }
    return GenericResponse(code: -1, data: null, message: e.toString());
  }

  factory GenericResponse.success(String message) => GenericResponse(code: 200, data: null, message: message);

  bool get success {
    return code == 1 || code == 200;
  }

  factory GenericResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$GenericResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$GenericResponseToJson(this, toJsonT);

}
