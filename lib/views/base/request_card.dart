import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';

class RequestCard extends StatelessWidget {
  final Map<String, dynamic> request;
  final VoidCallback onCheckNow;

  const RequestCard({
    super.key,
    required this.request,
    required this.onCheckNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Name & Price ──
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
        child: Image.asset(
          'assets/images/user.png',
          width: 22.w,
          height: 22.w,
          color: AppColors.textBlack,
        ),
                ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request['name'] ?? '',
                      style: AppTextStyles.bodyPrimary.copyWith(
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp
                      ),
                    ),
                    Text(
                      request['service'] ?? '',
                      style: AppTextStyles.caption
                          .copyWith(color: AppColors.textBlack,
                        fontSize: 13.sp
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                request['price'] ?? '',
                style: AppTextStyles.headingLarge
                    .copyWith(color: AppColors.textBlack),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // ── Rating ──
          Row(
            children: [
              Image.asset('assets/images/star.png', width: 18.w, height: 18.w),
              SizedBox(width: 8.w),
              Text(
                '${request['rating'] ?? '0.0'} Customer Rating',
                style: AppTextStyles.caption
                    .copyWith(color: AppColors.textBlack,fontSize: 14.sp),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // ── Check Now Button ──
          GestureDetector(
            onTap: onCheckNow,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline,
                      size: 18.w, color: AppColors.textBlack),
                  SizedBox(width: 8.w),
                  Text(
                    'Check Now',
                    style: AppTextStyles.bodyPrimary.copyWith(
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}