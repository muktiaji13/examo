// profile_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/sidebar_widget.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../core/providers/auth_provider.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_widget.dart';
import 'edit_profile_page.dart';
import 'edit_password_page.dart';
import 'bantuan_page.dart';
import 'syarat_ketentuan_page.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  void toggleSidebar() {
    ref.read(sidebarVisibleProvider.notifier).state = 
        !ref.read(sidebarVisibleProvider);
  }

  void closeSidebar() {
    ref.read(sidebarVisibleProvider.notifier).state = false;
  }

  void showLogoutDialog() {
    ref.read(showLogoutConfirmProvider.notifier).state = true;
    _animationController.forward(from: 0);
  }

  void hideLogoutDialog() {
    _animationController.reverse().then((_) {
      ref.read(showLogoutConfirmProvider.notifier).state = false;
    });
  }

  Future<void> handleLogout() async {
    final authNotifier = ref.read(authProvider.notifier);
    ref.read(isLoggingOutProvider.notifier).state = true;
    
    try {
      await authNotifier.logout();
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
        );
      }
    } catch (e) {
      // Handle error
    } finally {
      ref.read(isLoggingOutProvider.notifier).state = false;
      hideLogoutDialog();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSidebarVisible = ref.watch(sidebarVisibleProvider);
    final showLogoutConfirm = ref.watch(showLogoutConfirmProvider);
    final isLoggingOut = ref.watch(isLoggingOutProvider);
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 1000;
    final sidebarW = isWide ? 300.0 : 240.0;
    final sidebarX = isSidebarVisible ? 0.0 : -sidebarW;
    final leftPad = isSidebarVisible && isWide ? sidebarW : 0.0;

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
                  padding: EdgeInsets.only(left: leftPad),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AppHeader(onMenuTap: toggleSidebar),
                          const SizedBox(height: 20),
                          ProfileCard(
                            onEditProfile: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const EditProfilePage(),
                              ),
                            ),
                            onChangePassword: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const EditPasswordPage(),
                              ),
                            ),
                            onTerms: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SyaratKetentuanPage(),
                              ),
                            ),
                            onHelp: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const BantuanPage(),
                              ),
                            ),
                            onLogout: showLogoutDialog,
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Overlay
          if (isSidebarVisible && !isWide)
            GestureDetector(
              onTap: closeSidebar,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isSidebarVisible ? 1 : 0,
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          // Sidebar
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: sidebarX,
            top: MediaQuery.of(context).padding.top,
            bottom: 0,
            child: Container(
              width: sidebarW,
              color: Colors.white,
              child: SidebarWidget(
                activeMenu: ref.watch(activeMenuProvider),
                onMenuTap: (menuKey) {
                  ref.read(activeMenuProvider.notifier).state = menuKey;
                  ref.read(sidebarVisibleProvider.notifier).state = false;
                  Navigator.pushNamed(context, '/$menuKey');
                },
                onClose: closeSidebar,
                isVisible: isSidebarVisible, 
              ),
            ),
          ),
          // Logout dialog
          if (showLogoutConfirm) ...[
            GestureDetector(
              onTap: hideLogoutDialog,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: showLogoutConfirm ? 1 : 0,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SlideTransition(
                position: _slideAnimation,
                child: LogoutDialog(
                  isLoggingOut: isLoggingOut,
                  onCancel: hideLogoutDialog,
                  onConfirm: handleLogout,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}