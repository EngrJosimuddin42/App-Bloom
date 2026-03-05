import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../themes/app_colors.dart';

class DirectionBanner extends StatelessWidget {
  final String direction;
  final String directionNote;

  const DirectionBanner({
    super.key,
    required this.direction,
    required this.directionNote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.backgroundOrange3,
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Image.asset(
              'assets/images/navigation1.png',
              width: 20.r,
              height: 20.r,
              color: AppColors.backgroundOrange2,
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                direction,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack),
              ),
              Text(
                directionNote,
                style: TextStyle(fontSize: 12.sp, color: AppColors.textBlack1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}