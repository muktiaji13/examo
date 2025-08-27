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
    with TickerProviderStateMixin {
  bool showNotif = false;
  late AnimationController _notifController;
  late Animation<Offset> _notifOffset;
  final ScrollController _scrollController = ScrollController();

  // gender dropdown
  final List<String> genders = [
    'Laki Laki',
    'Perempuan',
    'Tidak ingin menyebutkan',
  ];
  String? selectedGender = 'Perempuan';
  bool isExpanded = false;
  late AnimationController arrowController;
  late Animation<double> arrowAnimation;
  late AnimationController dropdownController;
  late Animation<double> dropdownAnimation;

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

    arrowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    arrowAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: arrowController, curve: Curves.easeInOut),
    );

    dropdownController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    dropdownAnimation = CurvedAnimation(
      parent: dropdownController,
      curve: Curves.easeInOut,
    );
  }

  void toggleDropdown() {
    setState(() => isExpanded = !isExpanded);
    if (isExpanded) {
      arrowController.forward();
      dropdownController.forward();
    } else {
      arrowController.reverse();
      dropdownController.reverse();
    }
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
    arrowController.dispose();
    dropdownController.dispose();
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
                            buildGenderField(),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
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
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 108,
                                  height: 37,
                                  child: ElevatedButton(
                                    onPressed: showNotification,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
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
                                        borderRadius: BorderRadius.circular(10),
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
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 5,
                      spreadRadius: 0,
                      offset: Offset(0, 0),
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
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            height: 1.0,
            letterSpacing: 0,
            color: Color(0xFF000000), // label color hitam
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: TextEditingController(text: value),
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            height: 1.0,
            letterSpacing: 0,
            color: Color(0xFF777777), // teks input warna #777777
          ),
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            hintText: '',
            hintStyle: TextStyle(
              color: Color(0xFF777777), // hint warna #777777
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFD9D9D9),
              ), // border #D9D9D9
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFD9D9D9),
              ), // border #D9D9D9
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildGenderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Jenis Kelamin',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            height: 1.0,
            letterSpacing: 0,
            color: Color(0xFF000000),
          ),
        ),
        const SizedBox(height: 6),

        // Tombol utama buat buka/tutup dropdown
        GestureDetector(
          onTap: toggleDropdown,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFD9D9D9)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedGender ?? 'Pilih Jenis Kelamin',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    height: 1.0,
                    letterSpacing: 0,
                    color: Color(0xFF777777),
                  ),
                ),
                RotationTransition(
                  turns: arrowAnimation,
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF555555),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Dropdown list
        SizeTransition(
          sizeFactor: dropdownAnimation,
          axisAlignment: -1,
          child: Container(
            margin: const EdgeInsets.only(
              top: 8,
              left: 8,
              right: 8,
              bottom: 8,
            ), // kasih space bawah juga
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x26000000), // #00000026
                  blurRadius: 5, // kecilin shadow
                  spreadRadius: 0, // jangan nyebar kemana2
                  offset: Offset(0, 0), // biar rata semua sisi
                ),
              ],
            ),
            child: Column(
              children: genders.asMap().entries.map((entry) {
                final index = entry.key;
                final g = entry.value;
                final isSelected = g == selectedGender;

                // atur radius khusus untuk item pertama & terakhir
                BorderRadius radius = BorderRadius.zero;
                if (index == 0) {
                  radius = const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  );
                } else if (index == genders.length - 1) {
                  radius = const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  );
                }

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedGender = g;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFE2F1FF)
                          : Colors.transparent,
                      borderRadius: radius,
                    ),
                    child: Text(
                      g,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF777777),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
