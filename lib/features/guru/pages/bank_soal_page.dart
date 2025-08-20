import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../../../shared/widgets/sidebar_widget.dart';
import 'bank_soal_detail_page.dart';

class BankSoalItem {
  final String id;
  final String title;
  final String subtitle;
  final DateTime createdAt;

  const BankSoalItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.createdAt,
  });
}

class BankSoalState {
  final List<BankSoalItem> all;
  final String query;
  final String sort;

  const BankSoalState({
    required this.all,
    this.query = '',
    this.sort = 'Terbaru',
  });

  BankSoalState copyWith({
    List<BankSoalItem>? all,
    String? query,
    String? sort,
  }) {
    return BankSoalState(
      all: all ?? this.all,
      query: query ?? this.query,
      sort: sort ?? this.sort,
    );
  }

  List<BankSoalItem> get filtered {
    final q = query.toLowerCase();
    var list = all.where((e) {
      if (q.isEmpty) return true;
      return e.title.toLowerCase().contains(q) ||
          e.subtitle.toLowerCase().contains(q);
    }).toList();

    list.sort((a, b) {
      if (sort == 'Terbaru') {
        return b.createdAt.compareTo(a.createdAt);
      }
      return a.createdAt.compareTo(b.createdAt);
    });

    return list;
  }
}

class BankSoalNotifier extends StateNotifier<BankSoalState> {
  BankSoalNotifier() : super(BankSoalState(all: _dummy));

  static final List<BankSoalItem> _dummy = [
    BankSoalItem(
      id: '1',
      title: 'Informatika Komputer d..',
      subtitle: 'Sistem operasi dan sistem kom..',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    BankSoalItem(
      id: '2',
      title: 'Informatika Komputer d..',
      subtitle: 'Sistem operasi dan sistem kom..',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    BankSoalItem(
      id: '3',
      title: 'Informatika Komputer d..',
      subtitle: 'Sistem operasi dan sistem kom..',
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
    ),
  ];

  void setQuery(String q) {
    state = state.copyWith(query: q);
  }

  void setSort(String s) {
    state = state.copyWith(sort: s);
  }

  void addDummy() {
    final now = DateTime.now();
    final newItem = BankSoalItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Informatika Komputer d..',
      subtitle: 'Sistem operasi dan sistem kom..',
      createdAt: now,
    );
    state = state.copyWith(all: [newItem, ...state.all]);
  }

  void remove(String id) {
    state = state.copyWith(all: state.all.where((e) => e.id != id).toList());
  }
}

final bankSoalProvider = StateNotifierProvider<BankSoalNotifier, BankSoalState>(
  (ref) => BankSoalNotifier(),
);

class BankSoalPage extends ConsumerStatefulWidget {
  const BankSoalPage({super.key});

  @override
  ConsumerState<BankSoalPage> createState() => _BankSoalPageState();
}

class _BankSoalPageState extends ConsumerState<BankSoalPage> with TickerProviderStateMixin {
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
                        Container(
                          height: 100,
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: toggleSidebar,
                                child: Image.asset(
                                  'assets/images/sidebar_icon.png',
                                  height: 32,
                                  width: 32,
                                ),
                              ),
                              const Spacer(),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Image.asset(
                                  'assets/images/profile_pic.png',
                                  height: 32,
                                  width: 32,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 37,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: AppColors.white,
                                              hintText: 'Telusuri',
                                              hintStyle: AppTextStyle.inputText,
                                              prefixIcon: Padding(
                                                padding: const EdgeInsets.all(
                                                  10,
                                                ),
                                                child: Image.asset(
                                                  'assets/images/search_icon.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                borderSide: BorderSide.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Container(
                                        height: 37,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              state.sort,
                                              style: AppTextStyle.inputText
                                            ),
                                            const SizedBox(width: 4),
                                            Image.asset(
                                              'assets/images/arrow_down.png',
                                              width: 16,
                                              height: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 44,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF4D55CC),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/download_icon.png',
                                                width: 22,
                                                height: 22,
                                              ),
                                              const SizedBox(width: 8),
                                              const Text(
                                                'Template',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: InkWell(
                                          onTap: notifier.addDummy,
                                          child: Container(
                                            height: 44,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF0081FF),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/plus.png',
                                                  width: 22,
                                                  height: 22,
                                                ),
                                                const SizedBox(width: 8),
                                                const Text(
                                                  'Bank Soal',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Column(
                                    children: state.filtered
                                        .map(
                                          (e) => Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 16,
                                            ),
                                            child: LayoutBuilder(
                                              builder: (context, constraints) {
                                                return _BankSoalCard(
                                                  item: e,
                                                  onDelete: () =>
                                                      notifier.remove(e.id),
                                                  width: constraints.maxWidth,
                                                  onShowDeleteNotif: () => showDeleteNotification(e),
                                                );
                                              },
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
                      child: Container(
                        width: 300,
                        height: 280,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 16,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEAEB),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/warning-icon.png',
                                  width: 32,
                                  height: 32,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: 189,
                              child: Text(
                                'Hapus bank soal ini?',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.cardTitle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: 248,
                              child: Text(
                                'File ini akan dihapus secara permanen dan tidak dapat dipulihkan',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.cardSubtitle.copyWith(
                                  fontSize: 13,
                                  color: AppColors.textGrey2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 90,
                                  height: 36,
                                  child: TextButton(
                                    onPressed: hideDeleteNotification,
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xFFF5F5F5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      'Tidak',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: AppColors.textGrey2,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                SizedBox(
                                  width: 116,
                                  height: 36,
                                  child: ElevatedButton(
                                    onPressed: confirmDelete,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.dangerRed,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      'Ya, Hapus',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.white,
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
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _BankSoalCard extends StatelessWidget {
  final BankSoalItem item;
  final VoidCallback onDelete;
  final double? width;
  final VoidCallback? onShowDeleteNotif;

  const _BankSoalCard({
    required this.item,
    required this.onDelete,
    this.width,
    this.onShowDeleteNotif,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEBEBEB)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F3FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/bank_soal.png',
                width: 52,
                height: 52,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            item.title,
            style: AppTextStyle.cardTitle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.subtitle,
            style: AppTextStyle.cardSubtitle.copyWith(
              fontSize: 14,
              color: const Color(0xFF5E5E5E),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const BankSoalDetailPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0081FF), Color(0xFF025BB1)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        'Detail',
                        style: AppTextStyle.button.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: onShowDeleteNotif, // ubah ke trigger notifikasi
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEAEB),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Image.asset(
                    'assets/images/trash.png',
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}