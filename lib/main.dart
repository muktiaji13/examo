import 'package:examo/features/auth/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/auth/login_page.dart';
import 'features/siswa/pages/dashboard_page.dart';
import 'features/siswa/pages/pengaturan_page.dart';
import 'features/guru/pages/dashboard_page.dart';
import 'features/guru/pages/daftar_ujian_page.dart';
import 'features/guru/pages/bank_soal_page.dart';
import 'features/guru/pages/bank_soal_detail_page.dart';
import 'features/guru/pages/daftar_paket_page.dart';
import 'features/guru/pages/riwayat_pembelian_page.dart';
import 'features/guru/pages/kredensial_page.dart';
import 'features/guru/pages/profile_page.dart';
import 'features/guru/pages/exam_detail_page.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/dashboard': (context) => const HomePage(), 
        '/dashboard-siswa': (context) => const DashboardPage(), 
        '/daftar_ujian': (context) => const DaftarUjianPage(),
        '/bank_soal': (context) => const BankSoalPage(),
        '/bank_soal_detail': (context) => const BankSoalDetailPage(),
        '/paket': (context) => const DaftarPaketPage(),
        '/riwayat': (context) => const RiwayatPembelianPage(),
        '/kredensial': (context) => const KredensialPage(),
        '/profil': (context) => const ProfilePage(),
        '/pengaturan': (context) => const PengaturanPage(),
        '/detail_ujian': (context) => const ExamDetailPage(),
      },
    );
  }
}
