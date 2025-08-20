import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../../../shared/widgets/sidebar_widget.dart';
import '../../../shared/widgets/app_header.dart';

// Provider state Riverpod
final activeMenuProvider = StateProvider<String>((ref) => 'riwayat');
final sidebarVisibleProvider = StateProvider<bool>((ref) => false);

// Dummy data pembelian
final pembelianProvider = Provider<List<Map<String, dynamic>>>((ref) {
  return List.generate(10, (index) {
    return {
      "no": index + 1,
      "namaPaket": ["Paket Pro", "Paket Premium", "Paket Basic"][index % 3],
      "durasi": "1 Bulan",
      "tglMulai": index % 2 == 0 ? "01 Mei 2025" : "01 April 2025",
      "tglAkhir": index % 2 == 0 ? "1 Juni 2025" : "1 Mei 2025",
      "status": ["Tuntas", "Pending", "Kadaluarsa"][index % 3]
    };
  });
});

class RiwayatPembelianPage extends ConsumerWidget {
  const RiwayatPembelianPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSidebarVisible = ref.watch(sidebarVisibleProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 1000;
    final sidebarWidth = isWideScreen ? 300.0 : 240.0;
    final sidebarLeftPosition = isSidebarVisible ? 0.0 : -sidebarWidth;
    final mainContentLeftPadding = isSidebarVisible && isWideScreen ? sidebarWidth : 0.0;

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
                        constraints: BoxConstraints(maxWidth: AppLayout.maxWidth),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppHeader(title: 'Riwayat Pembelian', onMenuTap: () => ref.read(sidebarVisibleProvider.notifier).state = !ref.read(sidebarVisibleProvider)),
                              const SizedBox(height: 20),
                              _buildTitle(),
                              const SizedBox(height: 12),
                              _buildFilter(),
                              const SizedBox(height: 20),
                              _buildTable(context, ref),
                              const SizedBox(height: 20),
                              _buildPagination(),
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
              onTap: () => ref.read(sidebarVisibleProvider.notifier).state = false,
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
                onClose: () => ref.read(sidebarVisibleProvider.notifier).state = false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Riwayat Pembelian',
        style: AppTextStyle.title.copyWith(fontSize: 18),
      ),
    );
  }

  Widget _buildFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _filterButton('Filter'),
          const SizedBox(width: 8),
          _filterButton('10'),
        ],
      ),
    );
  }

  Widget _filterButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Text(text, style: AppTextStyle.subtitle),
          const SizedBox(width: 8),
          Image.asset('assets/images/arrow_down.png'),
        ],
      ),
    );
  }

  Widget _buildTable(BuildContext context, WidgetRef ref) {
    final data = ref.watch(pembelianProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFEBEBEB)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3)],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(const Color(0xFF0081FF)),
            headingTextStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white,
            ),
            dataTextStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
            columns: const [
              DataColumn(label: Center(child: Text('No'))),
              DataColumn(label: Center(child: Text('Nama Paket'))),
              DataColumn(label: Center(child: Text('Durasi'))),
              DataColumn(label: Center(child: Text('Tanggal Mulai'))),
              DataColumn(label: Center(child: Text('Tanggal Berakhir'))),
              DataColumn(label: Center(child: Text('Status'))),
              DataColumn(label: Center(child: Text('Aksi'))),
            ],
            rows: data.map((item) {
              return DataRow(cells: [
                DataCell(Center(child: Text(item['no'].toString()))),
                DataCell(Center(child: Text(item['namaPaket']))),
                DataCell(Center(child: Text(item['durasi']))),
                DataCell(Center(child: Text(item['tglMulai']))),
                DataCell(Center(child: Text(item['tglAkhir']))),
                DataCell(Center(child: _statusBadge(item['status']))),
                DataCell(Center(
                  child: Icon(Icons.remove_red_eye, color: const Color(0xFFF8BD00), size: 21),
                )),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color bgColor;
    Color textColor;
    if (status == 'Tuntas') {
      bgColor = const Color(0xFFE9FFF2);
      textColor = const Color(0xFF2ECC71);
    } else if (status == 'Pending') {
      bgColor = const Color(0xFFFFF7E9);
      textColor = const Color(0xFFFFAE1F);
    } else {
      bgColor = const Color(0xFFE9E9E9);
      textColor = const Color(0xFF717171);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(6)),
      child: Text(status, style: TextStyle(color: textColor, fontSize: 12)),
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _pageButton('<', false),
        const SizedBox(width: 4),
        _pageButton('1', true),
        const SizedBox(width: 4),
        _pageButton('2', false),
        const SizedBox(width: 4),
        _pageButton('>', false),
      ],
    );
  }

  Widget _pageButton(String text, bool active) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF0081FF) : Colors.white,
        border: Border.all(color: const Color(0xFFD1D1D1)),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: active ? Colors.white : const Color(0xFFD1D1D1),
          ),
        ),
      ),
    );
  }
}