import 'package:flutter/material.dart';
import '../../../config/styles.dart';

class ProfileCard extends StatelessWidget {
  final VoidCallback onEditProfile;
  final VoidCallback onChangePassword;
  final VoidCallback onTerms;
  final VoidCallback onHelp;
  final VoidCallback onLogout;
  
  const ProfileCard({
    super.key,
    required this.onEditProfile,
    required this.onChangePassword,
    required this.onTerms,
    required this.onHelp,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundImage: const AssetImage('assets/images/profile_pic.png'),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0081FF),
                  ),
                  child: Image.asset(
                    'assets/images/pencil.png',
                    width: 14,
                    height: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Mrs. Yoo Rachel', style: AppTextStyle.cardTitle),
            const SizedBox(height: 4),
            Text('rachel@gmail.com', style: AppTextStyle.cardSubtitle),
            const SizedBox(height: 24),
            ProfileMenuItem(
              title: 'Edit Profil',
              iconPath: 'assets/images/edit_user.png',
              onTap: onEditProfile,
            ),
            ProfileMenuItem(
              title: 'Ubah Password',
              iconPath: 'assets/images/password_lock.png',
              onTap: onChangePassword,
            ),
            ProfileMenuItem(
              title: 'Syarat dan Ketentuan',
              iconPath: 'assets/images/newspaper.png',
              onTap: onTerms,
            ),
            const ProfileMenuItem(
              title: 'Tentang Examo',
              iconPath: 'assets/images/about.png',
            ),
            ProfileMenuItem(
              title: 'Bantuan',
              iconPath: 'assets/images/help.png',
              onTap: onHelp,
            ),
            ProfileMenuItem(
              title: 'Keluar',
              iconPath: 'assets/images/logout.png',
              onTap: onLogout,
              style: AppTextStyle.menuItemDanger,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final TextStyle? style;
  final VoidCallback? onTap;
  
  const ProfileMenuItem({
    super.key,
    required this.title,
    required this.iconPath,
    this.style,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Image.asset(iconPath, width: 24, height: 24),
            const SizedBox(width: 16),
            Expanded(child: Text(title, style: style ?? AppTextStyle.menuItem)),
            Image.asset(
              'assets/images/arrow_right.png',
              width: 20,
              height: 20,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }
}

class LogoutDialog extends StatelessWidget {
  final bool isLoggingOut;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  
  const LogoutDialog({
    super.key,
    required this.isLoggingOut,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 32,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 18),
          Text(
            'Keluar',
            style: AppTextStyle.cardTitle.copyWith(
              color: const Color(0xFFD21F28),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Apakah Anda yakin ingin keluar dari aplikasi ini?',
            textAlign: TextAlign.center,
            style: AppTextStyle.cardSubtitle.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 28),
          isLoggingOut
              ? const CircularProgressIndicator()
              : Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: onCancel,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: const Color(0x1AE74C3C),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Batal',
                              style: AppTextStyle.button.copyWith(
                                color: const Color(0xFFD21F28),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: onConfirm,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD21F28),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Keluar',
                              style: AppTextStyle.button.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}