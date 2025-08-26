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
        Navigator.of(context).pushReplacementNamed(
          role == 'guru' ? '/dashboard' : '/dashboard-siswa',
        );
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
        Navigator.of(context).pushReplacementNamed(
          role == 'guru' ? '/dashboard' : '/dashboard-siswa',
        );
    }
  }

  static const double _subItemHeight = 32;
  static const double _subItemSpacing = 8;
  static const double _leftColumnWidth = 45;
  static const double _subItemButtonWidth = 140;

  Widget buildMenuItem({
    required String label,
    required String menuKey,
    bool isAsset = false,
    String? iconPath,
    String? activeIconPath,
    IconData? icon,
    IconData? activeIcon,
    bool showDot = false,
  }) {
    final isActive = widget.activeMenu == menuKey;

    if (showDot) {
      return InkWell(
        onTap: () => _navigateTo(menuKey),
        child: SizedBox(
          height: _subItemHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // left column: dashed line + dot ditumpuk biar nempel
              SizedBox(
                width: _leftColumnWidth,
                height: _subItemHeight,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // garis putus-putus (vertikal)
                    Positioned.fill(
                      child: CustomPaint(
                        painter: DashedLinePainter(
                          color: const Color(0xFFD9D9D9),
                          strokeWidth: 2,
                          dashWidth: 5,
                          dashSpace: 5,
                          vertical: true,
                        ),
                      ),
                    ),
                    // dot tepat di tengah garis
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),

              // konten (teks + background aktif) sesuai dimensi tombol
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => _navigateTo(menuKey),
                child: Container(
                  width: _subItemButtonWidth,
                  height: _subItemHeight,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10), // teks left:10
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primaryBlue
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    label,
                    style: AppTextStyle.subtitle.copyWith(
                      color: isActive ? AppColors.white : AppColors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // default regular menu item (icon + label)
    return InkWell(
      onTap: () => _navigateTo(menuKey),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: widget.activeMenu == menuKey
              ? AppColors.primaryBlue
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            if (isAsset && iconPath != null)
              Image.asset(
                widget.activeMenu == menuKey
                    ? (activeIconPath ?? iconPath)
                    : iconPath,
                width: 20,
                height: 20,
              )
            else if (icon != null)
              Icon(
                widget.activeMenu == menuKey ? (activeIcon ?? icon) : icon,
                size: 20,
                color: widget.activeMenu == menuKey
                    ? AppColors.white
                    : AppColors.black,
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: AppTextStyle.subtitle.copyWith(
                  color: widget.activeMenu == menuKey
                      ? AppColors.white
                      : AppColors.black,
                ),
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
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return SizeTransition(
              sizeFactor: animation,
              axisAlignment: -1.0,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: expanded
              ? Padding(
                  key: const ValueKey(true),
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < children.length; i++) ...[
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: i == children.length - 1
                                      ? 0
                                      : _subItemSpacing,
                                ),
                                child: children[i],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(key: ValueKey(false)),
        ),
      ],
    );
  }

  Widget buildDashedDividerHorizontal() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CustomPaint(
        size: const Size(151, 1),
        painter: DashedLinePainter(
          color: const Color(0xFFD5D5D5),
          strokeWidth: 1,
          dashWidth: 5,
          dashSpace: 5,
          vertical: false,
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
              const SizedBox(height: 16),
              buildDashedDividerHorizontal(),
              const SizedBox(height: 16),
              Text('Sistem', style: AppTextStyle.subtitle),
              const SizedBox(height: 12),
              if (role == 'guru')
                buildExpandableSection(
                  label: 'Langganan',
                  iconPath: 'assets/sidebar-icon/langganan-hitam.png',
                  expanded: isLanggananExpanded,
                  onToggle: () => setState(
                    () => isLanggananExpanded = !isLanggananExpanded,
                  ),
                  children: [
                    buildMenuItem(
                      label: 'Paket',
                      menuKey: 'paket',
                      showDot: true,
                    ),
                    buildMenuItem(
                      label: 'Riwayat',
                      menuKey: 'riwayat',
                      showDot: true,
                    ),
                  ],
                ),
              if (role == 'guru')
                buildExpandableSection(
                  label: 'Pengaturan',
                  iconPath: 'assets/sidebar-icon/pengaturan-hitam.png',
                  expanded: isPengaturanExpanded,
                  onToggle: () => setState(
                    () => isPengaturanExpanded = !isPengaturanExpanded,
                  ),
                  children: [
                    buildMenuItem(
                      label: 'Kredensial',
                      menuKey: 'kredensial',
                      showDot: true,
                    ),
                    buildMenuItem(
                      label: 'Profil',
                      menuKey: 'profil',
                      showDot: true,
                    ),
                  ],
                ),
              if (role != 'guru')
                buildMenuItem(
                  label: 'Pengaturan',
                  menuKey: 'pengaturan',
                  isAsset: true,
                  iconPath: 'assets/sidebar-icon/pengaturan-hitam.png',
                  activeIconPath: 'assets/sidebar-icon/pengaturan-putih.png',
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final bool vertical;

  DashedLinePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    this.vertical = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    double start = 0;
    final length = vertical ? size.height : size.width;

    if (vertical) {
      final x = size.width / 2;
      while (start < length) {
        final end = (start + dashWidth).clamp(0.0, length);
        canvas.drawLine(Offset(x, start), Offset(x, end), paint);
        start += dashWidth + dashSpace;
      }
    } else {
      final y = size.height / 2;
      while (start < length) {
        final end = (start + dashWidth).clamp(0.0, length);
        canvas.drawLine(Offset(start, y), Offset(end, y), paint);
        start += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
