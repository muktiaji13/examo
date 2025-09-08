import 'package:flutter/material.dart';
import '../../../config/styles.dart';

class KredensialHeader extends StatelessWidget {
  const KredensialHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Kredensial',
        style: AppTextStyle.title.copyWith(fontSize: 18),
      ),
    );
  }
}

class KredensialCard extends StatelessWidget {
  const KredensialCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Examo',
              style: AppTextStyle.title.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Examo menyediakan kunci API untuk integrasi pembayaran online dan menawarkan template yang mudah digunakan dan antarmuka yang dapat disesuaikan sehingga mudah diimplementasikan.',
              style: AppTextStyle.subtitle,
            ),
            const SizedBox(height: 20),
            Divider(height: 1, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'API Keys',
              style: AppTextStyle.cardTitle,
            ),
            const SizedBox(height: 12),
            const ApiKeyField(
              label: 'Teacher ID',
              value: 'Exam60',
            ),
            const SizedBox(height: 8),
            const ApiKeyField(
              label: 'Teacher Key',
              value: 'bulVfe8wyf0qZI',
            ),
            const SizedBox(height: 20),
            const WarningBox(),
          ],
        ),
      ),
    );
  }
}

class ApiKeyField extends StatelessWidget {
  final String label;
  final String value;

  const ApiKeyField({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFECF7FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            '$label :  ',
            style: AppTextStyle.cardTitle,
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyle.cardSubtitle,
            ),
          ),
          Image.asset(
            'assets/images/copy_icon.png',
            height: 20,
            width: 20,
          ),
        ],
      ),
    );
  }
}

class WarningBox extends StatelessWidget {
  const WarningBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE6E6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/danger.png',
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: 'Kunci ini dibuat secara otomatis oleh sistem dan tidak boleh diubah. Jika Anda benar-benar perlu mengubah kunci karena suatu alasan, silakan ',
                style: AppTextStyle.blackSubtitle,
                children: [
                  TextSpan(
                    text: 'Hubungi Kami.',
                    style: AppTextStyle.link,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}