import 'package:qr_reader/src/features/home/data/dto/qr_mapping_dto.dart';

abstract class MappingRepository {
  Future<QrMappingDto> getMapping();
}
