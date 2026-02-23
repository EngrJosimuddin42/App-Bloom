import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../themes/app_colors.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final bool isEnabled;
  final VoidCallback onTap;
  final double? height;
  final double? borderRadius;

  const GradientButton({
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
            color: isEnabled ? null : const Color(0xFF8F8F8F),
            gradient: isEnabled
                ? const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF2B2B2B), Color(0xFF000000)],
            )
                : null,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: InkWell(
            onTap: isLoading ? null : onTap,
            borderRadius: BorderRadius.circular(radius),
            child: Center(
              child: isLoading
                  ? SizedBox(
                width: 22.w,
                height: 22.w,
                child: const CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2),
              )
                  : Text(
                label,
                style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
