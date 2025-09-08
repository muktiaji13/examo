import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../providers/forgot_password_provider.dart';

class ForgotEmailField extends ConsumerWidget {
  const ForgotEmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      style: AppTextStyle.inputText,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.inputBackground,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            'assets/auth-image/email.png',
            width: 20,
            height: 20,
          ),
        ),
        hintText: 'Email',
        hintStyle: AppTextStyle.inputText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) => ref.read(emailProvider.notifier).state = value,
    );
  }
}

class ForgotPasswordButton extends ConsumerWidget {
  final VoidCallback onPressed;

  const ForgotPasswordButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(emailProvider);
    
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: email.isEmpty ? null : onPressed,
        child: Text('Reset Password', style: AppTextStyle.button),
      ),
    );
  }
}