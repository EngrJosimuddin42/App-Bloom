import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/customer/barber_model.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';

class BarberListTile extends StatelessWidget {
  final BarberModel barber;
  final VoidCallback onTap;

  const BarberListTile({
    super.key,
    required this.barber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Avatar + Name + Rating ──
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 28.r,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: (barber.avatarUrl != null &&
                      barber.avatarUrl!.isNotEmpty)
                      ? NetworkImage(barber.avatarUrl!)
                      : null,
                  child: (barber.avatarUrl == null || barber.avatarUrl!.isEmpty)
                      ? Icon(Icons.person, color: Colors.grey[600], size: 28.sp)
                      : null,
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      barber.fullName,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: AppColors.textBlack,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Image.asset('assets/images/star.png', height: 18, width: 18),
                        SizedBox(width: 4.w),
                        Text(
                          barber.rating.toStringAsFixed(1),
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 8.h),

            // ── Title ──
            Text(
              barber.title,
              style: AppTextStyles.caption.copyWith(
                fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary),
            ),

            SizedBox(height: 8.h),

            // ── Available + Price ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  barber.isAvailable ? 'Available' : 'Unavailable',
                  style: AppTextStyles.caption.copyWith(
                    color: barber.isAvailable ? AppColors.secondary : Colors.grey,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'R${barber.startingPrice.toInt()}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textBlack,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}