class QrDataDto {
  final String qr;

  const QrDataDto({required this.qr});

  factory QrDataDto.fromJson(Map<String, dynamic> map) {
    return QrDataDto(qr: map['qr']);
  }

  Map<String, dynamic> toJson() {
    return {
      'qr': qr,
    };
  }
}
