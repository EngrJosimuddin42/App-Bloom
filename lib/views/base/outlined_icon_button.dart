import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../themes/app_colors.dart';

class OutlinedIconButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;

  const OutlinedIconButton({
    super.key,
    required this.iconPath,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Image.asset(
          iconPath,
          height: 16.r,
          width: 16.r,
          fit: BoxFit.contain,
          color: iconColor ?? AppColors.textBlack,
        ),
        label: Text(
          label,
          style: TextStyle(
            color: textColor ?? AppColors.textBlack,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          side: BorderSide(color: AppColors.backgroundBlack),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
    );
  }
}