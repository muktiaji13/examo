import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/daftar_paket_model.dart';

final paketListProvider = Provider<List<Paket>>((ref) {
  return [
    // Paket nonaktif
    Paket(
      id: 'paket_1',
      nama: 'Paket Basic',
      subtitle: 'Untuk pengguna aktif',
      isActive: false,
      adminColor: const Color(0xFFD234E0),
      harga: 50000,
      fitur: {
        'Ujian tak terbatas': false,
        'Akses ke semua bank soal': false,
        'Tanpa iklan': false,
      },
    ),
    Paket(
      id: 'paket_2',
      nama: 'Paket Basic',
      subtitle: 'Untuk pengguna aktif',
      isActive: true,
      adminColor: const Color(0xFFD234E0),
      harga: 50000,
      fitur: {
        'Ujian tak terbatas': false,
        'Akses ke semua bank soal': false,
        'Tanpa iklan': false,
      },
    ),
  ];
});