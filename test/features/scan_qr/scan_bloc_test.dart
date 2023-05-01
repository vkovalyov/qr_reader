import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_reader/src/features/scan_qr/data/qr_data_dto.dart';
import 'package:qr_reader/src/features/scan_qr/domain/bloc/scan_qr_bloc.dart';
import 'package:qr_reader/src/features/scan_qr/domain/repositories/scan_qr_repository.dart';

class MockScanQrRepository extends Mock implements ScanQrRepository {}

const sendDto = QrDataDto(qr: 'qr');

void main() {
  late ScanQrBloc scanQrBloc;
  late ScanQrRepository scanQrRepository;

  group('tests HomeBloc', () {
    setUp(() async {
      scanQrRepository = MockScanQrRepository();
      scanQrBloc = ScanQrBloc(scanQrRepository);
    });

    test('initial state', () {
      expect(scanQrBloc.state, isA<ScanQrInitial>());
    });

    blocTest<ScanQrBloc, ScanQrState>(
      'event  InitScanQrEvent'
      'emit [ScanQrInitial]',
      build: () {
        return scanQrBloc;
      },
      wait: const Duration(milliseconds: 1000),
      act: (bloc) => bloc.add(InitScanQrEvent()),
      expect: () => [isA<ScanQrInitial>()],
    );
  });
}
