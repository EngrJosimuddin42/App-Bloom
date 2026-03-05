import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../themes/app_colors.dart';

class EtaCard extends StatelessWidget {
  final String eta;
  final String distance;

  const EtaCard({
    super.key,
    required this.eta,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(60.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/navigation.png',
            width: 20.r,
            height: 20.r,
            color: AppColors.backgroundOrange,
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ETA',
                  style: TextStyle(fontSize: 12.sp, color:AppColors.textBlack4)),
              Text(
                eta,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack1),
              ),
            ],
          ),
          SizedBox(width: 24.w),
          Container(width: 1, height: 30.h, color:AppColors.backgroundGrey),
          SizedBox(width: 24.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Distance',
                  style: TextStyle(fontSize: 12.sp, color: AppColors.textBlack4)),
              Text(
                distance,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}