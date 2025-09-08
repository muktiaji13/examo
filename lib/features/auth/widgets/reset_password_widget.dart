import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../providers/reset_password_provider.dart';

class ResetPasswordField extends ConsumerWidget {
  final String hintText;
  final bool isConfirmPassword;
  final String? errorText;

  const ResetPasswordField({
    super.key,
    required this.hintText,
    this.isConfirmPassword = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obscurePassword = isConfirmPassword
        ? ref.watch(obscureConfirmPasswordProvider)
        : ref.watch(obscurePasswordProvider);

    return TextField(
      obscureText: obscurePassword,
      style: AppTextStyle.inputText,
      onChanged: (val) => isConfirmPassword
          ? ref.read(confirmPasswordProvider.notifier).state = val
          : ref.read(passwordProvider.notifier).state = val,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyle.inputText,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            'assets/auth-image/password.png',
            width: 20,
            height: 20,
          ),
        ),
        suffixIcon: IconButton(
          icon: Image.asset(
            obscurePassword
                ? 'assets/auth-image/eye-off.png'
                : 'assets/auth-image/eye-on.png',
            width: 22,
            height: 22,
          ),
          onPressed: () => isConfirmPassword
              ? ref.read(obscureConfirmPasswordProvider.notifier).state =
                  !obscurePassword
              : ref.read(obscurePasswordProvider.notifier).state =
                  !obscurePassword,
        ),
        errorText: errorText,
        filled: true,
        fillColor: AppColors.inputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class ResetPasswordButton extends ConsumerWidget {
  final VoidCallback onPressed;

  const ResetPasswordButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Ganti Kata Sandi',
          style: AppTextStyle.button,
        ),
      ),
    );
  }
}

class ResetPasswordMessageWidget {
  static void showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password berhasil diganti')),
    );
  }
}