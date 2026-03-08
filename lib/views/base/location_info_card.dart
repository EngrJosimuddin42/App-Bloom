import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';

class LocationInfoCard extends StatelessWidget {
  final String location;
  final String barbersNearby;

  const LocationInfoCard({
    super.key,
    this.location = 'New York, NY',
    this.barbersNearby = '5 barbers nearby',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Your Location',
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.textBlack,
            ),
          ),
          Text(
            location,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack,
            ),
          ),
          Text(
            barbersNearby,
            style: AppTextStyles.caption.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textBlack,
            ),
          ),
        ],
      ),
    );
  }
}