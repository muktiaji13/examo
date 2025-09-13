import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import '../../../config/styles.dart';
import '../models/bank_soal_model.dart';

class BankSoalSortDropdown extends StatelessWidget {
  final String currentValue;
  final ValueChanged<String>? onChanged;
  
  const BankSoalSortDropdown({
    super.key,
    required this.currentValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Text(
            currentValue,
            style: AppTextStyle.inputText
          ),
          const SizedBox(width: 4),
          Icon(Icons.expand_more, size: 16, color: Color(0xFF9D9D9D)),
        ],
      ),
    );
  }
}

class BankSoalActionButtons extends StatelessWidget {
  final VoidCallback onTemplateTap;
  final VoidCallback onAddBankSoalTap;
  
  const BankSoalActionButtons({
    super.key,
    required this.onTemplateTap,
    required this.onAddBankSoalTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onTemplateTap,
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF4D55CC),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(TablerIcons.download, color: Colors.white, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'Template',
                    style: AppTextStyle.button.copyWith(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: InkWell(
            onTap: onAddBankSoalTap,
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF0081FF),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(TablerIcons.plus, color: Colors.white, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'Bank Soal',
                    style: AppTextStyle.button.copyWith(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BankSoalCard extends StatelessWidget {
  final BankSoalItem item;
  final VoidCallback onDelete;
  final double? width;
  final VoidCallback? onShowDeleteNotif;
  final VoidCallback? onDetail;
  
  const BankSoalCard({
    super.key,
    required this.item,
    required this.onDelete,
    this.width,
    this.onShowDeleteNotif,
    this.onDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEBEBEB)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F3FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/bank_soal.png',
                width: 52,
                height: 52,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            item.title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.subtitle,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xFF5E5E5E),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: onDetail,
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
                    child: const Center(
                      child: Text(
                        'Detail',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: onShowDeleteNotif,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEAEB),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Image.asset(
                    'assets/images/trash.png',
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BankSoalDeleteNotification extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  
  const BankSoalDeleteNotification({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFFFEAEB),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                'assets/images/warning-icon.png',
                width: 32,
                height: 32,
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 189,
            child: Text(
              'Hapus bank soal ini?',
              textAlign: TextAlign.center,
              style: AppTextStyle.cardTitle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 248,
            child: Text(
              'File ini akan dihapus secara permanen dan tidak dapat dipulihkan',
              textAlign: TextAlign.center,
              style: AppTextStyle.cardSubtitle.copyWith(
                fontSize: 13,
                color: AppColors.textGrey2,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 90,
                height: 36,
                child: TextButton(
                  onPressed: onCancel,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFF5F5F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Tidak',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.textGrey2,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 116,
                height: 36,
                child: ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dangerRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    elevation: 0,
                  ),
                  child: Text(
                    'Ya, Hapus',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}