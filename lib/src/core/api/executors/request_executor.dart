import 'package:dio/dio.dart';

abstract class RequestExecutor {
  Future<Response> execute({RequestOptions? requestOptions});
}
