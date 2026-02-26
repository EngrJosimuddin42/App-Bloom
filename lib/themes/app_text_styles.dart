import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Display / Hero
  static TextStyle get displayLarge => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static TextStyle get displayMedium => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 26.sp,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static TextStyle get displaySmall => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  //Heading
  static TextStyle get headingLarge => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get heading => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 17.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get headingSmall => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
  );

  // Section / Label
  static TextStyle get sectionTitle => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get sectionTitleSecondary => TextStyle(
    color: AppColors.textSecondary,
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
  );

  //Metric / Stats
  static TextStyle get metricValue => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get metricValueLarge => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get metricLabel => TextStyle(
    color: AppColors.textSecondary,
    fontSize: 11.sp,
  );

  // Body
  static TextStyle get bodyLarge => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 15.sp,
    height: 1.5,
  );

  static TextStyle get bodyPrimary => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 13.sp,
    height: 1.5,
  );

  static TextStyle get bodySecondary => TextStyle(
    color: AppColors.textSecondary2,
    fontSize: 16.sp,
    height: 1.5,
  );

  static TextStyle get bodyMedium => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );

  // Tab
  static TextStyle get tabActive => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get tabInactive => TextStyle(
    color: AppColors.textSecondary,
    fontSize: 13.sp,
  );

  // Range / Chip
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

  // Button
  static TextStyle get buttonLarge => TextStyle(
    color: AppColors.textWhite,
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get buttonMedium => TextStyle(
    color: AppColors.textWhite,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get buttonSmall => TextStyle(
    color: AppColors.textWhite,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get buttonOutlined => TextStyle(
    color: AppColors.primary,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
  );

  //  Input / Form
  static TextStyle get inputText => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 14.sp,
  );

  static TextStyle get inputHint => TextStyle(
    color: AppColors.textHint,
    fontSize: 14.sp,
  );

  static TextStyle get inputLabel => TextStyle(
    color: AppColors.textSecondary,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get inputError => TextStyle(
    color: AppColors.error,
    fontSize: 11.sp,
  );

  // Caption / Small
  static TextStyle get caption => TextStyle(
    color: AppColors.textSecondary1,
    fontSize: 11.sp,
  );

  static TextStyle get captionPrimary => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 11.sp,
  );

  static TextStyle get captionBold => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
  );

  // Chart / Graph
  static TextStyle get chartLabel => TextStyle(
    color: AppColors.textSecondary,
    fontSize: 9.sp,
  );

  static TextStyle get chartValue => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
  );

  // Date / Time
  static TextStyle get dateLabel => TextStyle(
    color: AppColors.textSecondary,
    fontSize: 10.sp,
  );

  static TextStyle get timeLabel => TextStyle(
    color: AppColors.textSecondary,
    fontSize: 11.sp,
  );

  // Change / Badge / Tag
  static TextStyle get changeText => TextStyle(
    fontSize: 10.sp,
  );

  static TextStyle get badgeText => TextStyle(
    color: AppColors.textWhite,
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get tagText => TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
  );

  // Navigation / AppBar
  static TextStyle get appBarTitle => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 17.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get navLabel => TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
  );

  // Link
  static TextStyle get link => TextStyle(
    color: AppColors.primary,
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.primary,
  );

  static TextStyle get linkSmall => TextStyle(
    color: AppColors.primary,
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.primary,
  );

  // Onboarding / Auth
  static TextStyle get onboardingTitle => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  static TextStyle get onboardingSubtitle => TextStyle(
    color: AppColors.textSecondary1,
    fontSize: 14.sp,
    height: 1.5,
  );

  // Empty State / Placeholder
  static TextStyle get emptyTitle => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get emptySubtitle => TextStyle(
    color: AppColors.textSecondary,
    fontSize: 13.sp,
    height: 1.5,
  );
}