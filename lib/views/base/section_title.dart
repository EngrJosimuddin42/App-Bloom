import 'package:app_bloom/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.headingLarge.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textBlack,
      ),
    );
  }
}