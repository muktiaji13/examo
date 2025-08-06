import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';

class SyaratKetentuanPage extends ConsumerWidget {
  const SyaratKetentuanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Column(
          children: [
            // AppBar
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/sidebar_icon.png',
                    width: 24,
                    height: 24,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/profile_pic.png',
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 30,
                            right: 20,
                            top: 30,
                            bottom: 30,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                'Syarat dan Ketentuan',
                                style: AppTextStyle.cardTitle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  height: 1.0,
                                  letterSpacing: 0,
                                ),
                              ),
                              const SizedBox(height: 27), // dari 30 ke 87
                              // Sections
                              _buildSection(
                                number: '1.',
                                title: 'Penerimaan Syarat',
                                content:
                                    'Dengan menggunakan Examo Anda dianggap menyetujui syarat dan ketentuan yang berlaku. Jika tidak setuju harap tidak menggunakan layanan ini.',
                              ),
                              _buildSection(
                                number: '2.',
                                title: 'Layanan',
                                content:
                                    'Examo. menyediakan layanan ujian online pembuatan ujian pembuatan bank soal dan program detail nilai melalui platfrom digital',
                              ),
                              _buildSection(
                                number: '3.',
                                title: 'Akun Pengguna',
                                bullets: [
                                  'Pengguna wajib mengisi data dengan benar dan lengkap.',
                                  'Menjaga akun dan kata sandi adalah tanggung jawab pengguna.',
                                  'Segala aktivitas dalam akun menjadi tanggung jawab pemiliknya.',
                                ],
                              ),
                              _buildSection(
                                number: '4.',
                                title: 'Hak Cipta dan Konten',
                                bullets: [
                                  'Semua materi dan konten di platform ini dilindungi hak cipta dan tidak boleh disalin didistribusikan atau digunakan tanpa izin tertulis.',
                                  'Pengguna tidak diperbolehkan mengunggah konten yang melanggar hukum atau mengandung SARA.',
                                ],
                              ),
                              _buildSection(
                                number: '5.',
                                title: 'Perubahan Layanan',
                                content:
                                    'Kami berhak untuk mengubah menghentikan atau memperbarui fitur atau ketentuan kapan saja dengan atau tanpa pemberitahuan sebelumnya.',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String number,
    required String title,
    String? content,
    List<String>? bullets,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number $title',
            style: AppTextStyle.menuItem.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 1.0,
              letterSpacing: 0,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Blue Line
              Container(
                width: 3,
                margin: const EdgeInsets.only(top: 0, left: 26, right: 10),
                color: AppColors.roleButtonSelected,
                constraints: BoxConstraints(
                  minHeight: _estimateLineHeight(content, bullets),
                ),
              ),
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: bullets != null
                      ? bullets
                            .map(
                              (b) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '• ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        b,
                                        style: AppTextStyle.inputText.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          height: 1.0,
                                          letterSpacing: 0,
                                          color: AppColors.textGrey2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList()
                      : [
                          Text(
                            content ?? '',
                            style: AppTextStyle.inputText.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.0,
                              letterSpacing: 0,
                              color: AppColors.textGrey2,
                            ),
                          ),
                        ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double _estimateLineHeight(String? content, List<String>? bullets) {
    if (bullets != null) {
      return bullets.length * 22;
    }
    if (content != null) {
      final lines = (content.length / 50).ceil();
      return lines * 22;
    }
    return 22;
  }
}
