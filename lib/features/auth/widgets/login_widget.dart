import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';

class LoginTextField extends ConsumerWidget {
  final TextEditingController controller;
  final String hintText;
  final String iconAsset;
  final String? errorText;
  final bool isPassword;
  final bool isVisible;
  final VoidCallback? onToggleVisibility;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.iconAsset,
    this.errorText,
    this.isPassword = false,
    this.isVisible = false,
    this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
}

class LoginSocialIcon extends StatelessWidget {
  final String assetPath;
  final VoidCallback? onTap;

  const LoginSocialIcon({
    super.key,
    required this.assetPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 22,
      child: GestureDetector(
        onTap: onTap,
        child: Image.asset(assetPath, height: 24, width: 24),
      ),
    );
  }
}

class LoginMessageWidget {
  static void showErrorDialog(BuildContext context, String message) {
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
}