import 'package:qr_reader/src/core/api/requests/api_request.dart';
import 'package:qr_reader/src/features/scan_qr/data/qr_data_dto.dart';

class PostQrData extends ApiRequest<QrDataDto> {
  PostQrData({required super.executor});

  @override
  QrDataDto convertJson(Map<String, dynamic> data) {
    return QrDataDto.fromJson(data);
  }
}
