import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider dummy data
final ujianProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {
      'title': 'Ujian Bab Komputer In..',
      'status': 'Aktif',
      'questions': '25 Pertanyaan',
      'image': 'assets/images/ujian_aktif.png',
    },
    {
      'title': 'Ujian Bab Komputer In..',
      'status': 'Berlangsung',
      'questions': '25 Pertanyaan',
      'image': 'assets/images/no-image.png',
    },
    {
      'title': 'Ujian Bab Komputer In..',
      'status': 'Nonaktif',
      'questions': '25 Pertanyaan',
      'image': 'assets/images/ujian_aktif.png',
    },
  ];
});