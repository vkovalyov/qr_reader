import 'package:dio/dio.dart';

class DioClient {
  static const baseUrl = "https://api.test.millennium-falcon.team/";

  late Dio dio;

  static const _receiveTimeout = Duration(seconds: 15000);
  static const _connectTimeout = Duration(seconds: 15000);
  static const _sendTimeout = Duration(seconds: 15000);

  Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: _receiveTimeout,
      connectTimeout: _connectTimeout,
      sendTimeout: _sendTimeout,
      responseType: ResponseType.json,
    ));

    return dio;
  }
}
