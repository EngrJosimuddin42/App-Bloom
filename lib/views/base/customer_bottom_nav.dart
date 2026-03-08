import 'package:app_bloom/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const CustomerBottomNav({
    super.key,
    this.currentIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black12, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem('assets/images/home.png',     'Home',       0),
          _buildNavItem('assets/images/schedule.png', 'My Bookings', 1),
          _buildNavItem('assets/images/user.png',     'Profile',    2),
        ],
      ),
    );
  }

  Widget _buildNavItem(String assetPath, String label, int index) {
    final isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap?.call(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            assetPath,
            width: 26.w,
            height: 26.w,
            color: isActive ? AppColors.textBlack : AppColors.textSecondary2,
          ),
          Text(
            label,
            style: TextStyle(
              color: isActive ? AppColors.textBlack : AppColors.textSecondary2,
              fontSize: 12.sp,
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 15,
              color: Colors.black,
            ),
        ],
      ),
    );
  }
}