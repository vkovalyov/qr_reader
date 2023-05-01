import 'package:flutter/material.dart';
import 'package:qr_reader/src/core/di/repository_injection_container.dart';
import 'package:qr_reader/src/core/extensions/localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_reader/src/features/home/data/dto/qr_mapping_dto.dart';
import 'package:qr_reader/src/features/home/domain/bloc/home_bloc.dart';
import 'package:qr_reader/src/features/home/domain/repositories/mapping_repository.dart';
import 'package:qr_reader/src/features/scan_qr/presentation/scan_qr_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: BlocProvider<HomeBloc>(
        create: (_) {
          final bloc = HomeBloc(slRepository<MappingRepository>());
          bloc.add(InitEvent());
          return bloc;
        },
        child: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is HomeInitial) {
                return const CircularProgressIndicator(color: Colors.green);
              } else if (state is HomeError) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<HomeBloc>().add(InitEvent());
                  },
                  child: Text(context.localization.toRetry),
                );
              } else {
                final stateData = state as HomeData;
                return ElevatedButton(
                    onPressed: () {
                      navigateToScanScreen(context, stateData.qrMappingDto);
                    },
                    child: Text(stateData.qrMappingDto.scanQRCode ??
                        context.localization.scanQrCode));
              }
            }),
      )),
    ));
  }

  void navigateToScanScreen(
      BuildContext context, QrMappingDto qrMappingDto) async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ScanQrScreen(
              qrMappingDto: qrMappingDto,
            )));
  }
}
