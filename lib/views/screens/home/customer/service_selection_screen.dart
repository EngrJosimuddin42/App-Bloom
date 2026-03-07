import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/customer/business_booking_controller.dart';
import '../../../../models/customer/service_model.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';
import '../../../base/custom_button.dart';


class ServiceSelectionScreen extends StatelessWidget {
  const ServiceSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BusinessBookingController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundBlack1,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundBlack1,
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Container(height: 10.h, color: AppColors.backgroundBlack1),
              Expanded(
                child: ColoredBox(
                  color: AppColors.background,
                  child: Obx(() => Column(
                    children: [
                      // ── Booking For Header ──
                      _BookingHeader(controller: controller),

                      // ── Service List ──
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16.h),
                              ...controller.services.map(
                                    (s) => _ServiceCard(
                                  service: s,
                                  isSelected: controller.selectedService?.id == s.id,
                                  onTap: () => controller.selectService(s),
                                ),
                              ),
                              SizedBox(height: 24.h),

                              // ── Price Summary ──
                              _PriceSummary(controller: controller),

                              SizedBox(height: 24.h),

                              // Continue Button
                              CustomButton(
                                label: 'Continue to Payment Options',
                                isLoading: false,
                                isEnabled: true,
                                onTap: controller.continueToPayment,
                              ),
                              SizedBox(height: 24.h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Booking Header ──
class _BookingHeader extends StatelessWidget {
  final BusinessBookingController controller;
  const _BookingHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      color: AppColors.surfaceVariant1,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back, size: 20.sp, color: AppColors.textBlack1),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Booking for',
                  style: AppTextStyles.caption.copyWith(color: AppColors.textBlack2),
                ),
                Text(
                  '${controller.employeeCount} Employees',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textBlack1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Company',
                style: AppTextStyles.caption.copyWith(color: AppColors.textBlack2),
              ),
              Text(
                controller.barber?.fullName ?? 'Akash saha',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textBlack1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Service Card ──
class _ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final bool isSelected;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.service,
    required this.isSelected,
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
          color: AppColors.surfaceVariant1,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            // Scissors icon
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.15)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.content_cut,
                size: 20.sp,
                color: isSelected ? AppColors.primary : Colors.grey,
              ),
            ),
            SizedBox(width: 12.w),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textBlack1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    service.description,
                    style: AppTextStyles.caption.copyWith(color: AppColors.textBlack2),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined, size: 12.sp, color: AppColors.textBlack2),
                      SizedBox(width: 4.w),
                      Text(
                        service.durationLabel,
                        style: AppTextStyles.caption.copyWith(color: AppColors.textBlack2),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Price + radio
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${service.price.toInt()}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textBlack1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'person',
                  style: AppTextStyles.caption.copyWith(color: AppColors.textBlack2),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.grey.shade400,
                      width: 2,
                    ),
                    color: isSelected ? AppColors.primary : Colors.transparent,
                  ),
                  child: isSelected
                      ? Icon(Icons.check, size: 12.sp, color: Colors.white)
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Price Summary ──
class _PriceSummary extends StatelessWidget {
  final BusinessBookingController controller;
  const _PriceSummary({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant1,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Summary',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textBlack1,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14.h),

          _PriceRow(
            label: 'Service per person',
            value: '\$${controller.pricePerPerson.toInt()}',
          ),
          _PriceRow(
            label: 'Number of employees',
            value: '× ${controller.employeeCount}',
          ),
          _PriceRow(
            label: 'Subtotal',
            value: '\$${controller.subtotal.toStringAsFixed(0)}.00',
          ),

          if (controller.hasVolumeDiscount) ...[
            _PriceRow(
              label: 'Volume Discount (10%)',
              value: '-\$${controller.discount.toStringAsFixed(0)}.00',
              valueColor: Colors.green,
            ),
          ],

          Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Divider(color: Colors.grey.shade300),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textBlack1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.textBlack1,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '\$${controller.totalAmount.toStringAsFixed(0)}.00',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _PriceRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textBlack2)),
          Text(
            value,
            style: AppTextStyles.bodySmall.copyWith(
              color: valueColor ?? AppColors.textBlack1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}