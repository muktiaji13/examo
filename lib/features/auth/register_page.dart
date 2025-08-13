import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../config/styles.dart';
import 'register_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String? nameError;
  String? passwordError;
  String? confirmPasswordError;
  String? roleError;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerFormProvider);
    final notifier = ref.read(registerFormProvider.notifier);

    final nameController = ref.watch(usernameControllerProvider);
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);
    final confirmPasswordController = ref.watch(confirmPasswordControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: AppLayout.maxWidth),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/auth-image/register_image.png',
                      height: 280,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Siap Bergabung?',
                      style: AppTextStyle.title,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ayo buat akun anda sekarang!',
                      style: AppTextStyle.subtitle.copyWith(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    // Role Selection
                    Text('Pilih Role:', style: AppTextStyle.inputText),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildRoleButton(ref, 'Siswa'),
                        const SizedBox(width: 12),
                        _buildRoleButton(ref, 'Guru'),
                      ],
                    ),
                    if (roleError != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        roleError!,
                        style: AppTextStyle.inputText.copyWith(
                          color: AppColors.dangerRed,
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),

                    // Name Field
                    _buildInputField(
                      controller: nameController,
                      hint: 'Nama',
                      errorText: nameError,
                      iconAsset: 'assets/auth-image/username.png',
                      onChanged: () => setState(() => nameError = null),
                    ),
                    const SizedBox(height: 16),

                    // Email Field
                    _buildInputField(
                      controller: emailController,
                      hint: 'Email',
                      errorText: state.emailError,
                      iconAsset: 'assets/auth-image/email.png',
                      onChanged: () => notifier.clearEmailError(),
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    _buildPasswordField(
                      controller: passwordController,
                      hint: 'Password',
                      isVisible: state.isPasswordVisible,
                      onToggleVisibility: notifier.togglePasswordVisibility,
                      errorText: passwordError,
                      onChanged: () => setState(() => passwordError = null),
                    ),
                    const SizedBox(height: 16),

                    // Confirm Password Field
                    _buildPasswordField(
                      controller: confirmPasswordController,
                      hint: 'Konfirmasi Password',
                      isVisible: state.isConfirmPasswordVisible,
                      onToggleVisibility: notifier.toggleConfirmPasswordVisibility,
                      errorText: confirmPasswordError,
                      onChanged: () => setState(() => confirmPasswordError = null),
                    ),
                    const SizedBox(height: 24),

                    // Register Button
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : () => _handleRegister(ref, context),
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
                            : Text('Register', style: AppTextStyle.button),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleRegister(WidgetRef ref, BuildContext context) async {
    final notifier = ref.read(registerFormProvider.notifier);
    final state = ref.read(registerFormProvider);
    final nameController = ref.read(usernameControllerProvider);
    final emailController = ref.read(emailControllerProvider);
    final passwordController = ref.read(passwordControllerProvider);
    final confirmPasswordController = ref.read(confirmPasswordControllerProvider);

    setState(() {
      nameError = null;
      passwordError = null;
      confirmPasswordError = null;
      roleError = null;
      isLoading = true;
    });

    // Field validations
    bool isValid = true;
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final role = state.selectedRole;

    // Name validation
    if (name.isEmpty) {
      setState(() => nameError = 'Nama wajib diisi');
      isValid = false;
    } else if (!RegExp(r'^[a-zA-Z. ]+$').hasMatch(name)) {
      setState(() => nameError = 'Nama hanya boleh berisi huruf');
      isValid = false;
    }

    // Email validation
    if (email.isEmpty) {
      notifier.setEmailError('Email wajib diisi');
      isValid = false;
    } else if (!email.contains('@')) {
      notifier.setEmailError('Harap sertakan @ dalam email');
      isValid = false;
    } else if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
      notifier.setEmailError('Format email tidak valid');
      isValid = false;
    }

    // Password validation
    if (password.isEmpty) {
      setState(() => passwordError = 'Password wajib diisi');
      isValid = false;
    } else if (!RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d])[A-Za-z\d\S]{8,}$',
    ).hasMatch(password)) {
      setState(() => passwordError = 'Password harus 8 karakter, huruf besar, kecil, angka & simbol');
      isValid = false;
    }

    // Confirm password validation
    if (confirmPassword != password) {
      setState(() => confirmPasswordError = 'Konfirmasi password tidak cocok');
      isValid = false;
    }

    // Role validation
    if (role.isEmpty) {
      setState(() => roleError = 'Pilih role terlebih dahulu');
      isValid = false;
    }

    if (!isValid) {
      setState(() => isLoading = false);
      return;
    }

    try {
      await notifier.register(
        name: name,
        email: email,
        password: password,
        context: context,
      );

      _showMessage(context, 'Registrasi berhasil!', isSuccess: true);
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      if (!e.toString().contains('Email sudah terdaftar') && 
          !e.toString().contains('Pilih role terlebih dahulu')) {
        _showMessage(context, 'Terjadi kesalahan: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required String? errorText,
    required String iconAsset,
    VoidCallback? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          onChanged: (_) => onChanged?.call(),
          style: AppTextStyle.inputText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyle.inputText,
            filled: true,
            fillColor: AppColors.inputBackground,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(iconAsset, width: 20, height: 20),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            errorText: errorText,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
    required String? errorText,
    VoidCallback? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: !isVisible,
          onChanged: (_) => onChanged?.call(),
          style: AppTextStyle.inputText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyle.inputText,
            filled: true,
            fillColor: AppColors.inputBackground,
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
                isVisible
                    ? 'assets/auth-image/eye-on.png'
                    : 'assets/auth-image/eye-off.png',
                width: 22,
                height: 22,
              ),
              onPressed: onToggleVisibility,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            errorText: errorText,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoleButton(WidgetRef ref, String role) {
    final state = ref.watch(registerFormProvider);
    final notifier = ref.read(registerFormProvider.notifier);
    final isSelected = state.selectedRole.toLowerCase() == role.toLowerCase();
    final icon = role == 'Siswa'
        ? PhosphorIcons.studentFill
        : LineAwesomeIcons.book_reader;

    final Color backgroundColor = isSelected
        ? AppColors.roleButtonSelected
        : AppColors.roleButtonUnselected;
    final Color contentColor = isSelected
        ? AppColors.roleButtonUnselected
        : AppColors.roleButtonSelected;

    return GestureDetector(
      onTap: () {
        notifier.setRole(role.toLowerCase());
        setState(() => roleError = null);
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: contentColor, size: 28),
            const SizedBox(height: 4),
            Text(
              role,
              style: TextStyle(
                color: contentColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(
    BuildContext context,
    String message, {
    bool isSuccess = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}