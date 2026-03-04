import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/app_colors.dart';

class StatBox extends StatelessWidget {
  final String iconPath;
  final String value;
  final String label;

  const StatBox({
    super.key,
    required this.iconPath,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          border: Border.all(color: AppColors.textBlack),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath.isNotEmpty) ...[
            Image.asset(
              iconPath,
              height: 24.r,
              width: 24.r,
              fit: BoxFit.contain,
              color: AppColors.textBlack,
            ),
            SizedBox(width: 4.w),
        ],
        Flexible(
          child:Text(
              value,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textBlack,
              ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
          ],
          ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textSecondary2,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}