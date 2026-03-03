import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_text_styles.dart';

class VerificationCompleteDialog extends StatelessWidget {
  final VoidCallback onOk;

  const VerificationCompleteDialog({
    super.key,
    required this.onOk,
  });

  static void show({required VoidCallback onOk}) {
    Get.dialog(
      VerificationCompleteDialog(onOk: onOk),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Verification Complete',
              style: AppTextStyles.heading.copyWith(
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              "Now you're access all features, Go online",
              style: AppTextStyles.bodyPrimary.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () {
                Get.back();
                onOk();
              },
              child: Text(
                'OK',
                style: AppTextStyles.bodyPrimary.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}