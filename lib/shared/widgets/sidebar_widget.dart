import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/styles.dart';
import '../../core/providers/auth_provider.dart';

class SidebarWidget extends ConsumerStatefulWidget {
  final String activeMenu;
  final Function(String) onMenuTap;
  final VoidCallback onClose;

  const SidebarWidget({
    super.key,
    required this.activeMenu,
    required this.onMenuTap,
    required this.onClose,
  });

  @override
  ConsumerState<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends ConsumerState<SidebarWidget> {
  bool isLanggananExpanded = true;
  bool isPengaturanExpanded = true;

  Future<void> _navigateTo(String menuKey) async {
    widget.onMenuTap(menuKey);
    widget.onClose();

    final auth = ref.read(authProvider);
    final role = auth.role ?? 'user';

    switch (menuKey) {
      case 'dashboard':
        if (role == 'guru') {
          Navigator.of(context).pushReplacementNamed('/dashboard');
        } else {
          Navigator.of(context).pushReplacementNamed('/dashboard-siswa');
        }
        break;
      case 'pengaturan':
        Navigator.of(context).pushNamed('/pengaturan');
        break;
      case 'daftar_ujian':
        Navigator.of(context).pushNamed('/daftar_ujian');
        break;
      case 'bank_soal':
        if (role == 'guru') Navigator.of(context).pushNamed('/bank_soal');
        break;
      case 'paket':
        if (role == 'guru') Navigator.of(context).pushNamed('/paket');
        break;
      case 'riwayat':
        if (role == 'guru') Navigator.of(context).pushNamed('/riwayat');
        break;
      case 'kredensial':
        if (role == 'guru') Navigator.of(context).pushNamed('/kredensial');
        break;
      case 'profil':
        if (role == 'guru') Navigator.of(context).pushNamed('/profil');
        break;
      default:
        if (role == 'guru') {
          Navigator.of(context).pushReplacementNamed('/dashboard');
        } else {
          Navigator.of(context).pushReplacementNamed('/dashboard-siswa');
        }
    }
  }

  Widget buildMenuItem({
    required String label,
    required String menuKey,
    required bool isAsset,
    String? iconPath,
    String? activeIconPath,
    IconData? icon,
    IconData? activeIcon,
  }) {
    final isActive = widget.activeMenu == menuKey;
    final color = isActive ? AppColors.white : AppColors.black;

    return InkWell(
      onTap: () => _navigateTo(menuKey),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            if (isAsset && iconPath != null)
              Image.asset(
                isActive ? (activeIconPath ?? iconPath) : iconPath,
                width: 20,
                height: 20,
              )
            else if (icon != null)
              Icon(
                isActive ? (activeIcon ?? icon) : icon,
                size: 20,
                color: color,
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: AppTextStyle.subtitle.copyWith(color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExpandableSection({
    required String label,
    required String iconPath,
    required bool expanded,
    required VoidCallback onToggle,
    required List<Widget> children,
  }) {
    final isActive = widget.activeMenu == label.toLowerCase();
    final color = isActive ? AppColors.white : AppColors.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onToggle,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primaryBlue : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(iconPath, width: 20, color: color),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyle.subtitle.copyWith(color: color),
                  ),
                ),
                AnimatedRotation(
                  turns: expanded ? 0 : 0.5,
                  duration: const Duration(milliseconds: 300),
                  child: Image.asset(
                    'assets/sidebar-icon/arrow-up.png',
                    width: 16,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (expanded)
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 8),
            child: Column(children: children),
          ),
      ],
    );
  }

  Widget buildDashedDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 1,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFD5D5D5).withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildPengaturanSection(String role) {
    final isActive = widget.activeMenu == 'pengaturan';

    return InkWell(
      onTap: () {
        _navigateTo('pengaturan');
        if (role == 'guru') {
          setState(() {
            isPengaturanExpanded = !isPengaturanExpanded;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset(
              isActive
                  ? 'assets/sidebar-icon/pengaturan-putih.png'
                  : 'assets/sidebar-icon/pengaturan-hitam.png',
              width: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Pengaturan',
                style: AppTextStyle.subtitle.copyWith(
                  color: isActive ? AppColors.white : AppColors.black,
                ),
              ),
            ),
            if (role == 'guru')
              AnimatedRotation(
                turns: isPengaturanExpanded ? 0 : 0.5,
                duration: const Duration(milliseconds: 300),
                child: Image.asset(
                  'assets/sidebar-icon/arrow-up.png',
                  width: 16,
                  color: isActive ? AppColors.white : AppColors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final role = auth.role ?? 'user';

    return SafeArea(
      child: Container(
        width: role == 'guru' ? 220 : 190,
        height: double.infinity,
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Examo',
                style: AppTextStyle.blueTitle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text('Fitur Examo', style: AppTextStyle.subtitle),
              const SizedBox(height: 12),
              buildMenuItem(
                label: 'Dashboard',
                menuKey: 'dashboard',
                isAsset: true,
                iconPath: 'assets/sidebar-icon/dashboard-hitam.png',
                activeIconPath: 'assets/sidebar-icon/dashboard-putih.png',
              ),
              buildMenuItem(
                label: 'Daftar Ujian',
                menuKey: 'daftar_ujian',
                isAsset: true,
                iconPath: 'assets/sidebar-icon/daftar-ujian-hitam.png',
                activeIconPath: 'assets/sidebar-icon/daftar-ujian-putih.png',
              ),
              if (role == 'guru')
                buildMenuItem(
                  label: 'Bank Soal',
                  menuKey: 'bank_soal',
                  isAsset: true,
                  iconPath: 'assets/sidebar-icon/bank-soal-hitam.png',
                  activeIconPath: 'assets/sidebar-icon/bank-soal-putih.png',
                ),
              buildDashedDivider(),
              Text('Sistem', style: AppTextStyle.subtitle),
              const SizedBox(height: 12),
              if (role == 'guru')
                buildExpandableSection(
                  label: 'Langganan',
                  iconPath: 'assets/sidebar-icon/langganan-hitam.png',
                  expanded: isLanggananExpanded,
                  onToggle: () => setState(() {
                    isLanggananExpanded = !isLanggananExpanded;
                  }),
                  children: [
                    buildMenuItem(
                      label: 'Paket',
                      menuKey: 'paket',
                      isAsset: false,
                    ),
                    buildMenuItem(
                      label: 'Riwayat',
                      menuKey: 'riwayat',
                      isAsset: false,
                    ),
                  ],
                ),
              if (role == 'guru') ...[
                _buildPengaturanSection(role),
                if (isPengaturanExpanded)
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Column(
                      children: [
                        buildMenuItem(
                          label: 'Kredensial',
                          menuKey: 'kredensial',
                          isAsset: false,
                        ),
                        buildMenuItem(
                          label: 'Profil',
                          menuKey: 'profil',
                          isAsset: false,
                        ),
                      ],
                    ),
                  ),
              ] else ...[
                buildMenuItem(
                  label: 'Pengaturan',
                  menuKey: 'pengaturan',
                  isAsset: true,
                  iconPath: 'assets/sidebar-icon/pengaturan-hitam.png',
                  activeIconPath: 'assets/sidebar-icon/pengaturan-putih.png',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}