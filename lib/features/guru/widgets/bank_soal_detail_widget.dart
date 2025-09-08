import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../models/bank_soal_detail_model.dart';
import '../providers/bank_soal_detail_provider.dart';

class BackButtonWidget extends StatelessWidget {
  final TextStyle? style;
  
  const BackButtonWidget({super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).maybePop(),
      child: Container(
        width: 101,
        height: 31,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Image.asset('assets/images/arrow-back.png', width: 16, height: 16),
            const SizedBox(width: 6),
            Text(
              'Kembali',
              style: style ?? AppTextStyle.blackSubtitle.copyWith(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0x1A0081FF),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 2),
            blurRadius: 7,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 16),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.roleButtonSelected,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/book.png',
                  width: 14,
                  height: 16,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Informatika',
                    style: AppTextStyle.cardTitle.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Sistem operasi dan cara kerja komp...',
                    style: AppTextStyle.cardSubtitle.copyWith(
                      color: const Color(0xFF373737),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Jumlah Soal: 30',
                    style: AppTextStyle.cardSubtitle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.roleButtonSelected,
                    ),
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

class QuestionCard extends ConsumerWidget {
  final int number;
  final Question question;
  final bool showAnswers;
  
  const QuestionCard({
    super.key,
    required this.number,
    required this.question,
    required this.showAnswers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final green = const Color(0xFF2ECC71);
    final midGrey = const Color(0xFFD9D9D9);
    final borderGrey = const Color(0xFFCACACA);
    
    Widget buildOption(OptionItem o) {
      if (question.type == QuestionType.single ||
          question.type == QuestionType.imageSingle) {
        final centerColor = showAnswers
            ? (o.isCorrect ? green : midGrey)
            : midGrey;
        final borderColor = (showAnswers && o.isCorrect) ? green : borderGrey;
        final radioWidget = Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor),
          ),
          child: Center(
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: centerColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
        
        final optionContent = question.type == QuestionType.imageSingle && o.imageAsset != null
            ? Image.asset(
                o.imageAsset!,
                width: 120,
                height: 80,
                fit: BoxFit.contain,
              )
            : Text(
                o.text ?? '',
                style: AppTextStyle.inputText.copyWith(
                  fontSize: 14,
                  color: AppColors.black,
                ),
              );
              
        return Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              radioWidget,
              const SizedBox(width: 12),
              Expanded(child: optionContent),
            ],
          ),
        );
      } else {
        final isCorrect = o.isCorrect;
        final backgroundColor = (showAnswers && isCorrect) ? green : AppColors.white;
        final borderColor = (showAnswers && isCorrect) ? green : borderGrey;
        
        final checkboxWidget = Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: borderColor),
          ),
          child: (showAnswers && isCorrect)
              ? Center(
                  child: Image.asset(
                    'assets/images/tick.png',
                    width: 16,
                    height: 16,
                  ),
                )
              : const SizedBox.shrink(),
        );
        
        final optionContent = Text(
          o.text ?? '',
          style: AppTextStyle.inputText.copyWith(
            fontSize: 14,
            color: AppColors.black,
          ),
        );
        
        return Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              checkboxWidget,
              const SizedBox(width: 12),
              Expanded(child: optionContent),
            ],
          ),
        );
      }
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$number.',
              style: AppTextStyle.inputText.copyWith(
                fontSize: 14,
                color: AppColors.black,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                question.text,
                style: AppTextStyle.inputText.copyWith(
                  fontSize: 14,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (question.type == QuestionType.single ||
            question.type == QuestionType.imageSingle)
          Column(
            children: question.options
                .map(
                  (o) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: buildOption(o),
                  ),
                )
                .toList(),
          ),
        if (question.type == QuestionType.multiple)
          Column(
            children: question.options
                .map(
                  (o) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: buildOption(o),
                  ),
                )
                .toList(),
          ),
        if (question.type == QuestionType.essay) ...[
          const SizedBox(height: 8),
          if (showAnswers)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 18),
                  child: Text(
                    ref.read(bankSoalProvider).essayAnswers[question.id] ?? '-',
                    style: AppTextStyle.inputText.copyWith(
                      fontSize: 14,
                      color: const Color(0xFF505050),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 18, right: 18),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: green, width: 1)),
                  ),
                ),
              ],
            ),
        ],
      ],
    );
  }
}