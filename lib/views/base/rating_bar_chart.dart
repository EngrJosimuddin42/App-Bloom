import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../themes/app_colors.dart';

class RatingBarChart extends StatelessWidget {
  final Map<int, int> starCounts;
  final int totalReviews;

  const RatingBarChart({
    super.key,
    required this.starCounts,
    required this.totalReviews,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(5, (i) {
        final star = 5 - i;
        final count = starCounts[star] ?? 0;
        final fraction = totalReviews > 0 ? count / totalReviews : 0.0;

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Row(
            children: [
              Text(
                '$star',
                style: TextStyle(fontSize: 13.sp, color: AppColors.textBlack),
              ),
              SizedBox(width: 6.w),
              Image.asset('assets/images/star.png', width: 13.r, height: 13.r),
              SizedBox(width: 6.w),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: LinearProgressIndicator(
                    value: fraction.toDouble(),
                    minHeight: 6.h,
                    backgroundColor: AppColors.textSecondary2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.textBlack),
                  ),
                ),
              ),
              SizedBox(width: 6.w),
              SizedBox(
                width: 24.w,
                child: Text(
                  '$count',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 13.sp, color: AppColors.textBlack),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}