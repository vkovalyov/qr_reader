import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_reader/src/core/api/client/dio_client.dart';
import 'package:qr_reader/src/core/api/executors/api_get_executor.dart';
import 'package:qr_reader/src/core/api/executors/api_post_executor.dart';

final slExecutor = GetIt.instance;

Future<void> init() async {
  Dio dio = DioClient().createDio();

  slExecutor.registerFactory<ApiGetExecutor>(() => ApiGetExecutor(dio));
  slExecutor.registerFactory<ApiPostExecutor>(() => ApiPostExecutor(dio));
}
