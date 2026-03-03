import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';
import 'appointment_card.dart';

class OnlineContent extends StatelessWidget {
  final List<Map<String, dynamic>> schedule;
  final VoidCallback onSeeMore;
  final VoidCallback? onNewBookingTap;
  final void Function(Map<String, dynamic>)? onNavigate;

  const OnlineContent({
    super.key,
    required this. schedule,
    required this.onSeeMore,
    this.onNewBookingTap,
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today Schedule',
          style: AppTextStyles.heading.copyWith(
              color: AppColors.textBlack
          ),
        ),
        SizedBox(height: 12.h),

        // ── Appointment Cards ──
        ...schedule.map((appt) => AppointmentCard.fromMap(appt,onNavigate: () => onNavigate?.call(appt))),

        // ── See More ──
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: onSeeMore,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                'See More...',
                style: AppTextStyles.caption.copyWith(
                    color:AppColors.textBlack,
                  fontSize: 16.sp
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 12.h),

        // ── New Booking Request ──
        GestureDetector(
          onTap: onNewBookingTap,
          child: Container(
            width: 358.w,
            height: 70.h,
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color:AppColors.cardColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                  Image.asset(
                      'assets/images/warning.png',
                       width: 40.w,
                       height: 40.w,
                       ),

                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Booking Request!',
                      style: AppTextStyles.bodyPrimary.copyWith(
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp
                      ),
                    ),
                    Text(
                      'Tap to view details',
                      style: AppTextStyles.caption.copyWith(
                          color: AppColors.textBlack,
                        fontSize: 16.sp
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}