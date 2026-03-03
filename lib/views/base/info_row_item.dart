import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';

class InfoRowItem extends StatelessWidget {
  final Color color;
  final String assetIcon;
  final String label;
  final String value;
  final String note;

  const InfoRowItem({
    super.key,
    required this.color,
    required this.assetIcon,
    required this.label,
    required this.value,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: Image.asset(
                assetIcon,
                color: color,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: AppTextStyles.caption
                      .copyWith(color: AppColors.textBlack,
                    fontSize: 12.sp
                  )),
              Text(value,
                  style: AppTextStyles.bodyPrimary.copyWith(
                      color: AppColors.textSecondary2,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500)),
              Text(note,
                  style: AppTextStyles.caption
                      .copyWith(color: AppColors.textBlack,
                    fontSize: 12.sp
                  )),
            ],
          ),
        ],
      ),
    );
  }
}