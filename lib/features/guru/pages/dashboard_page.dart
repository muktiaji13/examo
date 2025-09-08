import 'package:flutter/material.dart';
import '../../../config/styles.dart';
import '../../../shared/widgets/sidebar_widget.dart';
import '../widgets/dashboard_widget.dart';
import '../../../shared/widgets/app_header.dart';
import '../models/dashboard_model.dart';

class GuruDashboardPage extends StatefulWidget {
  const GuruDashboardPage({super.key});
  
  @override
  State<GuruDashboardPage> createState() => _GuruDashboardPageState();
}

class _GuruDashboardPageState extends State<GuruDashboardPage> {
  String activeMenu = 'dashboard';
  bool isSidebarVisible = false;
  
  // Menggunakan data dari model
  final List<Map<String, String>> ujianAktifList = DashboardModel.ujianAktifList;
  final List<Map<String, String>> bankSoalList = DashboardModel.bankSoalList;
  
  void onMenuTap(String menuKey) {
    setState(() {
      activeMenu = menuKey;
      isSidebarVisible = false;
    });
    print("Navigasi ke: $menuKey");
  }
  
  void toggleSidebar() {
    setState(() {
      isSidebarVisible = !isSidebarVisible;
    });
  }
  
  void closeSidebar() {
    setState(() {
      isSidebarVisible = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isWideScreen = screenWidth > 1000;
    final double sidebarWidth = isWideScreen ? 300 : 240;
    final double sidebarLeftPosition = isSidebarVisible ? 0 : -sidebarWidth;
    final double mainContentLeftPadding = isSidebarVisible && isWideScreen
        ? sidebarWidth
        : 0;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          Row(
            children: [
              // Main content
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.only(left: mainContentLeftPadding),
                  child: SafeArea(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: AppLayout.maxWidth,
                        ),
                        child: Container(
                          color: const Color(0xFFF5F5F5),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                AppHeader(
                                  onMenuTap: toggleSidebar,
                                ),
                                const SizedBox(height: 20),
                                // Search bar
                                const DashboardSearchBar(),
                                const SizedBox(height: 24),
                                // Halo Card
                                const DashboardHaloCard(),
                                const SizedBox(height: 24),
                                // Stat Cards
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      DashboardStatCard(
                                        title: 'Total Ujian',
                                        subtitle: 'Dibuat Admin',
                                        count: '19',
                                        color: const Color(0xFFFBF2EF),
                                        iconBg: const Color(0xFFFE9479),
                                        iconPath: 'assets/images/ujian_icon.png',
                                      ),
                                      const SizedBox(width: 12),
                                      DashboardStatCard(
                                        title: 'Total Siswa',
                                        subtitle: 'Mengikuti Ujian',
                                        count: '109',
                                        color: const Color(0xFFFEF5E5),
                                        iconBg: const Color(0xFFFEC53D),
                                        iconPath: 'assets/images/siswa_icon.png',
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),
                                // Ujian Aktif Section
                                const DashboardSectionHeader('Ujian Aktif', title: '',),
                                const SizedBox(height: 12),
                                if (ujianAktifList.isEmpty)
                                  const DashboardEmptyCard(
                                    message: 'Oops! Daftar Ujian Belum Tersedia',
                                    desc: 'Klik "Tambah Ujian" untuk mulai membuat ujian baru.',
                                    image: 'assets/images/empty_exam.png',
                                  )
                                else
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      children: ujianAktifList
                                          .map((item) => DashboardUjianAktifCard(item: item))
                                          .toList(),
                                    ),
                                  ),
                                const SizedBox(height: 24),
                                // Bank Soal Section
                                const DashboardSectionHeader('Bank Soal', title: '',),
                                const SizedBox(height: 12),
                                if (bankSoalList.isEmpty)
                                  const DashboardEmptyCard(
                                    message: 'Oops! Bank Soal Belum Tersedia',
                                    desc: 'Klik "Tambah Bank Soal" untuk mulai membuat bank soal.',
                                    image: 'assets/images/empty_bank.png',
                                  )
                                else
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      children: bankSoalList
                                          .map((item) => DashboardBankSoalCard(item: item))
                                          .toList(),
                                    ),
                                  ),
                                const SizedBox(height: 36),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Overlay untuk mobile saat sidebar terbuka
          if (isSidebarVisible && !isWideScreen)
            GestureDetector(
              onTap: closeSidebar,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isSidebarVisible ? 1 : 0,
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
          // Sidebar
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: sidebarLeftPosition,
            top: MediaQuery.of(context).padding.top,
            bottom: 0,
            child: Container(
              width: sidebarWidth,
              color: Colors.white,
              child: SidebarWidget(
                activeMenu: activeMenu,
                onMenuTap: onMenuTap,
                onClose: closeSidebar,
                isVisible: isSidebarVisible, 
              ),
            ),
          ),
        ],
      ),
    );
  }
}