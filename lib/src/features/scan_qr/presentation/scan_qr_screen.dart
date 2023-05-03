import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_reader/src/core/di/repository_injection_container.dart';
import 'package:qr_reader/src/features/home/data/dto/qr_mapping_dto.dart';
import 'package:qr_reader/src/core/extensions/localization.dart';
import 'package:qr_reader/src/features/scan_qr/domain/bloc/scan_qr_bloc.dart';
import 'package:qr_reader/src/features/scan_qr/domain/repositories/scan_qr_repository.dart';
import 'package:qr_reader/src/features/scan_qr/presentation/qr_scan_widget.dart';

class ScanQrScreen extends StatelessWidget {
  final QrMappingDto qrMappingDto;

  const ScanQrScreen({Key? key, required this.qrMappingDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider<ScanQrBloc>(
            create: (_) {
              final bloc = ScanQrBloc(slRepository<ScanQrRepository>());
              bloc.add(InitScanQrEvent());
              return bloc;
            },
            child: BlocConsumer<ScanQrBloc, ScanQrState>(
              listener: (context, state) {
                if (state is SendSuccess) {
                  var snackBar = SnackBar(
                    content:
                        Text(qrMappingDto.alert ?? context.localization.alert),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  Navigator.of(context).pop();
                } else if (state is SendError) {
                  var snackBar = const SnackBar(
                    content: Text('Ошибка при отправке qr-кода'),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              builder: (context, state) {
                if (state is ScanQrInitial || state is SendError) {
                  return QrScanWidget(
                    qrMappingDto: qrMappingDto,
                  );
                } else if (state is ScanInProgress) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  );
                } else {
                  return const SizedBox();
                }
              },
            )),
      ),
    );
  }
}
