import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_reader/src/features/scan_qr/data/qr_data_dto.dart';
import 'package:qr_reader/src/features/scan_qr/domain/bloc/scan_qr_bloc.dart';
import 'package:qr_reader/src/features/scan_qr/domain/repositories/scan_qr_repository.dart';

class MockScanQrRepository extends Mock implements ScanQrRepository {}

class MockQrDataDto extends Fake implements QrDataDto {}

void main() {
  late ScanQrBloc scanQrBloc;
  late ScanQrRepository scanQrRepository;

  setUpAll(() {
    registerFallbackValue(MockQrDataDto());
  });

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

    blocTest<ScanQrBloc, ScanQrState>(
      'event  SendScanCodeEvent'
      'result = true => emit [SendSuccess]',
      build: () {
        scanQrRepository = MockScanQrRepository();

        when(() => scanQrRepository.sendQr(any()))
            .thenAnswer((_) => Future<bool>.value(true));
        return ScanQrBloc(scanQrRepository);
      },
      wait: const Duration(milliseconds: 1000),
      act: (bloc) => bloc.add(SendScanCodeEvent('qr')),
      expect: () => [isA<ScanInProgress>(), isA<SendSuccess>()],
    );

    blocTest<ScanQrBloc, ScanQrState>(
      'event  SendScanCodeEvent'
      'result = false => emit [ScanQrInitial]',
      build: () {
        scanQrRepository = MockScanQrRepository();

        when(() => scanQrRepository.sendQr(any()))
            .thenAnswer((_) => Future<bool>.value(false));
        return ScanQrBloc(scanQrRepository);
      },
      wait: const Duration(milliseconds: 1000),
      act: (bloc) => bloc.add(SendScanCodeEvent('qr')),
      expect: () => [isA<ScanInProgress>(), isA<ScanQrInitial>()],
    );
  });
}
