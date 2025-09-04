import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../config/styles.dart';

class RegisterInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? errorText;
  final String iconAsset;
  final VoidCallback? onChanged;

  const RegisterInputField({
    super.key,
    required this.controller,
    required this.hint,
    required this.errorText,
    required this.iconAsset,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
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
}

class RegisterPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isVisible;
  final VoidCallback onToggleVisibility;
  final String? errorText;
  final VoidCallback? onChanged;

  const RegisterPasswordField({
    super.key,
    required this.controller,
    required this.hint,
    required this.isVisible,
    required this.onToggleVisibility,
    required this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
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
}

class RegisterRoleButton extends ConsumerWidget {
  final String role;
  final VoidCallback onTap;
  final bool isSelected;

  const RegisterRoleButton({
    super.key,
    required this.role,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final icon = role == 'Siswa'
        ? PhosphorIcons.student(PhosphorIconsStyle.fill)
        : LineAwesomeIcons.book_reader;
    final Color backgroundColor = isSelected
        ? AppColors.roleButtonSelected
        : AppColors.roleButtonUnselected;
    final Color contentColor = isSelected
        ? AppColors.roleButtonUnselected
        : AppColors.roleButtonSelected;

    return GestureDetector(
      onTap: onTap,
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
}

class RegisterSocialIcon extends StatelessWidget {
  final String assetPath;
  final VoidCallback? onTap;

  const RegisterSocialIcon({
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

class RegisterMessageWidget {
  static void showMessage(
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

// a