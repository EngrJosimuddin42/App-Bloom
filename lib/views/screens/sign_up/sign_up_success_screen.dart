import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/sign_up_controller.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';
import '../../base/custom_button.dart';
import '../home/barber/profile_setup/barber_required_info_screen.dart';

class SignUpSuccessScreen extends StatelessWidget {
  const SignUpSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

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
              // ── Status bar extended area ──
              Container(
                height: 10.h,
                color: AppColors.backgroundBlack1,
              ),

              // ── Main Content ──
              Expanded(
                child: ColoredBox(
                  color: AppColors.background,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 200.h),

                        // ── Success Icon ──
                        Image.asset(
                          'assets/images/success_icon.png',
                          color: AppColors.success,
                        ),
                        SizedBox(height: 24.h),

                        // ── Title ──
                        Text(
                          'Verification Successfully',
                          style: AppTextStyles.onboardingTitle.copyWith(
                            color: AppColors.textBlack,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 8.h),

                        Text(
                          'Your account verification successfully completed.',
                          style: AppTextStyles.onboardingSubtitle,
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 40.h),

                        // ── CTA Button (Customer vs Barber) ──
                        Obx(() => CustomButton(
                          label: controller.isCustomer
                              ? 'Go to Home'
                              : 'Apply for Verification',
                          isLoading: false,
                          isEnabled: true,
                          onTap: () {
                            if (controller.isCustomer) {
                              // Get.offAll(() => const HomeScreen());
                            } else {
                              Get.to(
                                      () => const BarberRequiredInfoScreen());
                            }
                          },
                        )),

                        const Spacer(),

                        // ── Security Tip ──
                        Container(
                          padding: EdgeInsets.all(14.w),
                          decoration: BoxDecoration(
                            color: AppColors.cardColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 18.sp,
                                color: AppColors.info,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Security Tip',
                                      style: AppTextStyles.captionBold.copyWith(
                                        color: AppColors.textBlack2,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      "Keep your password safe and don't share it with anyone.",
                                      style: AppTextStyles.caption
                                          .copyWith(height: 1.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24.h),
                      ],
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
}