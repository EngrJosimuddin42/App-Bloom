import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';

class PasswordRequirementRow extends StatelessWidget {
  final bool met;
  final String label;

  const PasswordRequirementRow({
    super.key,
    required this.met,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 10.sp,
          color: met ? AppColors.success : AppColors.textSecondary,
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: met ? AppColors.background : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}