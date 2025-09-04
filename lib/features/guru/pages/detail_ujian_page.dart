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
    final exam = ref.watch(detailUjianProvider);
    
    return Scaffold(
      backgroundColor: AppColors.background2,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeader(showBack: false),
              const SizedBox(height: 16),
              DetailUjianHeader(
                onBack: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 16),
              DetailUjianCard(exam: exam),
              const SizedBox(height: 16),
              ExamRulesCard(exam: exam),
            ],
          ),
        ),
      ),
    );
  }
}