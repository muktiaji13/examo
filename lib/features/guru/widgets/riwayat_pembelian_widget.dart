import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import '../../../config/styles.dart';
import '../providers/riwayat_pembelian_provider.dart';
import '../pages/detail_paket_page.dart';
import '../models/detail_paket_model.dart';

class RiwayatPembelianTitle extends StatelessWidget {
  const RiwayatPembelianTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Riwayat Pembelian',
        style: AppTextStyle.title.copyWith(fontSize: 18),
      ),
    );
  }
}

class RiwayatPembelianFilter extends StatelessWidget {
  const RiwayatPembelianFilter({super.key});

  @override
  Widget build(BuildContext context) {
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
        borderRadius: BorderRadius.circular(12),
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
}

class RiwayatPembelianTable extends ConsumerWidget {
  const RiwayatPembelianTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(pembelianProvider);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFEBEBEB)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(
                const Color(0xFF0081FF),
              ),
              headingTextStyle: AppTextStyle.cardTitleWhite.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              dataTextStyle: AppTextStyle.blackSubtitle.copyWith(
                fontSize: 14,
              ),
              columns: const [
                DataColumn(label: Text('No')),
                DataColumn(label: Text('Nama Paket')),
                DataColumn(label: Text('Durasi')),
                DataColumn(label: Text('Tanggal Mulai')),
                DataColumn(label: Text('Tanggal Berakhir')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Aksi')),
              ],
              rows: data.map((item) {
                return DataRow(
                  cells: [
                    DataCell(Text(item['no'].toString())),
                    DataCell(Text(item['namaPaket'])),
                    DataCell(Text(item['durasi'])),
                    DataCell(Text(item['tglMulai'])),
                    DataCell(Text(item['tglAkhir'])),
                    DataCell(
                      Align(
                        alignment: Alignment.centerLeft,
                        child: StatusBadge(status: item['status']),
                      ),
                    ),
                    DataCell(
                      GestureDetector(
                        onTap: () {
                          final statusString = item['status'] as String;
                          SubscriptionStatus status;
                          if (statusString == 'Tuntas') {
                            status = SubscriptionStatus.active;
                          } else if (statusString == 'Pending') {
                            status = SubscriptionStatus.pending;
                          } else {
                            status = SubscriptionStatus.expired;
                          }
                          DetailPaketPage.go(context, status: status);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(
                            TablerIcons.eye_search,
                            color: Color(0xFFF8BD00),
                            size: 21,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;
  
  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(status, style: TextStyle(color: textColor, fontSize: 12)),
    );
  }
}

class RiwayatPembelianPagination extends StatelessWidget {
  const RiwayatPembelianPagination({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Row(
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
      ),
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
          style: AppTextStyle.blackSubtitle.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: active ? Colors.white : const Color(0xFFD1D1D1),
          ),
        ),
      ),
    );
  }
}