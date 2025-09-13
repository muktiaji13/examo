import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/styles.dart';

final profilePicProvider = StateProvider<String?>((ref) => null);

class AppHeader extends ConsumerWidget {
  final bool showBack;
  final VoidCallback? onBack;
  final VoidCallback? onMenuTap;
  final double height;

  const AppHeader({
    super.key,
    this.showBack = false,
    this.onBack,
    this.onMenuTap,
    this.height = 80,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilePic = ref.watch(profilePicProvider);

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
            const Spacer(),
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
