import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  AppColors._();

  static const Color bg            = Color(0xFF0E0E0E);
  static const Color surface       = Color(0xFF212121);
  static const Color surface1      = Color(0xFF3B3B3B);
  static const Color card          = Color(0xFF222222);
  static const Color card1         = Color(0xFF34404B);
  static const Color accent        = Color(0xFF8ECAFF);
  static const Color divider       = Color(0xFF2A2A2A);
  static const Color textPrimary   = Colors.white;
  static const Color textPrimary1  = Color(0x3C3C4333);
  static const Color textSecondary = Color(0xFF8F8F8F);
  static const Color textSecondary1 = Color(0xFF6A635C);
  static const Color positive      = Color(0xFF8ECAFF);
  static const Color negative      = Colors.redAccent;
}

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get heading => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 17.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get sectionTitle => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get metricValue => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get metricLabel => TextStyle(
    color: AppColors.textSecondary,
    fontSize: 11.sp,
  );

  static TextStyle get tabActive => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get tabInactive => TextStyle(
    color: AppColors.textSecondary,
    fontSize: 13.sp,
  );

  static TextStyle get rangeActive => TextStyle(
    color: Colors.black,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get rangeInactive => TextStyle(
    color: AppColors.textSecondary,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get bodyPrimary => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 13.sp,
  );

  static TextStyle get bodySecondary => TextStyle(
    color: AppColors.textSecondary,
    fontSize: 13.sp,
  );

  static TextStyle get caption => TextStyle(
    color: AppColors.textSecondary,
    fontSize: 11.sp,
  );

  static TextStyle get chartLabel => TextStyle(
    color: AppColors.textSecondary,
    fontSize: 9.sp,
  );

  static TextStyle get changeText => TextStyle(fontSize: 10.sp);

  static TextStyle get dateLabel => TextStyle(
    color: AppColors.textSecondary,
    fontSize: 10.sp,
  );
}