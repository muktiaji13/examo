import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import 'daftar_ujian_page.dart';
import 'exam_detail_page.dart';
import '../../../shared/widgets/app_header.dart';

final ujianProvider = StateProvider<Map<String, dynamic>>((ref) => {
      "judul": "",
      "tanggal": "",
      "jamMulai": "",
      "waktu": "",
      "jumlahSoal": "",
      "kkm": "",
      "deskripsi": "",
    });

class TambahUjianPage extends ConsumerWidget {
  const TambahUjianPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ujian = ref.watch(ujianProvider);

    return Scaffold(
      backgroundColor: AppColors.background2,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppLayout.maxWidth),
            child: Column(
              children: [
                AppHeader(showBack: true),
                // === BODY ===
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Judul + Kembali
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tambah Ujian",
                              style: AppTextStyle.cardTitle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const DaftarUjianPage()),
                                );
                              },
                              child: Container(
                                height: 31,
                                width: 101,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: AppColors.textGrey.withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/arrow-back.png",
                                        width: 18),
                                    const SizedBox(width: 5),
                                    Text(
                                      "Kembali",
                                      style: AppTextStyle.subtitle.copyWith(
                                        fontSize: 13,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 20),

                        // === CARD FORM ===
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFieldLabel("Judul Ujian"),
                              _buildInputField(
                                hint: "Masukkan Judul Ujian",
                                value: ujian["judul"],
                                onChanged: (v) => ref
                                    .read(ujianProvider.notifier)
                                    .update((state) => {...state, "judul": v}),
                              ),
                              const SizedBox(height: 16),

                              _buildFieldLabel("Cover Ujian"),
                              const SizedBox(height: 8),
                              _buildCoverBox(),
                              const SizedBox(height: 16),

                              _buildFieldLabel("Tanggal Ujian"),
                              _buildInputField(hint: "Masukkan Tanggal Ujian"),
                              const SizedBox(height: 16),

                              _buildFieldLabel("Jam Mulai"),
                              _buildInputField(hint: "Masukkan Jam Mulai"),
                              const SizedBox(height: 16),

                              _buildFieldLabel("Waktu Ujian"),
                              _buildInputField(hint: "Tentukan Waktu Ujian"),
                              const SizedBox(height: 16),

                              _buildFieldLabel("Jumlah Soal"),
                              _buildInputField(
                                  hint: "Masukkan Jumlah Soal Ujian"),
                              const SizedBox(height: 16),

                              _buildFieldLabel(
                                  "Kriteria Ketuntasan Minimal (KKM)"),
                              _buildInputField(hint: "Masukkan KKM"),
                              const SizedBox(height: 16),

                              _buildFieldLabel("Deskripsi"),
                              _buildInputField(
                                hint: "Masukkan Deskripsi",
                                maxLines: 5,
                              ),

                              const SizedBox(height: 24),

                              // === BUTTONS ===
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const DaftarUjianPage()),
                                      );
                                    },
                                    child: Container(
                                      height: 37,
                                      width: 93,
                                      decoration: BoxDecoration(
                                        color: AppColors.lightDanger,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Batal",
                                        style: AppTextStyle.button.copyWith(
                                          color: AppColors.dangerRed,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const ExamDetailPage()),
                                      );
                                    },
                                    child: Container(
                                      height: 37,
                                      width: 124,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF0081FF),
                                            Color(0xFF025BB1),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Simpan",
                                        style: AppTextStyle.button.copyWith(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
    return Text(
      text,
      style: AppTextStyle.blackSubtitle.copyWith(
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildInputField({
    required String hint,
    String? value,
    Function(String)? onChanged,
    int maxLines = 1,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        border: Border.all(color: AppColors.textGrey.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        onChanged: onChanged,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          hintStyle: AppTextStyle.inputText.copyWith(fontSize: 12),
        ),
        style: AppTextStyle.blackSubtitle.copyWith(fontSize: 12),
      ),
    );
  }

  Widget _buildCoverBox() {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFD3E9FF),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 3,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/cover_ujian.png", height: 60),
          const SizedBox(height: 6),
          Text(
            "Klik atau Seret foto anda disini",
            style: AppTextStyle.inputText.copyWith(
              fontSize: 10,
              color: AppColors.textGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.textGrey,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              "*opsional",
              style: AppTextStyle.inputText.copyWith(
                fontSize: 9,
                color: AppColors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}