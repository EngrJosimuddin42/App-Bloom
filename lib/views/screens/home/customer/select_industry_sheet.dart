import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/customer/business_booking_controller.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';


class SelectIndustrySheet extends StatelessWidget {
  final BusinessBookingController controller;
  const SelectIndustrySheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          Text(
            'Select Industry',
            style: AppTextStyles.sectionTitle.copyWith(
              color: AppColors.textBlack1,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),

          // Industry List
          ...controller.industries.map(
                (industry) => Obx(() => InkWell(
              onTap: () => controller.selectIndustry(industry),
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                margin: EdgeInsets.only(bottom: 4.h),
                decoration: BoxDecoration(
                  color: controller.selectedIndustry == industry
                      ? AppColors.primary.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      industry,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: controller.selectedIndustry == industry
                            ? AppColors.primary
                            : AppColors.textBlack1,
                        fontWeight: controller.selectedIndustry == industry
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                    if (controller.selectedIndustry == industry)
                      Icon(Icons.check, size: 18.sp, color: AppColors.primary),
                  ],
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}