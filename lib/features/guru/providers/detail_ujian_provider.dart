import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/detail_ujian_model.dart';

final detailUjianProvider = Provider<DetailUjian>((ref) {
  return DetailUjian(
    title: 'Ujian Bab 2 INF',
    timeText: '08 : 00 WIB',
    code: 'INF4356789202',
    date: '12 Juni 2025',
    duration: '120 Menit',
    questionCount: '25 Soal',
    kkm: '75',
    description:
        'Ujian informatika Bab 1, mengujikan kepada siswa tentang dasar komputer yang meliputi perangkat keras, perangkat lunak, dan fungsinya dalam proses kerja komputer. Semoga berhasil !',
    rules: [
      'Peserta wajib login menggunakan akun yang telah terdaftar sebelum memulai ujian.',
      'Ujian hanya dapat diakses pada waktu yang telah ditentukan.',
      'Dilarang keras membuka tab, aplikasi, atau perangkat lain selama ujian berlangsung.',
      'Peserta dilarang bekerja sama atau menyalin jawaban dari peserta lain.',
      'Setiap pelanggaran akan tercatat dan berpotensi menyebabkan ujian dibatalkan.',
      'Jika koneksi internet terputus, peserta harus segera menghubungi pengawas ujian.',
    ],
  );
});