import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_text_styles.dart';
import '../barber_home_screen.dart';

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
      insetPadding: EdgeInsets.symmetric(horizontal: 80.w),
      child: Padding(
        padding: EdgeInsets.all(8.w),
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
            SizedBox(height: 6.h),
            Text(
              "Now you're access all features,Go \nonline",
              style: AppTextStyles.bodyPrimary.copyWith(
                fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Divider(height: 1,),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () {
                Get.offAll(() => const BarberHomeScreen(),
                    transition: Transition.leftToRight);
              },
              child: Text(
                'OK',
                style: AppTextStyles.bodyPrimary.copyWith(
                  color: AppColors.backgroundBlue,
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