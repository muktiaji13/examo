import 'package:flutter/material.dart';
import '../../config/styles.dart';

class AppHeader extends StatelessWidget {
  final String? title;
  final bool showBack;
  final VoidCallback? onBack;
  final VoidCallback? onMenuTap;
  final String? profilePic;
  final double height;

  const AppHeader({
    super.key,
    this.title,
    this.showBack = false,
    this.onBack,
    this.onMenuTap,
    this.profilePic,
    this.height = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            if (showBack)
              GestureDetector(
                onTap: onBack ?? () => Navigator.of(context).maybePop(),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    'assets/images/arrow-back.png',
                    height: 24,
                  ),
                ),
              )
            else
              GestureDetector(
                onTap: onMenuTap,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    'assets/images/sidebar_icon.png',
                    height: 24,
                  ),
                ),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title ?? '',
                style: AppTextStyle.title.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  profilePic ?? 'assets/images/profile_pic.png',
                ),
                radius: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
