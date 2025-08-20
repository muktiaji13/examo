import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/styles.dart';
import 'reset_password_page.dart';

final emailProvider = StateProvider<String>((ref) => '');

class ForgotPasswordPage extends ConsumerWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(emailProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: AppLayout.maxWidth),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: BackButton(),
                ),
                Image.asset('assets/auth-image/forgot-password.png'),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lupa Kata Sandi?', style: AppTextStyle.title),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Masukkan email kamu dan kami kirimkan link untuk atur ulang sandi.',
                    style: AppTextStyle.subtitle,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
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
                  onChanged: (value) =>
                      ref.read(emailProvider.notifier).state = value,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: email.isEmpty
                        ? null // disable button kalau email kosong
                        : () {
                            // nanti di sini bisa ditambah validasi/logic backend
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ResetPasswordPage(),
                              ),
                            );
                          },
                    child: Text('Reset Password', style: AppTextStyle.button),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
