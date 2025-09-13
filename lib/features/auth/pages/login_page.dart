import 'package:examo/core/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../providers/login_provider.dart';
import '../widgets/login_widget.dart';
import 'forgot_password_page.dart';
import '../../../core/api_service.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? emailError;
  String? passwordError;
  String? authError; 
  bool isLoading = false;

  void _validateAndLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    
    setState(() {
      emailError = null;
      passwordError = null;
      authError = null;
    });
    
    // Field validation
    if (email.isEmpty) emailError = 'Email tidak boleh kosong';
    if (!emailRegex.hasMatch(email) && email.isNotEmpty)
      emailError = 'Format email tidak valid';
    if (password.isEmpty) passwordError = 'Password tidak boleh kosong';
    if (password.length < 8 && password.isNotEmpty)
      passwordError = 'Password minimal 8 karakter';
    
    if (emailError != null || passwordError != null) {
      setState(() {});
      return;
    }
    
    setState(() => isLoading = true);
    
    try {
      final user = await ApiService.loginUser(email: email, password: password);
      final role = user.role;
      await ref.read(authProvider.notifier).login(email, password);
      
      if (role == 'guru') {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (role == 'user') {
        Navigator.pushReplacementNamed(context, '/dashboard-siswa');
      } else {
        LoginMessageWidget.showErrorDialog(context, 'Role tidak dikenali');
      }
    } catch (e) {
      setState(() {
        authError = 'Email atau Password salah';
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _handleGoogleLogin() async {
    setState(() => isLoading = true);
    try {
      // TODO: Integrasi Google Sign-In
      LoginMessageWidget.showErrorDialog(context, 'Login dengan Google berhasil!');
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    } catch (e) {
      LoginMessageWidget.showErrorDialog(context, 'Login dengan Google gagal: ${e.toString()}');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = ref.watch(passwordVisibilityProvider);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: AppLayout.maxWidth),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset('assets/auth-image/login_image.png', height: 240),
                  const SizedBox(height: 24),
                  Text(
                    'Selamat datang!',
                    style: AppTextStyle.title,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Masuk untuk menikmati layanan kami',
                    style: AppTextStyle.subtitle.copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  LoginTextField(
                    controller: emailController,
                    hintText: 'Email',
                    errorText: emailError,
                    iconAsset: 'assets/auth-image/email.png',
                  ),
                  const SizedBox(height: 16),
                  LoginTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    errorText: authError ?? passwordError,
                    isPassword: true,
                    isVisible: isPasswordVisible,
                    onToggleVisibility: () {
                      ref.read(passwordVisibilityProvider.notifier).state =
                          !isPasswordVisible;
                    },
                    iconAsset: 'assets/auth-image/password.png',
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ForgotPasswordPage(),
                        ),
                      ),
                      child: Text('Lupa Password?', style: AppTextStyle.link),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 333,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _validateAndLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          : Text('Login', style: AppTextStyle.button),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(width: 40, height: 1, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text('Atau Login Dengan', style: AppTextStyle.subtitle),
                      const SizedBox(width: 8),
                      Container(width: 40, height: 1, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginSocialIcon(
                        assetPath: 'assets/auth-image/google.png',
                        onTap: isLoading ? null : _handleGoogleLogin,
                      ),
                      const SizedBox(width: 12),
                      Text('Google', style: AppTextStyle.subtitle),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Belum punya akun?', style: AppTextStyle.subtitle),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(
                          context,
                          '/register',
                        ),
                        child: Text('Daftar', style: AppTextStyle.link),
                      ),
                    ],
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