import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../../../shared/widgets/sidebar_widget.dart';
import '../../../shared/widgets/app_header.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage>
    with SingleTickerProviderStateMixin {
  bool isSidebarOpen = false;
  late AnimationController _animationController;
  late Animation<Offset> _sidebarAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _sidebarAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  void toggleSidebar() {
    setState(() {
      isSidebarOpen = !isSidebarOpen;
      if (isSidebarOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void closeSidebar() {
    setState(() {
      isSidebarOpen = false;
      _animationController.reverse();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                AppHeader(title: 'Dashboard Siswa', onMenuTap: toggleSidebar),
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: AppLayout.maxWidth),
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          const SizedBox(height: 16),
                          _buildSearchField(),
                          const SizedBox(height: 16),
                          _buildBannerCard(),
                          const SizedBox(height: 16),
                          _buildTotalUjianCard(),
                          const SizedBox(height: 24),
                          _buildSectionHeader(),
                          const SizedBox(height: 12),
                          _buildUjianAktifCard(),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // BACKDROP GELAP
          if (isSidebarOpen)
            GestureDetector(
              onTap: closeSidebar,
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),

          // SIDEBAR ANIMASI
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return SlideTransition(
                position: _sidebarAnimation,
                child: child,
              );
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: SidebarWidget(
                activeMenu: 'dashboard',
                onMenuTap: (menu) {},
                onClose: closeSidebar,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0x26000000),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset('assets/images/search_icon.png', width: 20, height: 20),
          const SizedBox(width: 8),
          Text(
            'Telusuri',
            style: AppTextStyle.inputText.copyWith(
              color: const Color(0xFFAAAAAA),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFFFFFFF), Color(0xFFD8EFFF)],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, Sobat Examo!',
                  style: AppTextStyle.cardTitle.copyWith(
                    color: const Color(0xFF2A2A2A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Nikmati berbagai fitur menarik dan hebat dari examo. Buat ujianmu jadi gampang!',
                  style: AppTextStyle.cardSubtitle.copyWith(
                    color: const Color(0xFF2A2A2A),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Image.asset('assets/images/banner_image.png', height: 100),
        ],
      ),
    );
  }

  Widget _buildTotalUjianCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF5E5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text('25', style: AppTextStyle.cardTitle.copyWith(fontSize: 28)),
              const SizedBox(height: 8),
              Text(
                'Total Ujian',
                style: AppTextStyle.blackSubtitle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text('Yang dikerjakan Anda', style: AppTextStyle.cardSubtitle),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFFEC53D),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Image.asset('assets/images/book.png', width: 28),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Ujian Aktif', style: AppTextStyle.cardTitle),
        Text('Selengkapnya', style: AppTextStyle.link),
      ],
    );
  }

  Widget _buildUjianAktifCard() {
    return Container(
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
              child: Image.asset('assets/images/ujian_aktif.png', height: 80),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Ujian Bab Komputer In..',
                  style: AppTextStyle.blackSubtitle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE9FFF2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Aktif',
                  style: AppTextStyle.menuItem.copyWith(
                    color: const Color(0xFF2ECC71),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('25 Pertanyaan', style: AppTextStyle.cardSubtitle),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: const LinearGradient(
                colors: [AppColors.primaryBlue, Color(0xFF025BB1)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Text('Selengkapnya', style: AppTextStyle.button),
            ),
          ),
        ],
      ),
    );
  }
}