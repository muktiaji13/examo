import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../../../shared/widgets/sidebar_widget.dart';
import '../../guru/pages/edit_profile_page.dart';
import '../../guru/pages/edit_password_page.dart';
import '../../guru/pages/bantuan_page.dart';
import '../../guru/pages/syarat_ketentuan_page.dart';
import '../../../core/providers/auth_provider.dart';

class PengaturanPage extends ConsumerStatefulWidget {
  const PengaturanPage({super.key});

  @override
  ConsumerState<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends ConsumerState<PengaturanPage>
    with SingleTickerProviderStateMixin {
  String activeMenu = 'profil';
  bool isSidebarVisible = false;
  bool showLogoutConfirm = false;
  bool isLoggingOut = false;

  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation =
        Tween<Offset>(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
  }

  void toggleSidebar() => setState(() => isSidebarVisible = !isSidebarVisible);
  void closeSidebar() => setState(() => isSidebarVisible = false);
  void showLogoutDialog() {
    setState(() => showLogoutConfirm = true);
    _animationController.forward(from: 0);
  }

  void hideLogoutDialog() {
    _animationController.reverse().then((_) {
      if (mounted) setState(() => showLogoutConfirm = false);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

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
                          _buildAppBar(),
                          const SizedBox(height: 20),
                          _buildProfileCard(),
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
                activeMenu: activeMenu,
                onMenuTap: (menuKey) {
                  setState(() {
                    activeMenu = menuKey;
                    isSidebarVisible = false;
                  });
                  Navigator.pushNamed(context, '/$menuKey');
                },
                onClose: closeSidebar,
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
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 18),
                      Text(
                        'Keluar',
                        style: AppTextStyle.cardTitle.copyWith(
                          color: Color(0xFFD21F28),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Apakah Anda yakin ingin keluar dari aplikasi ini?',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.cardSubtitle.copyWith(fontSize: 15),
                      ),
                      const SizedBox(height: 28),
                      isLoggingOut
                          ? const CircularProgressIndicator()
                          : Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: hideLogoutDialog,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0x1AE74C3C),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Batal',
                                          style: AppTextStyle.button.copyWith(
                                            color: Color(0xFFD21F28),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      setState(() => isLoggingOut = true);
                                      await authNotifier.logout();
                                      setState(() => isLoggingOut = false);
                                      hideLogoutDialog();
                                      if (mounted) {
                                        Navigator.of(
                                          context,
                                        ).pushNamedAndRemoveUntil(
                                          '/login',
                                          (route) => false,
                                        );
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD21F28),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Keluar',
                                          style: AppTextStyle.button.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: toggleSidebar,
            child: Image.asset('assets/images/sidebar_icon.png', height: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundImage: AssetImage('assets/images/profile_pic2.png'),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0081FF),
                  ),
                  child: Image.asset(
                    'assets/images/pencil.png',
                    width: 14,
                    height: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Heesoo Atmaja', style: AppTextStyle.cardTitle),
            const SizedBox(height: 4),
            Text('heesoo@gmail.com', style: AppTextStyle.cardSubtitle),
            const SizedBox(height: 24),
            _buildMenuItem(
              'Edit Profil',
              'assets/images/edit_user.png',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfilePage()),
              ),
            ),
            _buildMenuItem(
              'Ubah Password',
              'assets/images/password_lock.png',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditPasswordPage()),
              ),
            ),
            _buildMenuItem(
              'Syarat dan Ketentuan',
              'assets/images/newspaper.png',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SyaratKetentuanPage()),
              ),
            ),
            _buildMenuItem('Tentang Examo', 'assets/images/about.png'),
            _buildMenuItem(
              'Bantuan',
              'assets/images/help.png',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BantuanPage()),
              ),
            ),
            GestureDetector(
              onTap: showLogoutDialog,
              child: _buildMenuItem(
                'Keluar',
                'assets/images/logout.png',
                style: AppTextStyle.menuItemDanger,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    String title,
    String iconPath, {
    TextStyle? style,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Image.asset(iconPath, width: 24, height: 24),
            const SizedBox(width: 16),
            Expanded(child: Text(title, style: style ?? AppTextStyle.menuItem)),
            Image.asset(
              'assets/images/arrow_right.png',
              width: 20,
              height: 20,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }
}
