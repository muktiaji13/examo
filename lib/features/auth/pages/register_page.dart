import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../providers/register_provider.dart';
import '../widgets/register_widget.dart';

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
                        RegisterRoleButton(
                          role: 'Siswa',
                          isSelected: state.selectedRole.toLowerCase() == 'siswa',
                          onTap: () {
                            notifier.setRole('siswa');
                            setState(() => roleError = null);
                          },
                        ),
                        const SizedBox(width: 12),
                        RegisterRoleButton(
                          role: 'Guru',
                          isSelected: state.selectedRole.toLowerCase() == 'guru',
                          onTap: () {
                            notifier.setRole('guru');
                            setState(() => roleError = null);
                          },
                        ),
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
                    RegisterInputField(
                      controller: nameController,
                      hint: 'Nama',
                      errorText: nameError,
                      iconAsset: 'assets/auth-image/username.png',
                      onChanged: () => setState(() => nameError = null),
                    ),
                    const SizedBox(height: 16),
                    // Email Field
                    RegisterInputField(
                      controller: emailController,
                      hint: 'Email',
                      errorText: state.emailError,
                      iconAsset: 'assets/auth-image/email.png',
                      onChanged: () => notifier.clearEmailError(),
                    ),
                    const SizedBox(height: 16),
                    // Password Field
                    RegisterPasswordField(
                      controller: passwordController,
                      hint: 'Password',
                      isVisible: state.isPasswordVisible,
                      onToggleVisibility: notifier.togglePasswordVisibility,
                      errorText: passwordError,
                      onChanged: () => setState(() => passwordError = null),
                    ),
                    const SizedBox(height: 16),
                    // Confirm Password Field
                    RegisterPasswordField(
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
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(width: 40, height: 1, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text('Atau Register Dengan', style: AppTextStyle.subtitle),
                        const SizedBox(width: 8),
                        Container(width: 40, height: 1, color: Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RegisterSocialIcon(
                          assetPath: 'assets/auth-image/google.png',
                          onTap: isLoading ? null : _handleGoogleRegister,
                        ),
                        const SizedBox(width: 12),
                        Text('Google', style: AppTextStyle.subtitle),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Sudah punya akun?', style: AppTextStyle.subtitle),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(
                            context,
                            '/login',
                          ),
                          child: Text('Masuk', style: AppTextStyle.link),
                        ),
                      ],
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
      RegisterMessageWidget.showMessage(context, 'Registrasi berhasil!', isSuccess: true);
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      if (!e.toString().contains('Email sudah terdaftar') && 
          !e.toString().contains('Pilih role terlebih dahulu')) {
        RegisterMessageWidget.showMessage(context, 'Terjadi kesalahan: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _handleGoogleRegister() async {
    setState(() => isLoading = true);
    try {
      // TODO: Integrasi Google Sign-In di sini
      // Contoh: final user = await GoogleSignInApi.register();
      // Setelah berhasil, arahkan ke dashboard atau halaman login
      RegisterMessageWidget.showMessage(context, 'Registrasi dengan Google berhasil!', isSuccess: true);
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      RegisterMessageWidget.showMessage(context, 'Registrasi dengan Google gagal: ${e.toString()}');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }
}

// aa