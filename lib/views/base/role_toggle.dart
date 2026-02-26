import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';

class RoleToggle extends StatelessWidget {
  final String selectedRole;
  final ValueChanged<String> onRoleChanged;

  const RoleToggle({
    super.key,
    required this.selectedRole,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isCustomer = selectedRole == 'customer';

    return Row(
      children: [
        _RoleButton(
          label: 'Customer',
          iconAsset: 'assets/images/user.png',
          isSelected: isCustomer,
          onTap: () => onRoleChanged('customer'),
        ),
        SizedBox(width: 12.w),
        _RoleButton(
          label: 'Barber',
          iconAsset: 'assets/images/scissor.png',
          isSelected: !isCustomer,
          onTap: () => onRoleChanged('barber'),
        ),
      ],
    );
  }
}

class _RoleButton extends StatelessWidget {
  final String label;
  final String iconAsset;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleButton({
    required this.label,
    required this.iconAsset,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 44.h,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.textBlack : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isSelected
                  ? AppColors.textBlack
                  : AppColors.border.withValues(alpha: 0.4),
              width: 1.2.w,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconAsset,
                width: 18.w,
                height: 18.w,
                color: isSelected ? AppColors.textWhite : AppColors.textBlack,
              ),
              SizedBox(width: 6.w),
              Text(
                label,
                style: AppTextStyles.bodyPrimary.copyWith(
                  color: isSelected ? AppColors.textWhite : AppColors.textBlack,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}