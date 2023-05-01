part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeError extends HomeState {}

class HomeData extends HomeState {
  final QrMappingDto qrMappingDto;

  HomeData(this.qrMappingDto);
}
