import 'package:flutter/material.dart';
import 'dart:async';
import '../../../config/styles.dart';
import '../../../shared/widgets/app_header.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  bool showNotif = false;
  late AnimationController _notifController;
  late Animation<Offset> _notifOffset;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _notifController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _notifOffset = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0.05),
    ).animate(CurvedAnimation(parent: _notifController, curve: Curves.easeOut));
  }

  void showNotification() {
    _scrollToTop();
    setState(() => showNotif = true);
    _notifController.forward();
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        _notifController.reverse().then((_) {
          if (mounted) setState(() => showNotif = false);
        });
      }
    });
  }

  void hideNotification() {
    _scrollToTop();
    _notifController.reverse().then((_) {
      if (mounted) setState(() => showNotif = false);
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _notifController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFFF4F4F4),
          body: SafeArea(
            child: Column(
              children: [
                AppHeader(),
                Expanded(
                  child: Center(
                    child: Container(
                      width: 400,
                      margin: const EdgeInsets.symmetric(vertical: 40),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                const CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(
                                    'assets/images/profile_pic.png',
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryBlue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    'assets/images/pencil.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Mrs. Yoo Rachel',
                              style: AppTextStyle.cardTitle,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'rachel@gmail.com',
                              style: AppTextStyle.cardSubtitle,
                            ),
                            const SizedBox(height: 20),
                            buildTextField('Username', 'Heesoo Atmaja'),
                            buildTextField('Email', 'heesoo@gmail.com'),
                            buildTextField('No. Telepon', '09876543458'),
                            buildTextField('Jenis Kelamin', 'Perempuan'),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Tombol Batal
                                SizedBox(
                                  width: 108,
                                  height: 37,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xFFFFEAEB),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Batal',
                                        style: AppTextStyle.cardTitleDanger
                                            .copyWith(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10), // jarak antar tombol
                                // Tombol Simpan
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 0,
                                  ), // biar gak nempel kanan
                                  child: SizedBox(
                                    width: 108,
                                    height: 37,
                                    child: ElevatedButton(
                                      onPressed: showNotification,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        padding: EdgeInsets.zero,
                                      ),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF0081FF),
                                              Color(0xFF025BB1),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Simpan',
                                            style: AppTextStyle.button.copyWith(
                                              fontSize: 14,
                                            ),
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
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showNotif)
          SlideTransition(
            position: _notifOffset,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 320,
                height: 70,
                margin: const EdgeInsets.only(top: 40),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF3ED4AF)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFF3ED4AF),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/done.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Edit Profil',
                            style: AppTextStyle.cardTitle.copyWith(
                              fontSize: 14,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Pembaruan profil anda berhasil!',
                            style: AppTextStyle.cardSubtitle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: hideNotification,
                      child: const Icon(
                        Icons.close,
                        color: Colors.black45,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget buildTextField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.blackSubtitle.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: TextEditingController(text: value),
          style: AppTextStyle.inputText,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            isDense: true,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}