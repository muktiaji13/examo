import 'package:flutter/material.dart';
import '../../../config/styles.dart';
import '../../../shared/widgets/sidebar_widget.dart';
import '../../../shared/widgets/app_header.dart';
import 'detail_ujian_page.dart'; 

class GuruDashboardPage extends StatefulWidget {
  const GuruDashboardPage({Key? key}) : super(key: key);

  @override
  State<GuruDashboardPage> createState() => _GuruDashboardPageState();
}

class _GuruDashboardPageState extends State<GuruDashboardPage> {
  String activeMenu = 'dashboard';
  bool isSidebarVisible = false;

  // Dummy data sesuai gambar
  final List<Map<String, String>> ujianAktifList = [
    {
      'title': 'Ujian Bab Komputer In..',
      'questions': '25 Pertanyaan',
      'image': 'assets/images/ujian_aktif.png',
      'status': 'Aktif'
    },
  ];

  final List<Map<String, String>> bankSoalList = [
    {
      'title': 'Informatika Komputer d..',
      'desc': 'Sistem operasi dan sistem kom..',
      'time': '2j lalu',
      'image': 'assets/images/bank_soal.png',
    },
  ];

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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Column(
                                    children: [
                                      TextField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: AppColors.white,
                                          hintText: 'Telusuri',
                                          hintStyle: AppTextStyle.inputText,
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: SizedBox(
                                              width: 36,
                                              height: 36,
                                              child: Image.asset(
                                                'assets/images/search_icon.png',
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // Halo Card
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFFFFFFF),
                                          Color(0xFFD8EFFF),
                                        ],
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Halo, Sobat Examo!',
                                                style:
                                                    AppTextStyle.title.copyWith(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                'Nikmati berbagai fitur menarik dan hebat dari examo. Buat ujianmu jadi gampang!',
                                                style: AppTextStyle.subtitle
                                                    .copyWith(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Image.asset(
                                          'assets/images/banner_image.png',
                                          height: 72,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // Stat Cards
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      _statCard(
                                        title: 'Total Ujian',
                                        subtitle: 'Dibuat Admin',
                                        count: '19',
                                        color: const Color(0xFFFBF2EF),
                                        iconBg: const Color(0xFFFE9479),
                                        iconPath: 'assets/images/ujian_icon.png',
                                      ),
                                      const SizedBox(width: 12),
                                      _statCard(
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
                                _sectionHeader('Ujian Aktif'),
                                const SizedBox(height: 12),
                                if (ujianAktifList.isEmpty)
                                  _emptyCard(
                                    message: 'Oops! Daftar Ujian Belum Tersedia',
                                    desc:
                                        'Klik "Tambah Ujian" untuk mulai membuat ujian baru.',
                                    image: 'assets/images/empty_exam.png',
                                  )
                                else
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      children: ujianAktifList
                                          .map((item) => _buildUjianAktifCard(item))
                                          .toList(),
                                    ),
                                  ),

                                const SizedBox(height: 24),

                                // Bank Soal Section
                                _sectionHeader('Bank Soal'),
                                const SizedBox(height: 12),
                                if (bankSoalList.isEmpty)
                                  _emptyCard(
                                    message: 'Oops! Bank Soal Belum Tersedia',
                                    desc:
                                        'Klik "Tambah Bank Soal" untuk mulai membuat bank soal.',
                                    image: 'assets/images/empty_bank.png',
                                  )
                                else
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      children: bankSoalList
                                          .map((item) => _buildBankSoalCard(item))
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUjianAktifCard(Map<String, String> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: const Color(0xFFEBEBEB)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: const Color(0xFFD5EDFF),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: Image.asset(item['image'] ?? 'assets/images/ujian_aktif.png', height: 80),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    item['title'] ?? '',
                    style: AppTextStyle.blackSubtitle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9FFF2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    item['status'] ?? 'Aktif',
                    style: AppTextStyle.menuItem.copyWith(
                      color: const Color(0xFF2ECC71),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(item['questions'] ?? '', style: AppTextStyle.cardSubtitle),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ExamDetailPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(
                          colors: [AppColors.primaryBlue, Color(0xFF025BB1)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Center(
                        child: Text('Selengkapnya', style: AppTextStyle.button),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEAEB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Image.asset('assets/images/trash.png', height: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankSoalCard(Map<String, String> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F8FF),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: Image.asset(item['image'] ?? 'assets/images/bank_soal.png', height: 72),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] ?? '',
                        style: AppTextStyle.blackSubtitle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['desc'] ?? '',
                        style: AppTextStyle.cardSubtitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(item['time'] ?? '', style: AppTextStyle.cardSubtitle),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                        colors: [AppColors.primaryBlue, Color(0xFF025BB1)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Center(
                      child: Text('Detail', style: AppTextStyle.button),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEAEB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Image.asset('assets/images/trash.png', height: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard({
    required String title,
    required String subtitle,
    required String count,
    required Color color,
    required Color iconBg,
    required String iconPath,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(iconPath, height: 20),
            ),
            const SizedBox(height: 10),
            Text(count, style: AppTextStyle.title.copyWith(fontSize: 20)),
            Text(
              title,
              style: AppTextStyle.subtitle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(subtitle, style: AppTextStyle.subtitle.copyWith(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.title.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('Selengkapnya', style: AppTextStyle.link.copyWith(fontSize: 13)),
        ],
      ),
    );
  }

  Widget _emptyCard({
    required String message,
    required String desc,
    required String image,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 28),
        child: Column(
          children: [
            Image.asset(image, height: 64),
            const SizedBox(height: 12),
            Text(message, style: AppTextStyle.title.copyWith(fontSize: 14)),
            Text(desc, style: AppTextStyle.subtitle.copyWith(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
