import 'package:flutter/material.dart';
import '../../../config/styles.dart';
import '../pages/detail_ujian_page.dart';
import '../pages/bank_soal_detail_page.dart';

class DashboardStatCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String count;
  final Color color;
  final Color iconBg;
  final String iconPath;

  const DashboardStatCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.count,
    required this.color,
    required this.iconBg,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(iconPath, height: 20),
            ),
            const SizedBox(height: 10),
            Text(count, style: AppTextStyle.title.copyWith(fontSize: 20)),
            Text(
              title,
              style: AppTextStyle.subtitle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(subtitle, style: AppTextStyle.subtitle.copyWith(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class DashboardSectionHeader extends StatelessWidget {
  final String title;

  const DashboardSectionHeader(String s, {super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.title.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('Selengkapnya', style: AppTextStyle.link.copyWith(fontSize: 13)),
        ],
      ),
    );
  }
}

class DashboardEmptyCard extends StatelessWidget {
  final String message;
  final String desc;
  final String image;

  const DashboardEmptyCard({
    super.key,
    required this.message,
    required this.desc,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 28),
        child: Column(
          children: [
            Image.asset(image, height: 64),
            const SizedBox(height: 12),
            Text(message, style: AppTextStyle.title.copyWith(fontSize: 14)),
            Text(desc, style: AppTextStyle.subtitle.copyWith(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class DashboardUjianAktifCard extends StatelessWidget {
  final Map<String, String> item;

  const DashboardUjianAktifCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
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
                child: Image.asset(
                  item['image'] ?? 'assets/images/ujian_aktif.png',
                  height: 80,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    item['title'] ?? '',
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
                    item['status'] ?? 'Aktif',
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
              child: Text(
                item['questions'] ?? '',
                style: AppTextStyle.cardSubtitle,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ExamDetailPage(),
                        ),
                      );
                    },
                    child: Container(
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
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEAEB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Image.asset('assets/images/trash.png', height: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardBankSoalCard extends StatelessWidget {
  final Map<String, String> item;

  const DashboardBankSoalCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F8FF),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: Image.asset(
                  item['image'] ?? 'assets/images/bank_soal.png',
                  height: 72,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] ?? '',
                        style: AppTextStyle.blackSubtitle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['desc'] ?? '',
                        style: AppTextStyle.cardSubtitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(item['time'] ?? '', style: AppTextStyle.cardSubtitle),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const BankSoalDetailPage(),
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
                          child: Text('Detail', style: AppTextStyle.button),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEAEB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Image.asset('assets/images/trash.png', height: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardHaloCard extends StatelessWidget {
  const DashboardHaloCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xFFD8EFFF)],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo, Sobat Examo!',
                    style: AppTextStyle.title.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nikmati berbagai fitur menarik dan hebat dari examo. Buat ujianmu jadi gampang!',
                    style: AppTextStyle.subtitle.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Image.asset(
              'assets/images/banner_image.png',
              height: 72,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
