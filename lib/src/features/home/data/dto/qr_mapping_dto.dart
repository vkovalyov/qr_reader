class QrMappingDto {
  final String? qrLink;
  final String? scanQRCode;
  final String? alert;

  const QrMappingDto({
    required this.qrLink,
    required this.scanQRCode,
    required this.alert,
  });

  factory QrMappingDto.fromJson(Map<String, dynamic> map) {
    return QrMappingDto(
      qrLink: map['qrLink'],
      scanQRCode: map['scanQRCode'],
      alert: map['alert'],
    );
  }

  @override
  String toString() {
    return 'qrLink: $qrLink , scanQRCode: $scanQRCode , alert: $alert';
  }
}
