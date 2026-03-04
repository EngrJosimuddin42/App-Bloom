import 'package:app_bloom/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/app_text_styles.dart';

class SettingsItem extends StatelessWidget {
  final String iconPath;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showArrow;

  const SettingsItem({
    super.key,
    required this.iconPath,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    this.onTap,
    this.trailing,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(44.r),
              ),
              child: Image.asset(
                iconPath,
                width: 24.r,
                height: 24.r,
                color: iconColor,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.headingLarge.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textBlack,
                ),
              ),
            ),
            trailing ??
                (showArrow
                    ? Icon(Icons.arrow_forward_ios,
                    size: 18.r, color: AppColors.textBlack)
                    : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}