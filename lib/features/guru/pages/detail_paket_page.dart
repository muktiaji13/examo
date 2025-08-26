import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/app_header.dart';

/// ---------------------------------------------------------------------------
/// Model dan Provider
/// ---------------------------------------------------------------------------

/// Status langganan untuk menentukan UI di bagian bawah card pembayaran.
enum SubscriptionStatus { payNow, pending, active, expired }

class PackageDetail {
  final String name;
  final DateTime start;
  final DateTime end;
  final List<String> features;
  final int price; // dalam rupiah
  final int adminFee; // dalam rupiah

  const PackageDetail({
    required this.name,
    required this.start,
    required this.end,
    required this.features,
    required this.price,
    required this.adminFee,
  });

  int get total => price + adminFee;
}

/// Dummy data paket. Lu bisa ganti ambil dari API.
final packageDetailProvider = Provider<PackageDetail>((ref) {
  return PackageDetail(
    name: 'Paket Premium',
    start: DateTime(2025, 6, 1),
    end: DateTime(2025, 6, 30),
    features: const [
      'Paket aktif mulai 01 Juni 2025',
      'Buat soal sesuai kebutuhan',
      'Download Template',
    ],
    price: 250000,
    adminFee: 2000,
  );
});

/// Status halaman detail. Diinisialisasi lewat argumen halaman.
final subscriptionStatusProvider = StateProvider<SubscriptionStatus>((ref) {
  return SubscriptionStatus.active; // default. akan dioverride di initState
});

/// ---------------------------------------------------------------------------
/// Halaman Detail Paket
/// ---------------------------------------------------------------------------

class DetailPaketPage extends ConsumerStatefulWidget {
  final SubscriptionStatus initialStatus;

  const DetailPaketPage({super.key, required this.initialStatus});

  /// Helper untuk navigasi yang rapi.
  static Future<void> go(
    BuildContext context, {
    required SubscriptionStatus status,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => DetailPaketPage(initialStatus: status)),
    );
  }

  @override
  ConsumerState<DetailPaketPage> createState() => _DetailPaketPageState();
}

