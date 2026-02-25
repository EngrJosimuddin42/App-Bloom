import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/onboarding_model.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';

class OnboardingPageView extends StatelessWidget {
  final OnboardingModel data;

  const OnboardingPageView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ── Icon Box ──
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(30.w),
              child: Image.asset(
                data.imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox(height: 48.h),

          // ── Title ──
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.onboardingTitle.copyWith(
              color: AppColors.textBlack,
              letterSpacing: -0.5,
            ),
          ),

          SizedBox(height: 8.h),

          // ── Description ──
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: AppTextStyles.onboardingSubtitle.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: -0.5,
            ),

          ),
        ],
      ),
    );
  }
}