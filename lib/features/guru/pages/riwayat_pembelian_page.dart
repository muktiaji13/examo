import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../../../shared/widgets/sidebar_widget.dart';
import '../../../shared/widgets/app_header.dart';
import '../providers/riwayat_pembelian_provider.dart';
import '../widgets/riwayat_pembelian_widget.dart';

class RiwayatPembelianPage extends ConsumerWidget {
  const RiwayatPembelianPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSidebarVisible = ref.watch(sidebarVisibleProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 1000;
    final sidebarWidth = isWideScreen ? 300.0 : 240.0;
    final sidebarLeftPosition = isSidebarVisible ? 0.0 : -sidebarWidth;
    final mainContentLeftPadding = isSidebarVisible && isWideScreen
        ? sidebarWidth
        : 0.0;

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
                              AppHeader(
                                onMenuTap: () =>
                                    ref
                                        .read(sidebarVisibleProvider.notifier)
                                        .state = !ref.read(
                                      sidebarVisibleProvider,
                                    ),
                              ),
                              const SizedBox(height: 20),
                              const RiwayatPembelianTitle(),
                              const SizedBox(height: 12),
                              const RiwayatPembelianFilter(),
                              const SizedBox(height: 20),
                              const RiwayatPembelianTable(),
                              const SizedBox(height: 20),
                              const RiwayatPembelianPagination(),
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
          if (isSidebarVisible && !isWideScreen)
            GestureDetector(
              onTap: () =>
                  ref.read(sidebarVisibleProvider.notifier).state = false,
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
                activeMenu: ref.watch(activeMenuProvider),
                onMenuTap: (menuKey) {
                  ref.read(activeMenuProvider.notifier).state = menuKey;
                  ref.read(sidebarVisibleProvider.notifier).state = false;
                },
                onClose: () =>
                    ref.read(sidebarVisibleProvider.notifier).state = false,
                isVisible: isSidebarVisible,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
