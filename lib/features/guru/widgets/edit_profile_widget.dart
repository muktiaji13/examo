import 'package:flutter/material.dart';
import '../../../config/styles.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class ProfileTextField extends StatelessWidget {
  final String label;
  final String value;

  const ProfileTextField({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.label.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: TextEditingController(text: value),
          style: AppTextStyle.inputText.copyWith(
            fontSize: 16,
            color: AppColors.textGrey,
          ),
          cursorColor: AppColors.black,
          decoration: InputDecoration(
            hintText: '',
            hintStyle: AppTextStyle.inputText.copyWith(
              color: AppColors.textGrey,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
              borderRadius: BorderRadius.circular(8),
            ),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class GenderDropdown extends StatelessWidget {
  final List<String> genders;
  final String? selectedGender;
  final bool isExpanded;
  final Animation<double> arrowAnimation;
  final Animation<double> dropdownAnimation;
  final VoidCallback onToggle;
  final Function(String) onGenderSelected;

  const GenderDropdown({
    super.key,
    required this.genders,
    required this.selectedGender,
    required this.isExpanded,
    required this.arrowAnimation,
    required this.dropdownAnimation,
    required this.onToggle,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jenis Kelamin',
          style: AppTextStyle.label.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 6),
        // Tombol utama buat buka/tutup dropdown
        GestureDetector(
          onTap: onToggle,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFD9D9D9)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedGender ?? 'Pilih Jenis Kelamin',
                  style: AppTextStyle.inputText.copyWith(
                    fontSize: 16,
                    color: AppColors.textGrey,
                  ),
                ),
                RotationTransition(
                  turns: arrowAnimation,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.textGrey2,
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
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: genders.asMap().entries.map((entry) {
                final index = entry.key;
                final g = entry.value;
                final isSelected = g == selectedGender;
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
                  onTap: () => onGenderSelected(g),
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
                      style: AppTextStyle.value.copyWith(
                        fontSize: 14,
                        color: AppColors.textGrey,
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

class ProfileNotification extends StatelessWidget {
  final Animation<Offset> slideAnimation;
  final VoidCallback onClose;

  const ProfileNotification({
    super.key,
    required this.slideAnimation,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 320,
          height: 76,
          margin: const EdgeInsets.only(top: 40),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
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
                width: 10,
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF3ED4AF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE4FFF8),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFFCAFFF2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      TablerIcons.circle_check_filled,
                      color: Color(0xFF3ED4AF),
                      size: 22,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                onTap: onClose,
                child: Icon(Icons.close, color: AppColors.textGrey2, size: 18),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileActionButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const ProfileActionButtons({
    super.key,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 108,
          height: 37,
          child: TextButton(
            onPressed: onCancel,
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFFFEAEB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Center(
              child: Text(
                'Batal',
                style: AppTextStyle.cardTitleDanger.copyWith(fontSize: 14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 108,
          height: 37,
          child: ElevatedButton(
            onPressed: onSave,
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
                  colors: [Color(0xFF0081FF), Color(0xFF025BB1)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Simpan',
                  style: AppTextStyle.button.copyWith(fontSize: 14),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
