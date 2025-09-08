import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import 'daftar_ujian_page.dart';
import 'detail_ujian_page.dart';
import '../../../shared/widgets/app_header.dart';
import '../providers/tambah_ujian_provider.dart';
import '../widgets/tambah_ujian_widget.dart';

class TambahUjianPage extends ConsumerWidget {
  const TambahUjianPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ujianForm = ref.watch(ujianFormProvider);
    
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
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Judul + Kembali
                        HeaderWithBackButton(
                          onBackPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const DaftarUjianPage(),
                              ),
                            );
                          },
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
                              // Perbaiki: tambahkan parameter text
                              const FormFieldLabel(text: "Judul Ujian"),
                              FormInputField(
                                hint: "Masukkan Judul Ujian",
                                value: ujianForm.judul,
                                onChanged: (v) => ref
                                    .read(ujianFormProvider.notifier)
                                    .updateJudul(v),
                              ),
                              const SizedBox(height: 16),
                              const FormFieldLabel(text: "Cover Ujian"),
                              const SizedBox(height: 8),
                              const CoverUploadBox(),
                              const SizedBox(height: 16),
                              const FormFieldLabel(text: "Tanggal Ujian"),
                              FormInputField(
                                hint: "Masukkan Tanggal Ujian",
                                value: ujianForm.tanggal,
                                onChanged: (v) => ref
                                    .read(ujianFormProvider.notifier)
                                    .updateTanggal(v),
                              ),
                              const SizedBox(height: 16),
                              const FormFieldLabel(text: "Jam Mulai"),
                              FormInputField(
                                hint: "Masukkan Jam Mulai",
                                value: ujianForm.jamMulai,
                                onChanged: (v) => ref
                                    .read(ujianFormProvider.notifier)
                                    .updateJamMulai(v),
                              ),
                              const SizedBox(height: 16),
                              const FormFieldLabel(text: "Waktu Ujian"),
                              FormInputField(
                                hint: "Tentukan Waktu Ujian",
                                value: ujianForm.waktu,
                                onChanged: (v) => ref
                                    .read(ujianFormProvider.notifier)
                                    .updateWaktu(v),
                              ),
                              const SizedBox(height: 16),
                              const FormFieldLabel(text: "Jumlah Soal"),
                              FormInputField(
                                hint: "Masukkan Jumlah Soal Ujian",
                                value: ujianForm.jumlahSoal,
                                onChanged: (v) => ref
                                    .read(ujianFormProvider.notifier)
                                    .updateJumlahSoal(v),
                              ),
                              const SizedBox(height: 16),
                              const FormFieldLabel(text: "Kriteria Ketuntasan Minimal (KKM)"),
                              FormInputField(
                                hint: "Masukkan KKM",
                                value: ujianForm.kkm,
                                onChanged: (v) => ref
                                    .read(ujianFormProvider.notifier)
                                    .updateKkm(v),
                              ),
                              const SizedBox(height: 16),
                              const FormFieldLabel(text: "Deskripsi"),
                              FormInputField(
                                hint: "Masukkan Deskripsi",
                                value: ujianForm.deskripsi,
                                maxLines: 5,
                                onChanged: (v) => ref
                                    .read(ujianFormProvider.notifier)
                                    .updateDeskripsi(v),
                              ),
                              const SizedBox(height: 24),
                              // === BUTTONS ===
                              FormActionButtons(
                                onCancel: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const DaftarUjianPage(),
                                    ),
                                  );
                                },
                                onSave: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const ExamDetailPage(),
                                    ),
                                  );
                                },
                              ),
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
}