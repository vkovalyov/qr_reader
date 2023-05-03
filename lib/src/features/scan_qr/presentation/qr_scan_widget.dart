import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_reader/src/features/home/data/dto/qr_mapping_dto.dart';
import 'package:qr_reader/src/core/extensions/localization.dart';
import 'package:qr_reader/src/features/scan_qr/domain/bloc/scan_qr_bloc.dart';

const _overlayRadius = 10.0;
const _overlayColor = Color.fromRGBO(0, 0, 0, 150);
const _overlayBorderLength = 30.0;
const _overlayBorderWidth = 5.0;

class QrScanWidget extends StatefulWidget {
  final QrMappingDto qrMappingDto;

  const QrScanWidget({Key? key, required this.qrMappingDto}) : super(key: key);

  @override
  State<QrScanWidget> createState() => _QrScanWidgetState();
}

class _QrScanWidgetState extends State<QrScanWidget> {
  final GlobalKey qrKey = GlobalKey();
  DateTime lastScan = DateTime.now();
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        QRView(
          formatsAllowed: const [BarcodeFormat.qrcode],
          overlay: QrScannerOverlayShape(
            borderColor: Colors.white,
            overlayColor: _overlayColor,
            borderRadius: _overlayRadius,
            borderLength: _overlayBorderLength,
            borderWidth: _overlayBorderWidth,
          ),
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
        ),
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
        Positioned.fill(
            top: MediaQuery.of(context).size.height / 2,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                widget.qrMappingDto.qrLink ?? context.localization.qrLink,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ))
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    this.controller?.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      if (DateTime.now().difference(lastScan) > const Duration(seconds: 3)) {
        lastScan = DateTime.now();
        context
            .read<ScanQrBloc>()
            .add(SendScanCodeEvent(scanData.code ?? ''));
      }

    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
