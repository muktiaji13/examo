import 'package:flutter/material.dart';
import '../../../config/styles.dart';
import '../../../shared/widgets/sidebar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activeMenu = 'dashboard';
  bool isSidebarVisible = false;

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
                                // AppBar dan Konten
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 0,
                                  ),
                                  child: Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: toggleSidebar,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            padding: const EdgeInsets.all(4),
                                            child: Image.asset(
                                              'assets/images/sidebar_icon.png',
                                              height: 32,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(4),
                                          child: Image.asset(
                                            'assets/images/notif_icon.png',
                                            height: 24,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(4),
                                          child: const CircleAvatar(
                                            backgroundImage: AssetImage(
                                              'assets/images/profile_pic.png',
                                            ),
                                            radius: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                              width:
                                                  12, // Ukuran yang lebih besar
                                              height:
                                                  12, // Ukuran yang lebih besar
                                              child: Image.asset(
                                                'assets/images/search_icon.png',
                                                fit: BoxFit
                                                    .scaleDown, // Mengubah cara gambar ditampilkan
                                              ),
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
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
                                                style: AppTextStyle.title.copyWith(
                                                  fontSize:
                                                      20, // increased font size
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
                                        iconPath:
                                            'assets/images/ujian_icon.png',
                                      ),
                                      const SizedBox(width: 12),
                                      _statCard(
                                        title: 'Total Siswa',
                                        subtitle: 'Mengikuti Ujian',
                                        count: '109',
                                        color: const Color(0xFFFEF5E5),
                                        iconBg: const Color(0xFFFEC53D),
                                        iconPath:
                                            'assets/images/siswa_icon.png',
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),

                                _sectionHeader('Ujian Aktif'),
                                _emptyCard(
                                  message: 'Oops! Daftar Ujian Belum Tersedia',
                                  desc:
                                      'Klik "Tambah Ujian" untuk mulai membuat ujian baru.',
                                  image: 'assets/images/empty_exam.png',
                                ),
                                const SizedBox(height: 24),

                                _sectionHeader('Bank Soal'),
                                _emptyCard(
                                  message: 'Oops! Bank Soal Belum Tersedia',
                                  desc:
                                      'Klik "Tambah Bank Soal" untuk mulai membuat bank soal.',
                                  image: 'assets/images/empty_bank.png',
                                ),
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
          // Overlay dan Sidebar dengan animasi
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

          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: sidebarLeftPosition,
            top: MediaQuery.of(context).padding.top, // avoid status bar
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
