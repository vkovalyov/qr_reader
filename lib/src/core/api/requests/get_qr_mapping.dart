import 'package:qr_reader/src/core/api/requests/api_request.dart';
import 'package:qr_reader/src/features/home/data/dto/qr_mapping_dto.dart';

class GetQrMapping extends ApiRequest<QrMappingDto> {
  GetQrMapping({required super.executor});

  @override
  QrMappingDto convertJson(Map<String, dynamic> data) {
    return QrMappingDto.fromJson(data);
  }
}
