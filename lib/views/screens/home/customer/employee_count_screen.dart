import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/customer/business_booking_controller.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';
import '../../../base/custom_button.dart';

class EmployeeCountScreen extends StatelessWidget {
  const EmployeeCountScreen({super.key});

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
                  child: Obx(() => SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),

                        // Back + Title
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Icon(Icons.arrow_back, size: 22.sp, color: AppColors.textBlack1),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Select Number of Employees',
                              style: AppTextStyles.sectionTitle.copyWith(
                                color: AppColors.textBlack1,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Padding(
                          padding: EdgeInsets.only(left: 34.w),
                          child: Text(
                            'Minimum 1 employee • Maximum 50 employees',
                            style: AppTextStyles.caption.copyWith(color: AppColors.textBlack2),
                          ),
                        ),
                        SizedBox(height: 28.h),

                        // ── Counter ──
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _CounterButton(
                                icon: Icons.remove,
                                onTap: controller.decrementEmployee,
                              ),
                              SizedBox(width: 24.w),
                              Text(
                                '${controller.employeeCount}',
                                style: TextStyle(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textBlack1,
                                ),
                              ),
                              SizedBox(width: 24.w),
                              _CounterButton(
                                icon: Icons.add,
                                onTap: controller.incrementEmployee,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // ── Quick Select Chips ──
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [10, 15, 20, 5].map((n) {
                            final isSelected = controller.employeeCount == n;
                            return GestureDetector(
                              onTap: () {
                                for (int i = 0; i < (n - controller.employeeCount).abs(); i++) {
                                  if (n > controller.employeeCount) {
                                    controller.incrementEmployee();
                                  } else {
                                    controller.decrementEmployee();
                                  }
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 6.w),
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.textBlack1
                                      : AppColors.surfaceVariant1,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  '$n',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: isSelected ? Colors.white : AppColors.textBlack1,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 28.h),

                        // ── Booking Summary ──
                        Text(
                          'Booking Summary',
                          style: AppTextStyles.sectionTitle.copyWith(
                            color: AppColors.textBlack1,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 14.h),

                        _SummaryRow(
                          label: 'Number of Employees',
                          value: '${controller.employeeCount}',
                        ),
                        _SummaryRow(
                          label: 'Estimated Time',
                          value: controller.estimatedTime,
                        ),
                        _SummaryRow(
                          label: 'Estimated Cost (Before discount)',
                          value: controller.estimatedCostLabel,
                          valueColor: AppColors.textBlack1,
                        ),

                        SizedBox(height: 24.h),

                        // ── Preferred Schedule ──
                        Text(
                          'Preferred Schedule (Optional)',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textBlack1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 14.h),

                        // Date Picker
                        GestureDetector(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(days: 60)),
                            );
                            if (date != null) controller.selectDate(date);
                          },
                          child: _ScheduleField(
                            label: 'Preferred Date',
                            value: controller.selectedDate != null
                                ? '${controller.selectedDate!.day}/${controller.selectedDate!.month}/${controller.selectedDate!.year}'
                                : null,
                            icon: Icons.calendar_today_outlined,
                          ),
                        ),
                        SizedBox(height: 12.h),

                        // Time Picker
                        GestureDetector(
                          onTap: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (time != null) controller.selectTime(time);
                          },
                          child: _ScheduleField(
                            label: 'Preferred Time',
                            value: controller.selectedTime != null
                                ? controller.selectedTime!.format(context)
                                : null,
                            icon: Icons.access_time_outlined,
                          ),
                        ),

                        SizedBox(height: 32.h),

                        // Continue Button
                        CustomButton(
                          label: 'Continue to Service Selection',
                          isLoading: false,
                          isEnabled: true,
                          onTap: controller.continueToServiceSelection,
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
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

// ── Counter Button ──
class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CounterButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.w,
        height: 44.h,
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant1,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, size: 20.sp, color: AppColors.textBlack1),
      ),
    );
  }
}

// ── Summary Row ──
class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  const _SummaryRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
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

// ── Schedule Field ──
class _ScheduleField extends StatelessWidget {
  final String label;
  final String? value;
  final IconData icon;
  const _ScheduleField({required this.label, this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant1,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value ?? label,
            style: AppTextStyles.bodySmall.copyWith(
              color: value != null ? AppColors.textBlack1 : AppColors.textBlack2,
            ),
          ),
          Icon(icon, size: 18.sp, color: AppColors.textBlack2),
        ],
      ),
    );
  }
}