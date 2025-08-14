import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../../../shared/widgets/sidebar_widget.dart';

// Provider dummy data
final ujianProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {
      'title': 'Ujian Bab Komputer In..',
      'status': 'Aktif',
      'questions': '25 Pertanyaan',
      'image': 'assets/images/ujian_aktif.png'
    },
    {
      'title': 'Ujian Bab Komputer In..',
      'status': 'Berlangsung',
      'questions': '25 Pertanyaan',
      'image': 'assets/images/no-image.png'
    },
    {
      'title': 'Ujian Bab Komputer In..',
      'status': 'Nonaktif',
      'questions': '25 Pertanyaan',
      'image': 'assets/images/ujian_aktif.png'
    },
  ];
});

class DaftarUjianPage extends ConsumerStatefulWidget {
  const DaftarUjianPage({super.key});

  @override
  ConsumerState<DaftarUjianPage> createState() => _DaftarUjianPageState();
}

class _DaftarUjianPageState extends ConsumerState<DaftarUjianPage> {
  String activeMenu = 'daftar_ujian';
  bool isSidebarVisible = false;

  void onMenuTap(String menuKey) {
    setState(() {
      activeMenu = menuKey;
      isSidebarVisible = false;
    });
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
    final double mainContentLeftPadding =
        isSidebarVisible && isWideScreen ? sidebarWidth : 0;

    final ujianList = ref.watch(ujianProvider);

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
                        constraints:
                            BoxConstraints(maxWidth: AppLayout.maxWidth),
                        child: Container(
                          color: const Color(0xFFF5F5F5),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // AppBar
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
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
                                        Image.asset(
                                          'assets/images/notif_icon.png',
                                          height: 24,
                                          width: 24,
                                        ),
                                        const SizedBox(width: 16),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          child: Image.asset(
                                            'assets/images/profile_pic.png',
                                            height: 32,
                                            width: 32,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Title
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    'Pilih Ujian',
                                    style: AppTextStyle.title
                                        .copyWith(fontSize: 18),
                                  ),
                                ),
                                const SizedBox(height: 12),

                                // Telusuri
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xFFFFFFFF),
                                      hintText: 'Telusuri',
                                      hintStyle: AppTextStyle.inputText,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.asset(
                                          'assets/images/search_icon.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),

                                // Tambah Ujian + Filter
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.roleButtonSelected,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              'assets/images/plus.png',
                                              width: 16,
                                              height: 16,
                                            ),
                                            const SizedBox(width: 8),
                                            Text('Tambah Ujian',
                                                style: AppTextStyle.button),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          children: [
                                            Text('Filter',
                                                style:
                                                    AppTextStyle.inputText),
                                            const SizedBox(width: 4),
                                            Image.asset(
                                              'assets/images/arrow_down.png',
                                              height: 16,
                                              width: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 32),

                                // List ujian
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    children: ujianList
                                        .map((item) =>
                                            _buildUjianCard(context, item))
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
              ),
            ],
          ),

          // Overlay
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

  Widget _buildUjianCard(BuildContext context, Map<String, String> item) {
    Color badgeColor;
    Color textColor;
    Color? buttonTop;
    Color? buttonBottom;
    bool isDisabled = false;

    switch (item['status']) {
      case 'Aktif':
        badgeColor = const Color(0xFFE9FFF2);
        textColor = const Color(0xFF2ECC71);
        buttonTop = AppColors.primaryBlue;
        buttonBottom = const Color(0xFF025BB1);
        break;
      case 'Berlangsung':
        badgeColor = const Color(0xFFFFF9E5);
        textColor = const Color(0xFFF8BD00);
        buttonTop = AppColors.primaryBlue;
        buttonBottom = const Color(0xFF025BB1);
        break;
      default:
        badgeColor = const Color(0xFFFFEAEB);
        textColor = const Color(0xFFD21F28);
        isDisabled = true;
        break;
    }

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
                child: Image.asset(item['image']!, height: 80),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(item['title']!,
                      style: AppTextStyle.blackSubtitle
                          .copyWith(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(item['status']!,
                      style: AppTextStyle.menuItem.copyWith(
                          color: textColor, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(item['questions']!,
                  style: AppTextStyle.cardSubtitle),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: isDisabled
                        ? null
                        : () {
                            // Aksi ketika klik
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: isDisabled
                            ? null
                            : LinearGradient(
                                colors: [buttonTop!, buttonBottom!],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                        color: isDisabled
                            ? const Color(0xFFDADADA)
                            : null,
                      ),
                      child: Center(
                        child: Text('Selengkapnya',
                            style: AppTextStyle.button),
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
                    child:
                        Image.asset('assets/images/trash.png', height: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
