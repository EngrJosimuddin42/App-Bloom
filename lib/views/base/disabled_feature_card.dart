import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';

class DisabledFeatureCard extends StatelessWidget {
  final String title;
  final List<String> features;
  final String warningIcon;

  const DisabledFeatureCard({
    super.key,
    this.title = 'Currently Disabled',
    required this.features,
    this.warningIcon = 'assets/images/alert.png',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(8 .r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Row(
            children: [
              Image.asset(
                warningIcon,
                width: 24.w,
                height: 24.w,
                color: AppColors.textBlack,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bodyPrimary.copyWith(
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // ── Feature List ──
          ...features.asMap().entries.map((entry) => Padding(
            padding: EdgeInsets.only(bottom: entry.key < features.length - 1 ? 8.h : 0),
            child: _featureItem(entry.value),
          )),
        ],
      ),
    );
  }

  Widget _featureItem(String label) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w,2.h,0.w,2.h),
      child: Row(
        children: [
          Icon(
            Icons.lock_outline,
            size: 14.w,
            color: AppColors.textBlack,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.caption.copyWith(
                  color: AppColors.textBlack,
                fontSize: 12.sp
              ),
            ),
          ),
        ],
      ),
    );
  }
}
