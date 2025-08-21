// daftar_paket_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../../../shared/widgets/sidebar_widget.dart';
import '../../../shared/widgets/app_header.dart';

/// Model Paket
class Paket {
  final String id;
  final String nama;
  final String subtitle;
  final bool isActive;
  final Color adminColor;
  final int harga;
  final Map<String, bool> fitur;

  Paket({
    required this.id,
    required this.nama,
    required this.subtitle,
    required this.isActive,
    required this.adminColor,
    required this.harga,
    required this.fitur,
  });
}

/// Provider list paket dummy. Bisa diganti nanti dari API.
final paketListProvider = Provider<List<Paket>>((ref) {
  return [
    // Paket nonaktif
    Paket(
      id: 'paket_1',
      nama: 'Paket Basic',
      subtitle: 'Untuk pengguna aktif',
      isActive: false,
      adminColor: const Color(0xFFD234E0),
      harga: 50000,
      fitur: {
        'Ujian tak terbatas': false,
        'Akses ke semua bank soal': false,
        'Tanpa iklan': false,
      },
    ),

    // Paket aktif (contoh warna admin #D234E0)
    Paket(
      id: 'paket_2',
      nama: 'Paket Basic',
      subtitle: 'Untuk pengguna aktif',
      isActive: true,
      adminColor: const Color(0xFFD234E0),
      harga: 50000,
      fitur: {
        'Ujian tak terbatas': false,
        'Akses ke semua bank soal': false,
        'Tanpa iklan': false,
      },
    ),
  ];
});

class DaftarPaketPage extends ConsumerStatefulWidget {
  const DaftarPaketPage({super.key});

  @override
  ConsumerState<DaftarPaketPage> createState() => _DaftarPaketPageState();
}

class _DaftarPaketPageState extends ConsumerState<DaftarPaketPage> {
  String activeMenu = 'paket';
  bool isSidebarVisible = false;

  void onMenuTap(String menuKey) {
    setState(() {
      activeMenu = menuKey;
      isSidebarVisible = false;
    });
    // ignore: avoid_print
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
    final paketList = ref.watch(paketListProvider);

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
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppHeader(),

                              // Judul
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Paket Langganan',
                                      style: AppTextStyle.title.copyWith(
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Pilih Paket Langganan Sesuai Kebutuhan!',
                                      style: AppTextStyle.blackSubtitle,
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),

                              // List paket
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Column(
                                  children: paketList
                                      .map(
                                        (p) => Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 20,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width:
                                                    343, // ukuran card yang lo mau
                                                child: PaketCard(
                                                  paket: p,
                                                  onSubscribe: () {
                                                    print(
                                                      'Langganan ditekan ${p.id}',
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              const SizedBox(height: 40),
                            ],
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
}

/// Widget kartu paket agar reusable
class PaketCard extends StatelessWidget {
  final Paket paket;
  final VoidCallback onSubscribe;

  const PaketCard({super.key, required this.paket, required this.onSubscribe});

  @override
  Widget build(BuildContext context) {
    final Color topColor = paket.isActive
        ? paket.adminColor
        : const Color(0xFF717171);

    final Color badgeBg = paket.isActive
        ? const Color(0xFFE9FFF2)
        : const Color(0xFFFFEAEB);
    final Color badgeText = paket.isActive
        ? const Color(0xFF2ECC71)
        : const Color(0xFFD21F28);

    final Color buttonBg = paket.isActive
        ? const Color(0xFF0081FF)
        : const Color(0xFFD9D9D9);

    return SizedBox(
      width: 343,
      height: 355,
      child: Stack(
        children: [
          // Card utama
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x11000000),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul paket
                  Text(
                    paket.nama,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      height: 1,
                      color: Color(0xFF000000),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    paket.subtitle,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1,
                      color: Color(0xFF575757),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Badge status
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: badgeBg,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      paket.isActive ? 'Aktif' : 'Nonaktif',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: badgeText,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Harga
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Rp.${_formatHarga(paket.harga)}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          height: 1,
                          color: Color(0xFF000000),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Text(
                          '/bulan',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: Color(0xFF2D2D2D),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Fitur utama label
                  const Text(
                    'Fitur Utama :',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      height: 1.125,
                      color: Color(0xFF000000),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // List fitur
                  ...paket.fitur.entries.map((e) {
                    final Color tickColor = e.value
                        ? const Color(0xFF0081FF)
                        : const Color(0xFFD9D9D9);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, size: 18, color: tickColor),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              e.key,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                height: 1.5,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  const Spacer(),

                  // Tombol langganan
                  GestureDetector(
                    onTap: paket.isActive ? onSubscribe : null,
                    child: Container(
                      width: double.infinity,
                      height: 35,
                      decoration: BoxDecoration(
                        color: buttonBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Langganan',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Top color bar (menjadi border atas berwarna)
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: topColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatHarga(int harga) {
    final s = harga.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      buffer.write(s[i]);
      count++;
      if (count == 3 && i != 0) {
        buffer.write('.');
        count = 0;
      }
    }
    return buffer.toString().split('').reversed.join();
  }
}
