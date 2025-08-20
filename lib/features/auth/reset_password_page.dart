import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/styles.dart';

// Providers untuk state
final passwordProvider = StateProvider<String>((ref) => '');
final confirmPasswordProvider = StateProvider<String>((ref) => '');
final obscurePasswordProvider = StateProvider<bool>((ref) => true);
final obscureConfirmPasswordProvider = StateProvider<bool>((ref) => true);
final passwordErrorProvider = StateProvider<String?>((ref) => null);
final confirmPasswordErrorProvider = StateProvider<String?>((ref) => null);

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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password berhasil diganti')),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obscurePassword = ref.watch(obscurePasswordProvider);
    final obscureConfirmPassword = ref.watch(obscureConfirmPasswordProvider);
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
                  TextField(
                    obscureText: obscurePassword,
                    style: AppTextStyle.inputText,
                    onChanged: (val) =>
                        ref.read(passwordProvider.notifier).state = val,
                    decoration: InputDecoration(
                      hintText: 'Kata sandi baru',
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
                        onPressed: () => ref
                            .read(obscurePasswordProvider.notifier)
                            .state = !obscurePassword,
                      ),
                      errorText: passwordError,
                      filled: true,
                      fillColor: AppColors.inputBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    obscureText: obscureConfirmPassword,
                    style: AppTextStyle.inputText,
                    onChanged: (val) =>
                        ref.read(confirmPasswordProvider.notifier).state = val,
                    decoration: InputDecoration(
                      hintText: 'Konfirmasi kata sandi',
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
                          obscureConfirmPassword
                              ? 'assets/auth-image/eye-off.png'
                              : 'assets/auth-image/eye-on.png',
                          width: 22,
                          height: 22,
                        ),
                        onPressed: () => ref
                            .read(obscureConfirmPasswordProvider.notifier)
                            .state = !obscureConfirmPassword,
                      ),
                      errorText: confirmPasswordError,
                      filled: true,
                      fillColor: AppColors.inputBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _validateForm(context, ref),
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
