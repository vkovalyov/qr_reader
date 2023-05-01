import 'package:dio/dio.dart';
import 'package:qr_reader/src/core/api/executors/request_executor.dart';
import 'package:qr_reader/src/features/scan_qr/data/qr_data_dto.dart';
import 'package:qr_reader/src/features/scan_qr/domain/repositories/scan_qr_repository.dart';

class ScanQrRepositoryImpl implements ScanQrRepository {
  final RequestExecutor executor;

  ScanQrRepositoryImpl(this.executor);

  @override
  Future<bool> sendQr(QrDataDto qrDataDto) async {
    final option = RequestOptions(data: qrDataDto.toJson());
    final data = await executor.execute(requestOptions: option);

    if (data.statusCode == 200) {
      return true;
    }
    return false;
  }
}
