import 'package:app_bloom/views/screens/home/customer/personal_booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/customer/customer_barber_profile_controller.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';
import 'business_booking_screen.dart';


class BookServiceBottomSheet extends StatelessWidget {
  const BookServiceBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BarberProfileController>();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),

          // Title
          Text(
            'Book Your Service',
            style: AppTextStyles.sectionTitle.copyWith(
              color: AppColors.textBlack1,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Choose your booking type.',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textBlack2),
          ),
          SizedBox(height: 28.h),

          // Options Row
          Row(
            children: [
              Expanded(
                child: _BookingTypeButton(
                  label: 'Personal',
                  onTap: () {
                    Get.back();
                    Get.to(() => const PersonalBookingScreen());
                  },
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _BookingTypeButton(
                  label: 'Business',
                  outlined: false,
                  onTap: () {
                    Get.back();
                    Get.to(() => const BusinessBookingScreen());
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}

class _BookingTypeButton extends StatelessWidget {
  final String label;
  final bool outlined;
  final VoidCallback onTap;

  const _BookingTypeButton({
    required this.label,
    this.outlined = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: outlined ? Colors.transparent : AppColors.primary,
          border: outlined
              ? Border.all(color: AppColors.primary, width: 1.5)
              : null,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.button.copyWith(
              color: outlined ? AppColors.primary : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}