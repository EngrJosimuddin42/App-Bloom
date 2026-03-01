import 'package:app_bloom/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../themes/app_text_styles.dart';

class StatsRow extends StatelessWidget {
  final List<Map<String, dynamic>> stats;

  const StatsRow({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: stats.asMap().entries.map((entry) {
        final isLast = entry.key == stats.length - 1;
        final stat = entry.value;
        return Expanded(
          child: Container(
            width: 80.w,
            height: 105.h,
            margin: EdgeInsets.only(right: isLast ? 0 : 8.w),
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.backgroundAss,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.textSecondary2),
            ),
            child: Column(
              children: [
                _buildIcon(stat['icon']),
                SizedBox(height: 5.h),
                Text(
                  stat['value'] ?? '',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  stat['label'] ?? '',
                  style: AppTextStyles.caption.copyWith(
                      color: AppColors.textBlack1
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildIcon(dynamic icon) {
    if (icon is IconData) {
      return Icon(icon, color: AppColors.cardColor, size: 30.sp);
    } else if (icon is String) {
      return Image.asset(icon, width: 35.w, height: 30.w, color: AppColors.cardColor);
    }
    return const SizedBox.shrink();
  }
}