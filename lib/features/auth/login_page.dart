import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config/styles.dart';
import 'login_provider.dart';
import 'forgot_password_page.dart';
import '../guru/pages/dashboard_page.dart';
import '../siswa/pages/dashboard_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? emailError;
  String? passwordError;
  String? authError; // New error for combined authentication errors
  bool isLoading = false;

  void _validateAndLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

    setState(() {
      emailError = null;
      passwordError = null;
      authError = null; // Reset auth error
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
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/login'),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password},
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200 && data['token'] != null) {
        final role = data['user']['role'];

        if (role == 'guru') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage()),
          );
        } else if (role == 'user') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => DashboardPage()),
          );
        } else {
          _showErrorDialog('Role tidak dikenali');
        }
      } else {
        setState(() {
          // Combine email/password errors into one message under password field
          authError = 'Email atau Password salah';
        });
      }
    } catch (e) {
      _showErrorDialog('Terjadi kesalahan koneksi');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Login Gagal'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
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
                  _buildTextField(
                    controller: emailController,
                    hintText: 'Email',
                    errorText: emailError,
                    iconAsset: 'assets/auth-image/email.png',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    errorText:
                        authError ??
                        passwordError, // Show auth error here if exists
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
                      _buildSocialIcon('assets/auth-image/google.png'),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String iconAsset,
    String? errorText,
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? onToggleVisibility,
  }) {
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: isPassword && !isVisible,
          style: AppTextStyle.inputText,
          cursorColor: AppColors.primaryBlue,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyle.inputText,
            filled: true,
            fillColor: AppColors.inputBackground,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(iconAsset, width: 20, height: 20),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Image.asset(
                      isVisible
                          ? 'assets/auth-image/eye-on.png'
                          : 'assets/auth-image/eye-off.png',
                      width: 22,
                      height: 22,
                    ),
                    onPressed: onToggleVisibility,
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: hasError
                  ? const BorderSide(color: Colors.red)
                  : BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: hasError
                  ? const BorderSide(color: Colors.red)
                  : const BorderSide(color: AppColors.primaryBlue),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildSocialIcon(String assetPath) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 22,
      child: Image.asset(assetPath, height: 24, width: 24),
    );
  }
}
