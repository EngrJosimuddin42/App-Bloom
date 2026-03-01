import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';

class UploadBox extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final IconData? fallbackIcon;

  const UploadBox({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.fallbackIcon = Icons.cloud_upload_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundAss,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.textSecondary2),
        ),
        child: Column(
          children: [
            Image.asset(
              icon,
              width: 40.w,
              height: 40.w,
              color: AppColors.textBlack,
              errorBuilder: (_, __, ___) => Icon(
                fallbackIcon,
                size: 32.w,
                color: AppColors.textBlack,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: AppTextStyles.bodyPrimary.copyWith(
                color: AppColors.textBlack,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                  color: AppColors.textBlack,
                fontSize: 14.sp
              ),
            ),
          ],
        ),
      ),
    );
  }
}