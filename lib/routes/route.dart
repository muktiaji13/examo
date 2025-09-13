import 'package:flutter/material.dart';
import '../features/auth/pages/login_page.dart';
import '../features/auth/pages/register_page.dart';
import '../features/siswa/pages/dashboard_page.dart';
import '../features/siswa/pages/pengaturan_page.dart';
import '../features/guru/pages/dashboard_page.dart';
import '../features/guru/pages/daftar_ujian_page.dart';
import '../features/guru/pages/bank_soal_page.dart';
import '../features/guru/pages/bank_soal_detail_page.dart';
import '../features/guru/pages/daftar_paket_page.dart';
import '../features/guru/pages/riwayat_pembelian_page.dart';
import '../features/guru/pages/kredensial_page.dart';
import '../features/guru/pages/profile_page.dart';
import '../features/guru/pages/detail_ujian_page.dart';

// Map routes
final Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => LoginPage(),
  '/register': (context) => const RegisterPage(),
  '/dashboard': (context) => const GuruDashboardPage(), 
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
};
