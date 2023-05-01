import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_reader/src/features/home/data/dto/qr_mapping_dto.dart';
import 'package:qr_reader/src/features/home/domain/repositories/mapping_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  MappingRepository repository;

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<InitEvent>(_onInit);
  }

  FutureOr<void> _onInit(HomeEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeInitial());
      final data = await repository.getMapping();
      emit(HomeData(data));
    } catch (e) {
      emit(HomeError());
    }
  }
}
