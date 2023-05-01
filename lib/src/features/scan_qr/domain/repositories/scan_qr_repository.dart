import 'package:qr_reader/src/features/scan_qr/data/qr_data_dto.dart';

abstract class ScanQrRepository {
  Future<bool> sendQr(QrDataDto qrDataDto);
}
