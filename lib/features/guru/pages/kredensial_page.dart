import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../../../shared/widgets/sidebar_widget.dart';
import '../../../shared/widgets/app_header.dart';
import '../providers/kredensial_provider.dart';
import '../widgets/kredensial_widget.dart';

class KredensialPage extends ConsumerStatefulWidget {
  const KredensialPage({super.key});

  @override
  ConsumerState<KredensialPage> createState() => _KredensialPageState();
}

class _KredensialPageState extends ConsumerState<KredensialPage> {
  void onMenuTap(String menuKey) {
    ref.read(activeMenuProvider.notifier).state = menuKey;
    ref.read(sidebarVisibleProvider.notifier).state = false;
  }

  void toggleSidebar() {
    ref.read(sidebarVisibleProvider.notifier).state = 
        !ref.read(sidebarVisibleProvider);
  }

  void closeSidebar() {
    ref.read(sidebarVisibleProvider.notifier).state = false;
  }

  @override
  Widget build(BuildContext context) {
    final isSidebarVisible = ref.watch(sidebarVisibleProvider);
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
                              AppHeader(onMenuTap: toggleSidebar),
                              const SizedBox(height: 20),
                              const KredensialHeader(),
                              const SizedBox(height: 16),
                              const KredensialCard(),
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
                activeMenu: ref.watch(activeMenuProvider),
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