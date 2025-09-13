class SyaratSection {
  final String number;
  final String title;
  final String? content;
  final List<String>? bullets;

  SyaratSection({
    required this.number,
    required this.title,
    this.content,
    this.bullets,
  });
}

// Data syarat dan ketentuan
final List<SyaratSection> syaratKetentuanData = [
  SyaratSection(
    number: '1.',
    title: 'Penerimaan Syarat',
    content: 'Dengan menggunakan Examo Anda dianggap menyetujui syarat dan ketentuan yang berlaku. Jika tidak setuju harap tidak menggunakan layanan ini.',
  ),
  SyaratSection(
    number: '2.',
    title: 'Layanan',
    content: 'Examo. menyediakan layanan ujian online pembuatan ujian pembuatan bank soal dan program detail nilai melalui platfrom digital',
  ),
  SyaratSection(
    number: '3.',
    title: 'Akun Pengguna',
    bullets: [
      'Pengguna wajib mengisi data dengan benar dan lengkap.',
      'Menjaga akun dan kata sandi adalah tanggung jawab pengguna.',
      'Segala aktivitas dalam akun menjadi tanggung jawab pemiliknya.',
    ],
  ),
  SyaratSection(
    number: '4.',
    title: 'Hak Cipta dan Konten',
    bullets: [
      'Semua materi dan konten di platform ini dilindungi hak cipta dan tidak boleh disalin didistribusikan atau digunakan tanpa izin tertulis.',
      'Pengguna tidak diperbolehkan mengunggah konten yang melanggar hukum atau mengandung SARA.',
    ],
  ),
  SyaratSection(
    number: '5.',
    title: 'Perubahan Layanan',
    content: 'Kami berhak untuk mengubah menghentikan atau memperbarui fitur atau ketentuan kapan saja dengan atau tanpa pemberitahuan sebelumnya.',
  ),
];