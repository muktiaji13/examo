
class DashboardModel {
  static List<Map<String, String>> get ujianAktifList => [
    {
      'title': 'Ujian Bab Komputer In..',
      'questions': '25 Pertanyaan',
      'image': 'assets/images/ujian_aktif.png',
      'status': 'Aktif'
    },
  ];

  static List<Map<String, String>> get bankSoalList => [
    {
      'title': 'Informatika Komputer d..',
      'desc': 'Sistem operasi dan sistem kom..',
      'time': '2j lalu',
      'image': 'assets/images/bank_soal.png',
    },
  ];
}