import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Image.asset(
            'assets/images/sidebar_icon.png',
            height: 32,
          ),
          const Spacer(),
          Image.asset(
            'assets/images/notif_icon.png',
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/images/profile_pic.png',
              height: 32,
              width: 32,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
