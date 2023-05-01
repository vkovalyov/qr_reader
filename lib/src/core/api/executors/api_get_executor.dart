import 'package:dio/dio.dart';
import 'package:qr_reader/src/core/api/executors/request_executor.dart';
import 'package:qr_reader/src/core/errors/network_failures.dart';

class ApiGetExecutor implements RequestExecutor {
  final Dio _dio;

  ApiGetExecutor(this._dio);

  @override
  Future<Response> execute({RequestOptions? requestOptions}) async {
    try {
      final response = await _dio.get(_dio.options.baseUrl);

      if (response.data != null) {
        return response;
      } else {
        throw NetworkFailure();
      }
    } on DioError {
      throw NetworkFailure();
    }
  }
}
