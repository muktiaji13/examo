import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../../../shared/widgets/app_header.dart';
import '../providers/detail_ujian_provider.dart';
import '../widgets/detail_ujian_widget.dart';

class ExamDetailPage extends ConsumerWidget {
  const ExamDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(detailUjianProvider);

    return Scaffold(
      backgroundColor: AppColors.background2,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeader(showBack: false),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailUjianHeader(
                      onBack: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(height: 16),
                    DetailUjianCard(),
                    const SizedBox(height: 16),
                    UjianRuleCard(),
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
