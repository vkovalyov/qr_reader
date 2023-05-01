import 'package:get_it/get_it.dart';
import 'package:qr_reader/src/core/api/executors/api_get_executor.dart';
import 'package:qr_reader/src/core/api/executors/api_post_executor.dart';
import 'package:qr_reader/src/core/di/executor_injection_container.dart';
import 'package:qr_reader/src/features/home/data/repositories/mapping_repository_impl.dart';
import 'package:qr_reader/src/features/home/domain/repositories/mapping_repository.dart';
import 'package:qr_reader/src/features/scan_qr/data/repositories/scan_qr_repository_impl.dart';
import 'package:qr_reader/src/features/scan_qr/domain/repositories/scan_qr_repository.dart';

final slRepository = GetIt.instance;

Future<void> init() async {
  slRepository.registerLazySingleton<MappingRepository>(
      () => MappingRepositoryImpl(slExecutor<ApiGetExecutor>()));

  slRepository.registerLazySingleton<ScanQrRepository>(
          () => ScanQrRepositoryImpl(slExecutor<ApiPostExecutor>()));

}
