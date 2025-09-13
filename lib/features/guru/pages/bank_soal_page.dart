import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../../../shared/widgets/sidebar_widget.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/common_item.dart';
import '../models/bank_soal_model.dart';
import '../providers/bank_soal_provider.dart';
import '../widgets/bank_soal_widget.dart';
import 'bank_soal_detail_page.dart';

class BankSoalPage extends ConsumerStatefulWidget {
  const BankSoalPage({super.key});

  @override
  ConsumerState<BankSoalPage> createState() => _BankSoalPageState();
}

class _BankSoalPageState extends ConsumerState<BankSoalPage>
    with TickerProviderStateMixin {
  String activeMenu = 'bank_soal';
  bool isSidebarVisible = false;

  // Notif state
  bool showDeleteNotif = false;
  BankSoalItem? pendingDeleteItem;
  late AnimationController _notifAnimController;
  late Animation<double> _notifScaleAnim;

  @override
  void initState() {
    super.initState();
    _notifAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _notifScaleAnim = CurvedAnimation(
      parent: _notifAnimController,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeInBack,
    );
  }

  @override
  void dispose() {
    _notifAnimController.dispose();
    super.dispose();
  }

  void showDeleteNotification(BankSoalItem item) {
    setState(() {
      pendingDeleteItem = item;
      showDeleteNotif = true;
    });
    _notifAnimController.forward(from: 0);
  }

  void hideDeleteNotification() {
    _notifAnimController.reverse().then((_) {
      if (mounted) setState(() => showDeleteNotif = false);
    });
  }

  void confirmDelete() {
    final notifier = ref.read(bankSoalProvider.notifier);
    if (pendingDeleteItem != null) {
      notifier.remove(pendingDeleteItem!.id);
    }
    hideDeleteNotification();
  }

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

  void goToDetailPage() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const BankSoalDetailPage()));
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
    final state = ref.watch(bankSoalProvider);
    final notifier = ref.read(bankSoalProvider.notifier);

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
                    child: Column(
                      children: [
                        AppHeader(onMenuTap: toggleSidebar),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Text(
                                    'Bank Soal',
                                    style: AppTextStyle.title.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: SearchBarWidget(
                                          onChanged: notifier.setQuery,
                                          padding: EdgeInsets
                                              .zero,
                                          showSpacing:
                                              false,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      SizedBox(
                                        height: 40,
                                        child: BankSoalSortDropdown(
                                          currentValue: state.sort,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),
                                  BankSoalActionButtons(
                                    onTemplateTap: () {},
                                    onAddBankSoalTap: notifier.addDummy,
                                  ),
                                  const SizedBox(height: 24),
                                  Column(
                                    children: state.filtered
                                        .map(
                                          (e) => Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 16,
                                            ),
                                            child: BankSoalCard(
                                              item: e,
                                              onDelete: () =>
                                                  notifier.remove(e.id),
                                              onShowDeleteNotif: () =>
                                                  showDeleteNotification(e),
                                              onDetail: goToDetailPage,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  const SizedBox(height: 40),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
          // Notifikasi hapus
          if (showDeleteNotif)
            Positioned.fill(
              child: GestureDetector(
                onTap: hideDeleteNotification,
                child: Container(
                  color: Colors.black.withOpacity(0.35),
                  child: Center(
                    child: ScaleTransition(
                      scale: _notifScaleAnim,
                      child: BankSoalDeleteNotification(
                        onConfirm: confirmDelete,
                        onCancel: hideDeleteNotification,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
