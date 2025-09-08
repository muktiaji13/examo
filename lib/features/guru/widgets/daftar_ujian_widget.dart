import 'package:flutter/material.dart';
import '../../../config/styles.dart';

class DaftarUjianSearchBar extends StatelessWidget {
  const DaftarUjianSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          hintText: 'Telusuri',
          hintStyle: AppTextStyle.inputText,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              'assets/images/search_icon.png',
              width: 20,
              height: 20,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class DaftarUjianActionButtons extends StatelessWidget {
  final VoidCallback onTambahUjian;

  const DaftarUjianActionButtons({
    super.key,
    required this.onTambahUjian,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.roleButtonSelected,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: onTambahUjian,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/plus.png',
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Tambah Ujian',
                  style: AppTextStyle.button,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Text(
                  'Filter',
                  style: AppTextStyle.inputText,
                ),
                const SizedBox(width: 4),
                Image.asset(
                  'assets/images/arrow_down.png',
                  height: 16,
                  width: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DaftarUjianCard extends StatelessWidget {
  final Map<String, String> item;
  final VoidCallback? onDetailTap;

  const DaftarUjianCard({
    super.key,
    required this.item,
    this.onDetailTap,
  });

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    Color textColor;
    Color? buttonTop;
    Color? buttonBottom;
    bool isDisabled = false;

    switch (item['status']) {
      case 'Aktif':
        badgeColor = const Color(0xFFE9FFF2);
        textColor = const Color(0xFF2ECC71);
        buttonTop = AppColors.primaryBlue;
        buttonBottom = const Color(0xFF025BB1);
        break;
      case 'Berlangsung':
        badgeColor = const Color(0xFFFFF9E5);
        textColor = const Color(0xFFF8BD00);
        buttonTop = AppColors.primaryBlue;
        buttonBottom = const Color(0xFF025BB1);
        break;
      default:
        badgeColor = const Color(0xFFFFEAEB);
        textColor = const Color(0xFFD21F28);
        isDisabled = true;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: const Color(0xFFEBEBEB)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: const Color(0xFFD5EDFF),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(child: Image.asset(item['image']!, height: 80)),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    item['title']!,
                    style: AppTextStyle.blackSubtitle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    item['status']!,
                    style: AppTextStyle.menuItem.copyWith(
                      color: textColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(item['questions']!, style: AppTextStyle.cardSubtitle),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: isDisabled ? null : onDetailTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: isDisabled
                            ? null
                            : LinearGradient(
                                colors: [buttonTop!, buttonBottom!],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                        color: isDisabled ? const Color(0xFFDADADA) : null,
                      ),
                      child: Center(
                        child: Text('Selengkapnya', style: AppTextStyle.button),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEAEB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Image.asset('assets/images/trash.png', height: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}