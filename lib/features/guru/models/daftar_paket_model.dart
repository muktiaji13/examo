import 'dart:ui';

class Paket {
  final String id;
  final String nama;
  final String subtitle;
  final bool isActive;
  final Color adminColor;
  final int harga;
  final Map<String, bool> fitur;

  Paket({
    required this.id,
    required this.nama,
    required this.subtitle,
    required this.isActive,
    required this.adminColor,
    required this.harga,
    required this.fitur,
  });
}
