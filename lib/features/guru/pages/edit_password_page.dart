import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../../../shared/widgets/app_header.dart';
import '../providers/edit_password_provider.dart';
import '../widgets/edit_password_widget.dart';

class EditPasswordPage extends ConsumerStatefulWidget {
  const EditPasswordPage({super.key});

  @override
  ConsumerState<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends ConsumerState<EditPasswordPage> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Color getFieldBorderColor(String value, bool allValid) {
    if (value.isEmpty) return const Color(0xFFD9D9D9);
    return allValid ? const Color(0xFF2ECC71) : const Color(0xFFD21F28);
  }

  @override
  Widget build(BuildContext context) {
    final validationState = ref.watch(passwordValidationProvider);
    final newPassword = newPasswordController.text;
    final allValid = validationState.isLengthValid &&
        validationState.hasUppercase &&
        validationState.hasLowercase &&
        validationState.hasNumber &&
        validationState.hasSymbol;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.white,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password Lama",
                          style: AppTextStyle.blackSubtitle,
                        ),
                        const SizedBox(height: 8),
                        PasswordField(
                          controller: oldPasswordController,
                          hintText: '',
                          obscureText: true,
                          readOnly: true,
                          borderColor: const Color(0xFF2ECC71),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Password Baru",
                          style: AppTextStyle.blackSubtitle,
                        ),
                        const SizedBox(height: 8),
                        PasswordField(
                          controller: newPasswordController,
                          hintText: 'abcdefgh',
                          obscureText: !validationState.isNewPasswordVisible,
                          onToggleVisibility: () {
                            ref.read(passwordValidationProvider.notifier).toggleNewPasswordVisibility();
                          },
                          onChanged: (value) { // Menambahkan parameter onChanged yang hilang
                            ref.read(passwordValidationProvider.notifier).validatePassword(value);
                          },
                          borderColor: getFieldBorderColor(newPassword, allValid),
                        ),
                        const SizedBox(height: 12),
                        const PasswordValidationRules(),
                        const SizedBox(height: 20),
                        Text(
                          "Password Baru",
                          style: AppTextStyle.blackSubtitle,
                        ),
                        const SizedBox(height: 8),
                        PasswordField(
                          controller: confirmPasswordController,
                          hintText: 'Konfirmasi Password',
                          obscureText: !validationState.isConfirmPasswordVisible,
                          onToggleVisibility: () {
                            ref.read(passwordValidationProvider.notifier).toggleConfirmPasswordVisibility();
                          },
                        ),
                        const SizedBox(height: 30),
                        ActionButtons(
                          onCancel: () => Navigator.pop(context),
                          onSave: () {
                            // Handle save password
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}