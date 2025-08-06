import 'package:flutter/material.dart';

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
  static const Color lightDanger = Color(0x1AE74C3C);
  static const Color textGrey2 = Color(0xFF555555);
}

class AppTextStyle {
  static TextStyle title = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static TextStyle blueTitle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryBlue,
  );

  static TextStyle subtitle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    color: AppColors.textGrey,
  );

  static TextStyle blackSubtitle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    color: AppColors.black,
  );

  static TextStyle inputText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    color: AppColors.textGrey,
  );

  static TextStyle link = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    color: AppColors.primaryBlue,
    decoration: TextDecoration.none,
  );

  static TextStyle button = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.white,
  );

  static TextStyle cardTitle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static TextStyle cardTitleWhite = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static TextStyle cardTitleDanger = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.dangerRed,
  );

  static TextStyle cardSubtitle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    color: AppColors.textGrey,
  );

  static TextStyle menuItem = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.textGrey2,
  );

  static TextStyle menuItemDanger = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.dangerRed,
  );
}

class AppLayout {
  static const double maxWidth = 1000;
}
