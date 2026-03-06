import 'package:app_bloom/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../themes/app_text_styles.dart';
import 'custom_button.dart';

class OfflineBanner extends StatelessWidget {
  final VoidCallback onGoOnline;
  final Color? buttonColor;
  final double? buttonWidth;


  const OfflineBanner({
    super.key,
    required this.onGoOnline,
  this.buttonColor,
    this.buttonWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        border: Border.all(color:AppColors.textBlack),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.textBlack1,
            ),
            child: Image.asset(
              'assets/images/toggle_off.png',
              width: 30.w,
              height: 30.w,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "You're Currently Offline",
            style: AppTextStyles.heading.copyWith(
                color: AppColors.textBlack,
              fontSize: 16.sp
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Go online to start receiving booking requests',
            style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              fontSize: 12.sp
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:40.w),
            child: CustomButton(
              label: 'Go online',
              isEnabled: true,
              onTap: onGoOnline,
              color: buttonColor,
              width: buttonWidth,
            ),
          ),
        ],
      ),
    );
  }
}