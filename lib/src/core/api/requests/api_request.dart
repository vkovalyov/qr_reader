import 'package:qr_reader/src/core/api/executors/request_executor.dart';

abstract class ApiRequest<T> {
  final RequestExecutor executor;

  final Map<String, dynamic> params;
  final Map<String, String> headers;

  ApiRequest({
    required this.executor,

    this.params = const <String, dynamic>{},
    this.headers = const <String, String>{},
  });

  Future<T> exec() async {
    final response = await executor.execute();

    return convertJson(response.data);
  }

  T convertJson(Map<String, dynamic> data);
}