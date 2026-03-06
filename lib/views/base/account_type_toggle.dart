import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../themes/app_colors.dart';

class AccountTypeToggle extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final List<String> options;

  const AccountTypeToggle({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
    this.options = const ['Checking', 'Savings'],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Account Type',
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textBlack)),
        SizedBox(height: 6.h),
        Row(
          children: List.generate(options.length, (i) {
            final isSelected = selectedIndex == i;
            return Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onChanged(i),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.cardColor : AppColors.background,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: isSelected ? AppColors.textBlack : AppColors.textBlack,
                          ),
                        ),
                        child: Text(
                          options[i],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (i < options.length - 1) SizedBox(width: 12.w),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}