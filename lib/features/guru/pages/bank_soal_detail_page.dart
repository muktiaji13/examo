import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../../../shared/widgets/app_header.dart';
import '../providers/bank_soal_detail_provider.dart';
import '../widgets/bank_soal_detail_widget.dart';

class BankSoalDetailPage extends ConsumerWidget {
  const BankSoalDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bankSoalProvider);
    final daftarSoalStyle = AppTextStyle.cardTitle.copyWith(
      fontWeight: FontWeight.w500,
    );
    final kembaliStyle = AppTextStyle.blackSubtitle.copyWith(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      height: 18 / 13,
    );
    final labelStyle = AppTextStyle.inputText.copyWith(
      fontSize: 14,
      color: AppColors.textGrey2,
    );

    return Scaffold(
      backgroundColor: AppColors.background2,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Daftar Soal', style: daftarSoalStyle),
                          ),
                          BackButtonWidget(style: kembaliStyle),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const CourseCard(),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x1A000000),
                            offset: const Offset(0, 2),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Tampilkan Jawaban',
                                      style: labelStyle,
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () => ref
                                          .read(bankSoalProvider.notifier)
                                          .toggleShowAnswers(),
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                        width: 46,
                                        height: 26,
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color: state.showAnswers
                                              ? const Color(0xFF2ECC71)
                                              : const Color(0xFFD5D5D5),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: AnimatedAlign(
                                          duration: const Duration(milliseconds: 200),
                                          curve: Curves.easeInOut,
                                          alignment: state.showAnswers
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 66,
                                  height: 27,
                                  decoration: BoxDecoration(
                                    color: const Color(0x1AF39C12),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Edit',
                                      style: AppTextStyle.menuItem.copyWith(
                                        fontSize: 14,
                                        color: const Color(0xFFF39C12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Divider(color: const Color(0xFFDCDCDC), thickness: 1),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: dummyQuestions.length,
                              separatorBuilder: (_, __) => const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final q = dummyQuestions[index];
                                return QuestionCard(
                                  number: index + 1,
                                  question: q,
                                  showAnswers: state.showAnswers,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}