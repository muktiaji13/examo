import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primaryBlue = Color(0xFF007BFF);
  static const Color background = Color(0xFFFFFFFF);
  static const Color background2 = Color(0xFFF5F5F5);
  static const Color textGrey = Color(0xFF888888);
  static const Color inputBackground = Color(0xFFF5F8FE);
  static const Color roleButtonUnselected = Color(0xFFEAF5FF);
  static const Color roleButtonSelected = Color(0xFF0081FF);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color dangerRed = Color(0xFFD21F28);
  static const Color successGreen = Color(0xFF2ECC71);
  static const Color lightDanger = Color(0x1AE74C3C);
  static const Color textGrey2 = Color(0xFF555555);
  static const Color textGrey3 = Color(0xFFBEBEBE);
}

class AppTextStyle {
  static TextStyle title = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static TextStyle blueTitle = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryBlue,
  );

  static TextStyle subtitle = GoogleFonts.poppins(
    fontSize: 16,
    color: AppColors.textGrey,
  );

  static TextStyle blackSubtitle = GoogleFonts.poppins(
    fontSize: 16,
    color: AppColors.black,
  );

  static TextStyle inputText = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.textGrey,
  );

  static TextStyle link = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.primaryBlue,
    decoration: TextDecoration.none,
  );

  static TextStyle button = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.white,
  );

  static TextStyle cardTitle = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static TextStyle cardTitleWhite = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static TextStyle cardTitleDanger = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.dangerRed,
  );

  static TextStyle cardSubtitle = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.textGrey,
  );

  static TextStyle menuItem = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.textGrey2,
  );

  static TextStyle menuItemDanger = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.dangerRed,
  );

  static TextStyle sectionTitle = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );

  static TextStyle label = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );

  static TextStyle value = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Color(0xFF4E4E4E),
  );

  static TextStyle featureText = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 18 / 16,
    letterSpacing: -0.17,
    color: Color(0xFF4E4E4E),
  );

  static TextStyle priceLabel = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: Color(0xFF4E4E4E),
  );

  static TextStyle price = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );
}

class AppLayout {
  static const double maxWidth = 1000;
}
