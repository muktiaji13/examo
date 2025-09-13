import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../providers/reset_password_provider.dart';
import '../widgets/reset_password_widget.dart';

class ResetPasswordPage extends ConsumerWidget {
  const ResetPasswordPage({super.key});

  void _validateForm(BuildContext context, WidgetRef ref) {
    final password = ref.read(passwordProvider);
    final confirmPassword = ref.read(confirmPasswordProvider);
    
    // reset error
    ref.read(passwordErrorProvider.notifier).state = null;
    ref.read(confirmPasswordErrorProvider.notifier).state = null;
    
    if (password.length < 8) {
      ref.read(passwordErrorProvider.notifier).state =
          'Password minimal harus 8 karakter';
      return;
    }
    
    if (confirmPassword != password) {
      ref.read(confirmPasswordErrorProvider.notifier).state =
          'Password tidak cocok';
      return;
    }
    
    // jika lolos semua
    ResetPasswordMessageWidget.showSuccessMessage(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordError = ref.watch(passwordErrorProvider);
    final confirmPasswordError = ref.watch(confirmPasswordErrorProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: AppLayout.maxWidth),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Image.asset(
                      'assets/auth-image/forgot-password.png',
                      height: 350,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text('Buat Kata Sandi Baru', style: AppTextStyle.title),
                  const SizedBox(height: 8),
                  Text(
                    'Silakan buat kata sandi baru yang aman dan mudah diingat.',
                    style: AppTextStyle.subtitle,
                  ),
                  const SizedBox(height: 24),
                  ResetPasswordField(
                    hintText: 'Kata sandi baru',
                    errorText: passwordError,
                  ),
                  const SizedBox(height: 16),
                  ResetPasswordField(
                    hintText: 'Konfirmasi kata sandi',
                    isConfirmPassword: true,
                    errorText: confirmPasswordError,
                  ),
                  const SizedBox(height: 32),
                  ResetPasswordButton(
                    onPressed: () => _validateForm(context, ref),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}