import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_reader/src/features/home/data/dto/qr_mapping_dto.dart';
import 'package:qr_reader/src/features/home/domain/bloc/home_bloc.dart';
import 'package:qr_reader/src/features/home/domain/repositories/mapping_repository.dart';

class MockMappingRepository extends Mock implements MappingRepository {}

const dto = QrMappingDto(qrLink: '', scanQRCode: '', alert: '');

void main() {
  late HomeBloc homeBloc;
  late MappingRepository mappingRepository;

  group('tests HomeBloc', () {
    setUp(() async {
      mappingRepository = MockMappingRepository();
      homeBloc = HomeBloc(mappingRepository);
    });

    test('initial state', () {
      expect(homeBloc.state, isA<HomeInitial>());
    });

    blocTest<HomeBloc, HomeState>(
      'event  InitEvent'
      'emit [HomeInitial , HomeData]',
      build: () {
        when(() => mappingRepository.getMapping())
            .thenAnswer((_) async => Future<QrMappingDto>.value(dto));
        return homeBloc;
      },
      wait: const Duration(milliseconds: 1000),
      act: (bloc) => bloc.add(InitEvent()),
      expect: () => [isA<HomeInitial>(), isA<HomeData>()],
    );

    blocTest<HomeBloc, HomeState>(
      'Error : event  InitEvent => emit [HomeError]',
      build: () {
        when(() => mappingRepository.getMapping()).thenThrow(Exception());
        return homeBloc;
      },
      wait: const Duration(milliseconds: 1000),
      act: (bloc) => bloc.add(InitEvent()),
      expect: () => [isA<HomeInitial>(), isA<HomeError>()],
    );
  });
}
