import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';

class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.textBlack,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 26.sp, color:AppColors.background),
            SizedBox(height: 8.h),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textWhite,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              subtitle,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textWhite,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}