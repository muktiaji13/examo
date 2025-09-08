import '../models/detail_paket_model.dart';
import 'package:flutter/material.dart';
import '../../../config/styles.dart';
import '../models/daftar_paket_model.dart';
import '../pages/detail_paket_page.dart';

class PaketCard extends StatelessWidget {
  final Paket paket;
  final VoidCallback onSubscribe;

  const PaketCard({
    super.key,
    required this.paket,
    required this.onSubscribe,
  });

  @override
  Widget build(BuildContext context) {
    final Color topColor = paket.isActive ? paket.adminColor : const Color(0xFF717171);
    final Color badgeBg = paket.isActive ? const Color(0xFFE9FFF2) : const Color(0xFFFFEAEB);
    final Color badgeText = paket.isActive ? const Color(0xFF2ECC71) : const Color(0xFFD21F28);
    final Color buttonBg = paket.isActive ? const Color(0xFF0081FF) : const Color(0xFFD9D9D9);

    return SizedBox(
      width: 343,
      height: 355,
      child: Stack(
        children: [
          // Card utama
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x11000000),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul paket
                  Text(
                    paket.nama,
                    style: AppTextStyle.cardTitle,
                  ),
                  const SizedBox(height: 8),
                  // Subtitle
                  Text(
                    paket.subtitle,
                    style: AppTextStyle.cardSubtitle,
                  ),
                  const SizedBox(height: 12),
                  // Badge status
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: badgeBg,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      paket.isActive ? 'Aktif' : 'Nonaktif',
                      style: TextStyle(
                        fontSize: 10,
                        color: badgeText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Harga
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Rp.${_formatHarga(paket.harga)}',
                        style: AppTextStyle.price,
                      ),
                      const SizedBox(width: 8),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Text(
                          '/bulan',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF2D2D2D),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // Fitur utama label
                  const Text(
                    'Fitur Utama :',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // List fitur
                  ...paket.fitur.entries.map((e) {
                    final Color tickColor = e.value ? const Color(0xFF0081FF) : const Color(0xFFD9D9D9);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, size: 18, color: tickColor),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              e.key,
                              style: const TextStyle(
                                fontSize: 12,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const Spacer(),
                  // Tombol langganan
                  GestureDetector(
                    onTap: () {
                      DetailPaketPage.go(
                        context,
                        status: SubscriptionStatus.payNow,
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 35,
                      decoration: BoxDecoration(
                        color: buttonBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Langganan',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Top color bar (menjadi border atas berwarna)
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: topColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatHarga(int harga) {
    final s = harga.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      buffer.write(s[i]);
      count++;
      if (count == 3 && i != 0) {
        buffer.write('.');
        count = 0;
      }
    }
    return buffer.toString().split('').reversed.join();
  }
}