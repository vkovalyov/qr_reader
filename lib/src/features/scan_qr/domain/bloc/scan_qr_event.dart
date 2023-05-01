part of 'scan_qr_bloc.dart';

abstract class ScanQrEvent {}

class InitScanQrEvent extends ScanQrEvent {}

class SendScanCodeEvent extends ScanQrEvent {
  final String code;

  SendScanCodeEvent(this.code);
}
