import 'package:flutter/material.dart';
import '../../../config/styles.dart';
import '../../../shared/widgets/app_header.dart';

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({super.key});

  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  bool isLengthValid = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasNumber = false;
  bool hasSymbol = false;

  void validatePassword(String password) {
    setState(() {
      isLengthValid = password.length >= 8;
      hasUppercase = password.contains(RegExp(r'[A-Z]'));
      hasLowercase = password.contains(RegExp(r'[a-z]'));
      hasNumber = password.contains(RegExp(r'[0-9]'));
      hasSymbol = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  InputBorder buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: 1),
    );
  }

  Widget buildValidationItem(bool condition, String text) {
    return Row(
      children: [
        Image.asset(
          condition ? 'assets/images/tick.png' : 'assets/images/cross.png',
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: AppTextStyle.cardSubtitle.copyWith(
            color: condition ? Color(0xFF2ECC71) : Color(0xFFD21F28),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final newPassword = newPasswordController.text;

    Color getFieldBorderColor(String value, bool allValid) {
      if (value.isEmpty) return Color(0xFFD9D9D9);
      return allValid ? Color(0xFF2ECC71) : Color(0xFFD21F28);
    }

    final allValid =
        isLengthValid && hasUppercase && hasLowercase && hasNumber && hasSymbol;

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(title: 'Ubah Password'),
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
                        TextField(
                          controller: oldPasswordController,
                          obscureText: true,
                          readOnly: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: Image.asset(
                              'assets/auth-image/eye-off.png',
                            ),
                            enabledBorder: buildBorder(Color(0xFF2ECC71)),
                            focusedBorder: buildBorder(Color(0xFF2ECC71)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Password Baru",
                          style: AppTextStyle.blackSubtitle,
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: newPasswordController,
                          obscureText: !isNewPasswordVisible,
                          onChanged: validatePassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'abcdefgh',
                            hintStyle: AppTextStyle.inputText,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isNewPasswordVisible = !isNewPasswordVisible;
                                });
                              },
                              child: Image.asset(
                                isNewPasswordVisible
                                    ? 'assets/auth-image/eye-on.png'
                                    : 'assets/auth-image/eye-off.png',
                              ),
                            ),
                            enabledBorder: buildBorder(
                              getFieldBorderColor(newPassword, allValid),
                            ),
                            focusedBorder: buildBorder(
                              getFieldBorderColor(newPassword, allValid),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Tambahkan semua karakter yang diperlukan untuk membuat kata sandi yang aman:",
                          style: AppTextStyle.cardSubtitle.copyWith(
                            color: Color(0xFFD21F28),
                          ),
                        ),
                        const SizedBox(height: 8),
                        buildValidationItem(
                          isLengthValid,
                          "Karakter minimal 8",
                        ),
                        buildValidationItem(
                          hasUppercase,
                          "Satu karakter huruf besar",
                        ),
                        buildValidationItem(
                          hasLowercase,
                          "Satu karakter huruf kecil",
                        ),
                        buildValidationItem(hasNumber, "Satu karakter angka"),
                        buildValidationItem(hasSymbol, "Satu karakter simbol"),
                        const SizedBox(height: 20),
                        Text(
                          "Password Baru",
                          style: AppTextStyle.blackSubtitle,
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: confirmPasswordController,
                          obscureText: !isConfirmPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Konfirmasi Password',
                            hintStyle: AppTextStyle.inputText,
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isConfirmPasswordVisible =
                                      !isConfirmPasswordVisible;
                                });
                              },
                              child: Image.asset(
                                isConfirmPasswordVisible
                                    ? 'assets/auth-image/eye-on.png'
                                    : 'assets/auth-image/eye-off.png',
                              ),
                            ),
                            enabledBorder: buildBorder(Color(0xFFD9D9D9)),
                            focusedBorder: buildBorder(Color(0xFF2ECC71)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 37,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFEAEB),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Center(
                                  child: Text(
                                    'Batal',
                                    style: AppTextStyle.button.copyWith(
                                      fontSize: 14,
                                      letterSpacing: 0,
                                      color: Color(0xFFD21F28),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 37,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 26,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF0081FF),
                                    Color(0xFF025BB1),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Simpan',
                                  style: AppTextStyle.button.copyWith(
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
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