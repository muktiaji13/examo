import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../providers/edit_password_provider.dart';

class PasswordField extends ConsumerWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;
  final Color? borderColor;
  final bool readOnly;
  final ValueChanged<String>? onChanged; 

  const PasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.onToggleVisibility,
    this.borderColor,
    this.readOnly = false,
    this.onChanged, 
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      onChanged: onChanged, 
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: AppTextStyle.inputText,
        suffixIcon: onToggleVisibility != null
            ? GestureDetector(
                onTap: onToggleVisibility,
                child: Image.asset(
                  obscureText
                      ? 'assets/auth-image/eye-off.png'
                      : 'assets/auth-image/eye-on.png',
                ),
              )
            : Image.asset('assets/auth-image/eye-off.png'),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor ?? const Color(0xFFD9D9D9), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor ?? const Color(0xFF2ECC71), width: 1),
        ),
      ),
    );
  }
}

class PasswordValidationItem extends StatelessWidget {
  final bool isValid;
  final String text;

  const PasswordValidationItem({
    super.key,
    required this.isValid,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          isValid ? 'assets/images/tick.png' : 'assets/images/cross.png',
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: AppTextStyle.cardSubtitle.copyWith(
            color: isValid ? const Color(0xFF2ECC71) : const Color(0xFFD21F28),
          ),
        ),
      ],
    );
  }
}

class PasswordValidationRules extends ConsumerWidget {
  const PasswordValidationRules({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validationState = ref.watch(passwordValidationProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tambahkan semua karakter yang diperlukan untuk membuat kata sandi yang aman:",
          style: AppTextStyle.cardSubtitle.copyWith(
            color: const Color(0xFFD21F28),
          ),
        ),
        const SizedBox(height: 8),
        PasswordValidationItem(
          isValid: validationState.isLengthValid, 
          text: "Karakter minimal 8",
        ),
        PasswordValidationItem(
          isValid: validationState.hasUppercase, 
          text: "Satu karakter huruf besar",
        ),
        PasswordValidationItem(
          isValid: validationState.hasLowercase, 
          text: "Satu karakter huruf kecil",
        ),
        PasswordValidationItem(
          isValid: validationState.hasNumber, 
          text: "Satu karakter angka",
        ),
        PasswordValidationItem(
          isValid: validationState.hasSymbol, 
          text: "Satu karakter simbol",
        ),
      ],
    );
  }
}

class ActionButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const ActionButtons({
    super.key,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 37,
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFEAEB),
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            onTap: onCancel,
            child: Center(
              child: Text(
                'Batal',
                style: AppTextStyle.button.copyWith(
                  fontSize: 14,
                  letterSpacing: 0,
                  color: const Color(0xFFD21F28),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 37,
          padding: const EdgeInsets.symmetric(
            horizontal: 26,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF0081FF),
                Color(0xFF025BB1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            onTap: onSave,
            child: Center(
              child: Text(
                'Simpan',
                style: AppTextStyle.button.copyWith(
                  fontSize: 14,
                  letterSpacing: 0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}