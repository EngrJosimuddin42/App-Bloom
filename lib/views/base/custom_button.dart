import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final bool isEnabled;
  final VoidCallback onTap;
  final double? height;
  final double? borderRadius;

  const CustomButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
    this.isEnabled = true,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final radius = (borderRadius ?? 8).r;

    return SizedBox(
      width: 358.w,
      height: height ?? 48.h,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        child: Ink(
          decoration: BoxDecoration(
            color: isEnabled ? null : AppColors.textHint,
            gradient: isEnabled ? AppColors.splashGradient : null,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: InkWell(
            onTap: isEnabled && !isLoading ? onTap : null,
            borderRadius: BorderRadius.circular(radius),
            child: Center(
              child: isLoading
                  ? SizedBox(
                width: 22.w,
                height: 22.w,
                child: CircularProgressIndicator(
                  color: AppColors.background,
                  strokeWidth: 2,
                ),
              )
                  : Text(
                label,
                style: AppTextStyles.buttonLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }
}