import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tambah_ujian_model.dart';

class UjianFormNotifier extends StateNotifier<UjianFormData> {
  UjianFormNotifier() : super(UjianFormData(
    judul: "",
    tanggal: "",
    jamMulai: "",
    waktu: "",
    jumlahSoal: "",
    kkm: "",
    deskripsi: "",
  ));

  void updateJudul(String value) {
    state = state.copyWith(judul: value);
  }

  void updateTanggal(String value) {
    state = state.copyWith(tanggal: value);
  }

  void updateJamMulai(String value) {
    state = state.copyWith(jamMulai: value);
  }

  void updateWaktu(String value) {
    state = state.copyWith(waktu: value);
  }

  void updateJumlahSoal(String value) {
    state = state.copyWith(jumlahSoal: value);
  }

  void updateKkm(String value) {
    state = state.copyWith(kkm: value);
  }

  void updateDeskripsi(String value) {
    state = state.copyWith(deskripsi: value);
  }
}

final ujianFormProvider = StateNotifierProvider<UjianFormNotifier, UjianFormData>(
  (ref) => UjianFormNotifier(),
);