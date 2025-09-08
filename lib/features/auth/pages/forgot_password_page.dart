import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../widgets/forgot_password_widget.dart';
import 'reset_password_page.dart';

class ForgotPasswordPage extends ConsumerWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                const ForgotEmailField(),
                const SizedBox(height: 24),
                ForgotPasswordButton(
                  onPressed: () {
                    // TODO: tambah validasi/logic
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetPasswordPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}