import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';

class BarberTopHeader extends StatelessWidget {
  final String userName;
  final bool isOnline;
  final ValueChanged<bool> onToggle;
  final VoidCallback? onNotificationTap;

  const BarberTopHeader({
    super.key,
    required this.userName,
    required this.isOnline,
    required this.onToggle,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10.h,
        left: 16.w,
        right: 16.w,
        bottom: 16.h,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.0221, 0.9779],
          colors: [Color(0xFF2B2B2B), Color(0xFF000000)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // ── Name + Notification ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning',
                    style: AppTextStyles.bodyPrimary.copyWith(
                      color: AppColors.textWhite,
                    ),
                  ),
                  Text(
                    userName,
                    style: AppTextStyles.headingLarge.copyWith(
                      color: AppColors.textWhite,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onNotificationTap,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.textWhite),
                  ),
                  child: Image.asset(
                    'assets/images/notification.png',
                    width: 44.w,
                    height: 44.w,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // ── Online/Offline Toggle ──
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.textSecondary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 4.r,
                  backgroundColor: isOnline ? Colors.green : Colors.grey,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isOnline ? 'You are Online' : 'You are Offline',
                        style: AppTextStyles.bodyPrimary.copyWith(
                          color: AppColors.textWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp
                        ),
                      ),
                      Text(
                        "You're Under Review",
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: isOnline,
                  onChanged: onToggle,
                  activeColor: AppColors.textWhite,
                  activeTrackColor: Colors.green,
                  inactiveThumbColor: AppColors.textWhite,
                  inactiveTrackColor: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}