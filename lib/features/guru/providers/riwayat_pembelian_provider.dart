import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider state Riverpod
final activeMenuProvider = StateProvider<String>((ref) => 'riwayat');
final sidebarVisibleProvider = StateProvider<bool>((ref) => false);

// Dummy data pembelian
final pembelianProvider = Provider<List<Map<String, dynamic>>>((ref) {
  return List.generate(10, (index) {
    return {
      "no": index + 1,
      "namaPaket": ["Paket Pro", "Paket Premium", "Paket Basic"][index % 3],
      "durasi": "1 Bulan",
      "tglMulai": index % 2 == 0 ? "01 Mei 2025" : "01 April 2025",
      "tglAkhir": index % 2 == 0 ? "1 Juni 2025" : "1 Mei 2025",
      "status": ["Tuntas", "Pending", "Kadaluarsa"][index % 3],
    };
  });
});