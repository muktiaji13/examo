import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/sidebar_widget.dart';
import '../providers/daftar_ujian_provider.dart';
import '../widgets/daftar_ujian_widget.dart';
import 'tambah_ujian_page.dart';

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
    final double mainContentLeftPadding = isSidebarVisible && isWideScreen
        ? sidebarWidth
        : 0;
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
                        constraints: BoxConstraints(
                          maxWidth: AppLayout.maxWidth,
                        ),
                        child: Container(
                          color: const Color(0xFFF5F5F5),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppHeader(onMenuTap: toggleSidebar),
                                const SizedBox(height: 20),
                                // Title
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    'Pilih Ujian',
                                    style: AppTextStyle.title.copyWith(fontSize: 18),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                // Telusuri
                                const DaftarUjianSearchBar(),
                                const SizedBox(height: 12),
                                // Tambah Ujian + Filter
                                DaftarUjianActionButtons(
                                  onTambahUjian: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const TambahUjianPage(),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 32),
                                // List ujian
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    children: ujianList
                                        .map(
                                          (item) => DaftarUjianCard(
                                            item: item,
                                            onDetailTap: () {
                                              // Aksi ketika klik detail
                                            },
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
                isVisible: isSidebarVisible, 
              ),
            ),
          ),
        ],
      ),
    );
  }
}