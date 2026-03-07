import 'package:app_bloom/views/screens/home/customer/select_industry_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/customer/business_booking_controller.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text_field.dart';

class BusinessBookingFormScreen extends StatelessWidget {
  const BusinessBookingFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BusinessBookingController());

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
                  child: GetBuilder<BusinessBookingController>(
                    builder: (_) => SingleChildScrollView(
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
                                'Business Booking',
                                style: AppTextStyles.sectionTitle.copyWith(
                                  color: AppColors.textBlack1,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),

                          // Company Name
                          CustomTextField(
                            controller: controller.companyNameController,
                            label: 'Company Name',
                            hint: 'Enter company name',
                            prefixIcon: const Icon(Icons.business_outlined),
                            errorText: controller.companyError,
                          ),
                          SizedBox(height: 16.h),

                          // Industry Dropdown
                          GestureDetector(
                            onTap: () => _showIndustrySheet(context, controller),
                            child: AbsorbPointer(
                              child: CustomTextField(
                                controller: TextEditingController(
                                    text: controller.selectedIndustry ?? ''),
                                label: 'Industry',
                                hint: 'Select Industry',
                                prefixIcon: const Icon(Icons.category_outlined),
                                suffixIcon: const Icon(Icons.keyboard_arrow_down),
                                errorText: controller.industryError,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),

                          // Contact Person
                          CustomTextField(
                            controller: controller.contactPersonController,
                            label: 'Contact Person',
                            hint: 'Full Name',
                            prefixIcon: const Icon(Icons.person_outline),
                            errorText: controller.contactError,
                          ),
                          SizedBox(height: 16.h),

                          // Email
                          CustomTextField(
                            controller: controller.emailController,
                            label: 'Email Address',
                            hint: 'your@email.com',
                            prefixIcon: const Icon(Icons.email_outlined),
                            keyboardType: TextInputType.emailAddress,
                            errorText: controller.emailError,
                          ),
                          SizedBox(height: 16.h),

                          // Phone
                          CustomTextField(
                            controller: controller.phoneController,
                            label: 'Phone Number',
                            hint: '+1 225-069-558-222',
                            prefixIcon: const Icon(Icons.phone_outlined),
                            keyboardType: TextInputType.phone,
                            errorText: controller.phoneError,
                          ),
                          SizedBox(height: 16.h),

                          // Company Address
                          CustomTextField(
                            controller: controller.addressController,
                            label: 'Company Address',
                            hint: 'Street Address, City, State, ZIP',
                            prefixIcon: const Icon(Icons.location_on_outlined),
                          ),
                          SizedBox(height: 16.h),

                          // Tax ID (optional)
                          CustomTextField(
                            controller: controller.taxIdController,
                            label: 'Tax ID/VAT Number (Optional)',
                            hint: 'XX-XXXX-XX',
                            prefixIcon: const Icon(Icons.numbers_outlined),
                          ),
                          SizedBox(height: 32.h),

                          // Continue Button
                          CustomButton(
                            label: 'Continue to Employee Count',
                            isLoading: controller.isLoading,
                            isEnabled: true,
                            onTap: controller.continueToEmployeeCount,
                          ),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showIndustrySheet(BuildContext context, BusinessBookingController controller) {
    Get.bottomSheet(
      SelectIndustrySheet(controller: controller),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}