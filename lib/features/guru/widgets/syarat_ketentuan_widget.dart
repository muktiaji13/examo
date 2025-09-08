import 'package:flutter/material.dart';
import '../../../config/styles.dart';
import '../models/syarat_ketentuan_model.dart';

class SyaratKetentuanSection extends StatelessWidget {
  final SyaratSection section;

  const SyaratKetentuanSection({
    super.key,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${section.number} ${section.title}',
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
                  minHeight: _estimateLineHeight(section.content, section.bullets),
                ),
              ),
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: section.bullets != null
                      ? section.bullets!
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
                            section.content ?? '',
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