class _DetailPaketPageState extends ConsumerState<DetailPaketPage> {
  @override
  void initState() {
    super.initState();
    // Set initial status ke provider saat halaman dibuat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(subscriptionStatusProvider.notifier).state =
          widget.initialStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pkg = ref.watch(packageDetailProvider);
    final status = ref.watch(subscriptionStatusProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // sesuai permintaan
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeader(),
            const SizedBox(height: 12),

            // Title + Tombol Kembali
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Detail Paket', style: _titleStyle(context)),
                  const _KembaliButton(),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Card Detail Pemesanan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _DetailPemesananCard(pkg: pkg),
            ),

            const SizedBox(height: 16),

            // Card Detail Pembayaran
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _DetailPembayaranCard(
                  pkg: pkg,
                  status: status,
                  onPay: () {
                    // Arahkan ke halaman pembayaran lu.
                    // Ganti dengan Navigator ke halaman real.
                    debugPrint('Go to Pay Now');
                  },
                  onResumePayment: () {
                    // Arahkan ke halaman lanjutkan pembayaran.
                    debugPrint('Resume Payment');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Widgets
/// ---------------------------------------------------------------------------

class _KembaliButton extends StatelessWidget {
  const _KembaliButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 101,
      height: 31,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFFFFFFF),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        onPressed: () => Navigator.of(context).maybePop(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon dari assets sesuai request
            Image.asset(
              'assets/images/arrow-back.png',
              width: 15.94,
              height: 15.94,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 6),
            Text(
              'Kembali',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 13,
                height: 18 / 13,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailPemesananCard extends StatelessWidget {
  final PackageDetail pkg;
  const _DetailPemesananCard({required this.pkg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000), // #0000001A
            blurRadius: 4,
            offset: Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Detail Pemesanan', style: _sectionTitleStyle(context)),
          const SizedBox(height: 15),

          Text('Nama Paket', style: _label18(context)),
          const SizedBox(height: 6),
          Text(pkg.name, style: _value14(context)),

          const SizedBox(height: 16),
          Text('Masa Berlaku', style: _label18(context)),
          const SizedBox(height: 6),
          Text(
            'Paket aktif hingga ${_formatDate(pkg.end)}',
            style: _value14(context),
          ),

          const SizedBox(height: 16),
          Text('Detail Paket', style: _label18(context)),
          const SizedBox(height: 6),
          Text('Paket sudah termasuk :', style: _value14(context)),
          const SizedBox(height: 12),

          // List fitur
          ...pkg.features.map((f) => _FeatureRow(text: f)).toList(),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String text;
  const _FeatureRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, size: 20, color: Color(0xFF0081FF)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 18 / 16,
                letterSpacing: -0.17,
                color: Color(0xFF4E4E4E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailPembayaranCard extends StatelessWidget {
  final PackageDetail pkg;
  final SubscriptionStatus status;
  final VoidCallback onPay;
  final VoidCallback onResumePayment;

  const _DetailPembayaranCard({
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
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 4,
            offset: Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Detail Pembayaran', style: _sectionTitleStyle(context)),
          const SizedBox(height: 16),

          _priceRow('Paket Premium', _idr(pkg.price), isBoldRight: false),
          const SizedBox(height: 10),
          _priceRow('Admin / Pajak', _idr(pkg.adminFee), isBoldRight: false),

          const SizedBox(height: 16),
          const DashedDivider(),
          const SizedBox(height: 16),

          _priceRow(
            'Total',
            _idr(pkg.total),
            isBoldRight: true,
            rightColor: const Color(0xFFD21F28),
          ),

          const SizedBox(height: 16),
          const DashedDivider(),
          const SizedBox(height: 16),

          _bottomAction(status),
        ],
      ),
    );
  }

  Widget _priceRow(
    String left,
    String right, {
    required bool isBoldRight,
    Color? rightColor,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            left,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 1,
              color: Color(0xFF4E4E4E),
            ),
          ),
        ),
        SizedBox(
          width: 120,
          child: Text(
            right,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: isBoldRight ? FontWeight.w600 : FontWeight.w500,
              fontSize: 16,
              height: 1,
              color: rightColor ?? const Color(0xFF000000),
            ),
          ),
        ),
      ],
    );
  }

  Widget _bottomAction(SubscriptionStatus status) {
    switch (status) {
      case SubscriptionStatus.active:
        return _statusPill(
          text: 'Status Langganan Aktif',
          background: const Color(0xFFE5FFF0),
          textColor: const Color(0xFF2ECC71),
        );
      case SubscriptionStatus.expired:
        return _statusPill(
          text: 'Status Langganan Kadaluarsa',
          background: const Color(0xFFE4E4E4),
          textColor: const Color(0xFF717171),
        );
      case SubscriptionStatus.pending:
        return _gradientButton(
          label: 'Lanjutkan Pembayaran',
          onTap: onResumePayment,
        );
      case SubscriptionStatus.payNow:
        return _gradientButton(label: 'Bayar Sekarang', onTap: onPay);
    }
  }

  Widget _statusPill({
    required String text,
    required Color background,
    required Color textColor,
  }) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(25),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.01,
          color: textColor,
        ),
      ),
    );
  }

  Widget _gradientButton({required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 35,
        padding: const EdgeInsets.symmetric(vertical: 7),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0081FF), Color(0xFF004E99)],
          ),
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 3,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}

/// Garis putus putus custom. dash 4 gap 4 warna #D9D9D9
class DashedDivider extends StatelessWidget {
  final double dashWidth;
  final double dashGap;
  final double thickness;
  final Color color;

  const DashedDivider({
    super.key,
    this.dashWidth = 4,
    this.dashGap = 4,
    this.thickness = 1,
    this.color = const Color(0xFFD9D9D9),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.maxWidth;
        final dashCount = (boxWidth / (dashWidth + dashGap)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: thickness,
              child: DecoratedBox(decoration: BoxDecoration(color: color)),
            );
          }),
        );
      },
    );
  }
}

/// ---------------------------------------------------------------------------
/// Helpers Style
/// ---------------------------------------------------------------------------

TextStyle _titleStyle(BuildContext context) {
  // Ambil dari styles.dart kalau ada. Lalu sesuaikan pakai copyWith.
  // Di sini langsung define sesuai Figma.
  return const TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 20,
    height: 1,
    color: Color(0xFF000000),
  );
}

TextStyle _sectionTitleStyle(BuildContext context) {
  return const TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 1,
    color: Color(0xFF000000),
  );
}

TextStyle _label18(BuildContext context) {
  return const TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 1,
    color: Color(0xFF000000),
  );
}

TextStyle _value14(BuildContext context) {
  return const TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1,
    color: Color(0xFF4E4E4E),
  );
}

String _formatDate(DateTime d) {
  // format: 30 Juni 2025
  const months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];
  return '${d.day} ${months[d.month - 1]} ${d.year}';
}

String _idr(int value) {
  // Tanpa simbol. Pakai format sederhana 250.000
  final s = value.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    final reversedIndex = s.length - i - 1;
    buffer.write(s[i]);
    if (reversedIndex % 3 == 0 && i != s.length - 1) buffer.write('.');
  }
  return 'Rp.' + buffer.toString();
}
