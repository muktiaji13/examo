import 'package:flutter/material.dart';
import '../../../../config/styles.dart';

/// Fungsi untuk menampilkan modal filter.
/// Modal ini muncul dari bawah dengan animasi slide.
Future<void> showFilterModal(BuildContext context) async {
  await showGeneralDialog(
    context: context,
    barrierLabel: "Filter",
    barrierDismissible: true,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return const SizedBox.shrink();
    },
    transitionBuilder: (context, anim1, anim2, child) {
      final offset = Tween(
        begin: const Offset(0, 1),
        end: const Offset(0, 0),
      ).animate(CurvedAnimation(parent: anim1, curve: Curves.easeOut));
      return SlideTransition(
        position: offset,
        child: const Align(
          alignment: Alignment.bottomCenter,
          child: FilterModal(),
        ),
      );
    },
  );
}

/// Widget utama modal filter.
/// Berisi filter berdasarkan nama paket, tanggal mulai & berakhir, serta status.
class FilterModal extends StatefulWidget {
  const FilterModal({super.key});

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  // State untuk checkbox status paket
  bool aktif = true;
  bool kadaluarsa = false;
  bool pending = false;

  // State untuk checkbox nama paket
  bool gratis = false;
  bool pro = false;
  bool basic = false;
  bool premium = false;

  // State untuk tanggal filter
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        height: 500,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Bagian header modal (judul dan tombol close)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filter",
                  style: AppTextStyle.cardTitle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.black,
                    size: 20,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Bagian filter nama paket
            Text(
              "Nama Paket",
              style: AppTextStyle.cardSubtitle.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPackageCheckbox("Gratis", gratis, (value) => setState(() => gratis = value)),
                      const SizedBox(height: 12),
                      _buildPackageCheckbox("Basic", basic, (value) => setState(() => basic = value)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPackageCheckbox("Pro", pro, (value) => setState(() => pro = value)),
                      const SizedBox(height: 12),
                      _buildPackageCheckbox("Premium", premium, (value) => setState(() => premium = value)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Bagian filter tanggal mulai
            Text(
              "Tanggal Mulai",
              style: AppTextStyle.cardSubtitle.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 6),
            _buildDateField("dd-mm-yy", true),
            const SizedBox(height: 12),

            /// Bagian filter tanggal berakhir
            Text(
              "Tanggal Berakhir",
              style: AppTextStyle.cardSubtitle.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 6),
            _buildDateField("dd-mm-yy", false),
            const SizedBox(height: 16),

            /// Bagian filter status
            Text(
              "Status",
              style: AppTextStyle.cardSubtitle.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            _buildStatusCheckbox("Aktif", aktif, (v) => setState(() => aktif = v)),
            _buildStatusCheckbox("Kadaluarsa", kadaluarsa, (v) => setState(() => kadaluarsa = v)),
            _buildStatusCheckbox("Pending", pending, (v) => setState(() => pending = v)),
            const SizedBox(height: 16),

            /// Tombol untuk menerapkan filter
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Terapkan Filter",
                  style: AppTextStyle.button.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget checkbox khusus untuk filter nama paket
  Widget _buildPackageCheckbox(
    String label,
    bool value,
    Function(bool) onChanged,
  ) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            value ? Icons.check_box : Icons.check_box_outline_blank,
            size: 20,
            color: value ? AppColors.primaryBlue : AppColors.textGrey,
          ),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyle.cardSubtitle.copyWith(color: Colors.black)),
        ],
      ),
    );
  }

  /// Widget checkbox khusus untuk filter status
  Widget _buildStatusCheckbox(
    String label,
    bool value,
    Function(bool) onChanged,
  ) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          Icon(
            value ? Icons.check_box : Icons.check_box_outline_blank,
            size: 20,
            color: value ? AppColors.primaryBlue : AppColors.textGrey,
          ),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyle.cardSubtitle.copyWith(color: Colors.black)),
        ],
      ),
    );
  }

  /// Widget field untuk memilih tanggal (mulai / berakhir)
  Widget _buildDateField(String placeholder, bool isStart) {
    return InkWell(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          setState(() {
            if (isStart) {
              startDate = picked;
            } else {
              endDate = picked;
            }
          });
        }
      },
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.textGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (isStart ? startDate : endDate)?.toString().split(" ")[0] ?? placeholder,
              style: AppTextStyle.inputText.copyWith(color: AppColors.textGrey),
            ),
            const Icon(
              Icons.calendar_month,
              size: 20,
              color: AppColors.textGrey,
            ),
          ],
        ),
      ),
    );
  }
}
