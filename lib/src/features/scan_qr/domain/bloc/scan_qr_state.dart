part of 'scan_qr_bloc.dart';

abstract class ScanQrState {}

class ScanQrInitial extends ScanQrState {}

class ScanInProgress extends ScanQrState {}

class SendSuccess extends ScanQrState {}
