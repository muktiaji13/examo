// lib/features/guru/widgets/detail_ujian_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../providers/detail_ujian_provider.dart';

class DetailUjianHeader extends StatelessWidget {
  final VoidCallback onBack;
  
  const DetailUjianHeader({
    super.key,
    required this.onBack,
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Detail Ujian', style: AppTextStyle.cardTitle),
        GestureDetector(
          onTap: onBack,
          child: Row(
            children: [
              Image.asset('assets/images/arrow-back.png', width: 16, height: 16),
              const SizedBox(width: 4),
              Text('Kembali', style: AppTextStyle.cardSubtitle),
            ],
          ),
        ),
      ],
    );
  }
}

class DetailUjianCard extends ConsumerWidget {
  const DetailUjianCard({
    super.key,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exam = ref.watch(detailUjianProvider);
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFEBEBEB), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image box
            Container(
              width: double.infinity,
              height: 166,
              decoration: BoxDecoration(
                color: const Color(0xFFD5EDFF),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: Image.asset('assets/images/ujian_aktif.png', fit: BoxFit.contain)),
            ),
            const SizedBox(height: 12),
            // Title + time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(exam.title, style: AppTextStyle.cardTitle),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEAEB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(exam.timeText, style: AppTextStyle.menuItemDanger),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Kode Ujian
            Row(
              children: [
                Text('Kode Ujian', style: AppTextStyle.blackSubtitle),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFEBEBEB), width: 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(exam.code, style: AppTextStyle.cardSubtitle),
                        Image.asset('assets/images/copy.png', width: 16, height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Info Rows
            UjianInfoRow(
              label: 'Tanggal :',
              value: exam.date,
              icon: 'assets/images/yellow-date.png',
              bgColor: const Color(0xFFFFF9E5),
            ),
            UjianInfoRow(
              label: 'Waktu Ujian :',
              value: exam.duration,
              icon: 'assets/images/time.png',
              bgColor: const Color(0xFFE6F3FF),
            ),
            UjianInfoRow(
              label: 'Jumlah Soal :',
              value: exam.questionCount,
              icon: 'assets/images/file.png',
              bgColor: const Color(0xFFFFEFE8),
            ),
            UjianInfoRow(
              label: 'Nilai KKM :',
              value: exam.kkm,
              icon: 'assets/images/sort.png',
              bgColor: const Color(0xFFE6FFF0),
            ),
            const SizedBox(height: 12),
            // Deskripsi
            Text('Deskripsi :', style: AppTextStyle.blackSubtitle),
            const SizedBox(height: 4),
            Text(exam.description, style: AppTextStyle.cardSubtitle),
            const SizedBox(height: 12),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9E5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Center(child: Text('Edit', style: AppTextStyle.menuItem)),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4D55CC),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: Center(child: Text('Lihat Nilai', style: AppTextStyle.button)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class UjianInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final String icon;
  final Color bgColor;
  
  const UjianInfoRow({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.bgColor,
  });
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Image.asset(icon, width: 20, height: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(label, style: AppTextStyle.blackSubtitle)),
            Text(value, style: AppTextStyle.cardSubtitle),
          ],
        ),
      ),
    );
  }
}

class UjianRuleCard extends ConsumerWidget {
  const UjianRuleCard({
    super.key,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exam = ref.watch(detailUjianProvider);
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFEBEBEB), width: 1),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Peraturan dan Tata Cara Ujian:', style: AppTextStyle.blackSubtitle),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: exam.rules
                .asMap()
                .entries
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text('${e.key + 1}. ${e.value}', style: AppTextStyle.cardSubtitle),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}