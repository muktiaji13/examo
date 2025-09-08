import 'package:flutter/material.dart';
import '../../../config/styles.dart';
import '../models/detail_paket_model.dart';

class KembaliButton extends StatelessWidget {
  const KembaliButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 101,
      height: 31,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        onPressed: () => Navigator.of(context).maybePop(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/arrow-back.png', width: 15.94, height: 15.94),
            const SizedBox(width: 6),
            const Text('Kembali', style: TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class DetailPemesananCard extends StatelessWidget {
  final PackageDetail pkg;
  const DetailPemesananCard({super.key, required this.pkg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Color(0x1A000000), blurRadius: 4),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Detail Pemesanan', style: AppTextStyle.sectionTitle),
          const SizedBox(height: 15),
          _infoRow('Nama Paket', pkg.name),
          const SizedBox(height: 16),
          _infoRow('Masa Berlaku', 'Paket aktif hingga ${_formatDate(pkg.end)}'),
          const SizedBox(height: 16),
          Text('Detail Paket', style: AppTextStyle.label),
          const SizedBox(height: 6),
          Text('Paket sudah termasuk :', style: AppTextStyle.value),
          const SizedBox(height: 12),
          ...pkg.features.map((f) => FeatureRow(text: f)).toList(),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.label),
        const SizedBox(height: 6),
        Text(value, style: AppTextStyle.value),
      ],
    );
  }

  String _formatDate(DateTime d) {
    const months = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 
                   'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }
}

class FeatureRow extends StatelessWidget {
  final String text;
  const FeatureRow({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 20, color: Color(0xFF0081FF)),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: AppTextStyle.featureText)),
        ],
      ),
    );
  }
}

class DetailPembayaranCard extends StatelessWidget {
  final PackageDetail pkg;
  final SubscriptionStatus status;
  final VoidCallback onPay;
  final VoidCallback onResumePayment;
  
  const DetailPembayaranCard({
    super.key,
    required this.pkg,
    required this.status,
    required this.onPay,
    required this.onResumePayment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Color(0x1A000000), blurRadius: 4),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Detail Pembayaran', style: AppTextStyle.sectionTitle),
          const SizedBox(height: 16),
          _priceRow('Paket Premium', _formatRupiah(pkg.price)),
          const SizedBox(height: 10),
          _priceRow('Admin / Pajak', _formatRupiah(pkg.adminFee)),
          const SizedBox(height: 16),
          const DashedDivider(),
          const SizedBox(height: 16),
          _priceRow('Total', _formatRupiah(pkg.total), 
                   isBoldRight: true, rightColor: const Color(0xFFD21F28)),
          const SizedBox(height: 16),
          const DashedDivider(),
          const SizedBox(height: 16),
          _buildBottomAction(),
        ],
      ),
    );
  }

  Widget _priceRow(String left, String right, {bool isBoldRight = false, Color? rightColor}) {
    return Row(
      children: [
        Expanded(child: Text(left, style: AppTextStyle.priceLabel)),
        SizedBox(
          width: 120,
          child: Text(
            right,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: isBoldRight ? FontWeight.w600 : FontWeight.w500,
              fontSize: 16,
              color: rightColor ?? Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomAction() {
    switch (status) {
      case SubscriptionStatus.active:
        return _statusPill('Status Langganan Aktif', 
                          const Color(0xFFE5FFF0), const Color(0xFF2ECC71));
      case SubscriptionStatus.expired:
        return _statusPill('Status Langganan Kadaluarsa', 
                          const Color(0xFFE4E4E4), const Color(0xFF717171));
      case SubscriptionStatus.pending:
        return _gradientButton('Lanjutkan Pembayaran', onResumePayment);
      case SubscriptionStatus.payNow:
        return _gradientButton('Bayar Sekarang', onPay);
    }
  }

  Widget _statusPill(String text, Color background, Color textColor) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(25),
      ),
      alignment: Alignment.center,
      child: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
    );
  }

  Widget _gradientButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0081FF), Color(0xFF004E99)],
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  String _formatRupiah(int value) {
    final s = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final reversedIndex = s.length - i - 1;
      buffer.write(s[i]);
      if (reversedIndex % 3 == 0 && i != s.length - 1) buffer.write('.');
    }
    return 'Rp.' + buffer.toString();
  }
}

class DashedDivider extends StatelessWidget {
  const DashedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.maxWidth;
        final dashCount = (boxWidth / 8).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return const SizedBox(
              width: 4,
              height: 1,
              child: DecoratedBox(decoration: BoxDecoration(color: Color(0xFFD9D9D9))),
            );
          }),
        );
      },
    );
  }
}