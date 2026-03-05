import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../themes/app_colors.dart';

class JobDetailRow extends StatelessWidget {
  final Color color;
  final String iconPath;
  final String label;
  final String value;
  final String note;

  const JobDetailRow({
    super.key,
    required this.color,
    required this.iconPath,
    required this.label,
    required this.value,
    this.note = '',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Center(
            child: ImageIcon(
              AssetImage(iconPath),
              size: 18.r,
              color: color,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.textBlack)),
            Text(value,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textBlack4)),
            if (note.isNotEmpty)
              Text(note,
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color:AppColors.textBlack4)),
          ],
        ),
      ],
    );
  }
}