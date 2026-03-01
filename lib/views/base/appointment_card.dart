import 'package:app_bloom/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../themes/app_text_styles.dart';

class AppointmentCard extends StatelessWidget {
  final String name;
  final String service;
  final String price;
  final String time;
  final String address;
  final String distance;
  final VoidCallback? onNavigate;

  const AppointmentCard({
    super.key,
    required this.name,
    required this.service,
    required this.price,
    required this.time,
    required this.address,
    required this.distance,
    this.onNavigate,
  });

  // Factory constructor
  factory AppointmentCard.fromMap(
      Map<String, dynamic> map, {
        VoidCallback? onNavigate,
      }) {
    return AppointmentCard(
      name:     map['name']     ?? '',
      service:  map['service']  ?? '',
      price:    map['price']    ?? '',
      time:     map['time']     ?? '',
      address:  map['address']  ?? '',
      distance: map['distance'] ?? '',
      onNavigate: onNavigate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(color:AppColors.textBlack),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.cardColor,
                child: Image.asset(
                  'assets/images/user.png',
                  width: 24.w,
                  height: 24.w,
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.bodyPrimary.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textBlack,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      service,
                      style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                price,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // ── Time ──
          _infoRow('assets/images/time.png', time),
          SizedBox(height: 8.h),

           // ── Address ──
          _infoRow('assets/images/location.png', address),
          SizedBox(height: 8.h),

            // ── Distance ──
          _infoRow('assets/images/navigation.png', distance, color: AppColors.secondary),
          SizedBox(height: 16.h),

          // ── Start Navigation ──
          ElevatedButton.icon(
            onPressed: onNavigate,
            icon: Image.asset(
              'assets/images/navigation.png',
              width: 20.w,
              height: 20.w,
              color: AppColors.textBlack,
            ),
            label: Text(
              'Start Navigation',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textBlack,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:AppColors.cardColor,
              foregroundColor: AppColors.backgroundBlack,
              elevation: 0,
              minimumSize: Size(double.infinity, 45.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _infoRow(String assetPath, String text, {Color color = AppColors.textBlack}) {
    return Row(
      children: [
        Image.asset(assetPath, width: 20.w, height: 20.w, color: color),
        SizedBox(width: 8.w),
        Text(text, style: AppTextStyles.caption.copyWith(
            color: color,
          fontSize: 16.sp,
        )),
      ],
    );
  }
}