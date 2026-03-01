import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';

class CounterField extends StatelessWidget {
  final int value;
  final String icon;
  final String suffix;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CounterField({
    super.key,
    required this.value,
    required this.onIncrease,
    required this.onDecrease,
    this.icon = 'assets/images/work.png',
    this.suffix = ' ',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.cardColor),
      ),
      child: Row(
        children: [
          // ── Icon ──
          Image.asset(
            icon,
            width: 24.w,
            height: 24.w,
            color: AppColors.textBlack,
            errorBuilder: (_, __, ___) =>
                Icon(Icons.work_outline, size: 24.w, color: AppColors.textBlack),
          ),
          SizedBox(width: 12.w),

          // ── Value Text ──
          Expanded(
            child: Text(
              "${value.toString().padLeft(2, '0')} $suffix",
              style: AppTextStyles.inputText.copyWith(color: AppColors.textSecondary1),
            ),
          ),

          // ── Stepper ──
          _buildStepper(),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    return SizedBox(
      width: 100.w,
      height: 40 .w,
      child: Stack(
        children: [
          // ── Asset image ──
          Image.asset(
            'assets/images/stepper.png',
            width:100.w,
            height: 40.w,
            fit: BoxFit.contain,
          ),

          // ── Minus tap (বাম অর্ধেক) ──
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: onDecrease,
              behavior: HitTestBehavior.opaque,
              child: SizedBox(width: 40.w),
            ),
          ),

          // ── Plus tap (ডান অর্ধেক) ──
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: onIncrease,
              behavior: HitTestBehavior.opaque,
              child: SizedBox(width: 40.w),
            ),
          ),
        ],
      ),
    );
  }
}