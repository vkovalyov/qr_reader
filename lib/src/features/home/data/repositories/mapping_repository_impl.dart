import 'package:qr_reader/src/core/api/executors/request_executor.dart';
import 'package:qr_reader/src/core/api/requests/get_qr_mapping.dart';
import 'package:qr_reader/src/features/home/data/dto/qr_mapping_dto.dart';
import 'package:qr_reader/src/features/home/domain/repositories/mapping_repository.dart';

class MappingRepositoryImpl implements MappingRepository {
  final RequestExecutor executor;

  MappingRepositoryImpl(this.executor);

  @override
  Future<QrMappingDto> getMapping() async {
    final request = GetQrMapping(executor: executor);
    final dto = await request.exec();

    return dto;
  }
}
