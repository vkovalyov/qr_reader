import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_reader/src/features/scan_qr/data/qr_data_dto.dart';
import 'package:qr_reader/src/features/scan_qr/domain/repositories/scan_qr_repository.dart';

part 'scan_qr_event.dart';

part 'scan_qr_state.dart';

class ScanQrBloc extends Bloc<ScanQrEvent, ScanQrState> {
  final ScanQrRepository scanQrRepository;

  ScanQrBloc(this.scanQrRepository) : super(ScanQrInitial()) {
    on<InitScanQrEvent>((event, emit) {
      emit(ScanQrInitial());
    });

    on<SendScanCodeEvent>((event, emit) async {
      emit(ScanInProgress());
      try {
        final result = await scanQrRepository.sendQr(QrDataDto(qr: event.code));

        if (result) {
          emit(SendSuccess());
        } else {
          emit(ScanQrInitial());
        }
      } catch (e) {
        emit(SendError());
      }
    });
  }
}
