class UjianFormData {
  final String judul;
  final String tanggal;
  final String jamMulai;
  final String waktu;
  final String jumlahSoal;
  final String kkm;
  final String deskripsi;

  UjianFormData({
    required this.judul,
    required this.tanggal,
    required this.jamMulai,
    required this.waktu,
    required this.jumlahSoal,
    required this.kkm,
    required this.deskripsi,
  });

  Map<String, dynamic> toMap() {
    return {
      "judul": judul,
      "tanggal": tanggal,
      "jamMulai": jamMulai,
      "waktu": waktu,
      "jumlahSoal": jumlahSoal,
      "kkm": kkm,
      "deskripsi": deskripsi,
    };
  }

  factory UjianFormData.fromMap(Map<String, dynamic> map) {
    return UjianFormData(
      judul: map["judul"] ?? "",
      tanggal: map["tanggal"] ?? "",
      jamMulai: map["jamMulai"] ?? "",
      waktu: map["waktu"] ?? "",
      jumlahSoal: map["jumlahSoal"] ?? "",
      kkm: map["kkm"] ?? "",
      deskripsi: map["deskripsi"] ?? "",
    );
  }

  // Tambahkan method copyWith
  UjianFormData copyWith({
    String? judul,
    String? tanggal,
    String? jamMulai,
    String? waktu,
    String? jumlahSoal,
    String? kkm,
    String? deskripsi,
  }) {
    return UjianFormData(
      judul: judul ?? this.judul,
      tanggal: tanggal ?? this.tanggal,
      jamMulai: jamMulai ?? this.jamMulai,
      waktu: waktu ?? this.waktu,
      jumlahSoal: jumlahSoal ?? this.jumlahSoal,
      kkm: kkm ?? this.kkm,
      deskripsi: deskripsi ?? this.deskripsi,
    );
  }
}