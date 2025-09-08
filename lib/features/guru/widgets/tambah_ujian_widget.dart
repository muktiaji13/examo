import 'package:flutter/material.dart';
import '../../../config/styles.dart';

class FormFieldLabel extends StatelessWidget {
  final String text;

  const FormFieldLabel({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyle.blackSubtitle.copyWith(
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class FormInputField extends StatelessWidget {
  final String hint;
  final String? value;
  final Function(String)? onChanged;
  final int maxLines;

  const FormInputField({
    super.key,
    required this.hint,
    this.value,
    this.onChanged,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
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
}

class CoverUploadBox extends StatelessWidget {
  const CoverUploadBox({super.key});

  @override
  Widget build(BuildContext context) {
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

class FormActionButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const FormActionButtons({
    super.key,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onCancel,
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
          onTap: onSave,
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
    );
  }
}

class HeaderWithBackButton extends StatelessWidget {
  final VoidCallback onBackPressed;

  const HeaderWithBackButton({
    super.key,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
          onTap: onBackPressed,
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
                Image.asset("assets/images/arrow-back.png", width: 18),
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
    );
  }
}