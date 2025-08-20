import 'package:flutter/material.dart';
import '../../../config/styles.dart';
import '../../../shared/widgets/sidebar_widget.dart';
import '../../../shared/widgets/app_header.dart';

class KredensialPage extends StatefulWidget {
  const KredensialPage({super.key});

  @override
  State<KredensialPage> createState() => _KredensialPageState();
}

class _KredensialPageState extends State<KredensialPage> {
  String activeMenu = 'kredensial';
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
                              AppHeader(title: 'Kredensial', onMenuTap: toggleSidebar),
                              const SizedBox(height: 20),

                              // Title
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Text(
                                  'Kredensial',
                                  style: AppTextStyle.title.copyWith(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Card Konten
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Examo',
                                        style: AppTextStyle.title.copyWith(
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Examo menyediakan kunci API untuk integrasi pembayaran online dan menawarkan template yang mudah digunakan dan antarmuka yang dapat disesuaikan sehingga mudah diimplementasikan.',
                                        style: AppTextStyle.subtitle,
                                      ),
                                      const SizedBox(height: 20),

                                      Divider(
                                        height: 1,
                                        color: Colors.grey.shade300,
                                      ),
                                      const SizedBox(height: 16),

                                      Text(
                                        'API Keys',
                                        style: AppTextStyle.cardTitle,
                                      ),
                                      const SizedBox(height: 12),

                                      // Teacher ID
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(12),
                                        margin: const EdgeInsets.only(
                                          bottom: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFECF7FF),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Teacher ID  :  ',
                                              style: AppTextStyle.cardTitle,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Exam60',
                                                style:
                                                    AppTextStyle.cardSubtitle,
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/copy_icon.png',
                                              height: 20,
                                              width: 20,
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Teacher Key
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFECF7FF),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Teacher Key :  ',
                                              style: AppTextStyle.cardTitle,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'bulVfe8wyf0qZI',
                                                style:
                                                    AppTextStyle.cardSubtitle,
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/copy_icon.png',
                                              height: 20,
                                              width: 20,
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 20),

                                      // Warning Box
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFE6E6),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              'assets/images/danger.png',
                                              height: 24,
                                              width: 24,
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Text.rich(
                                                TextSpan(
                                                  text:
                                                      'Kunci ini dibuat secara otomatis oleh sistem dan tidak boleh diubah. Jika Anda benar-benar perlu mengubah kunci karena suatu alasan, silakan ',
                                                  style: AppTextStyle
                                                      .blackSubtitle,
                                                  children: [
                                                    TextSpan(
                                                      text: 'Hubungi Kami.',
                                                      style: AppTextStyle.link,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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