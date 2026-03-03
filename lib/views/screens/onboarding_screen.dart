import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/onboarding_controller.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';
import '../../utils/constants/onboarding_data.dart';
import '../base/onboarding_content.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

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
                  child: Obx(() {
                    final isLastPage = controller.isLastPage;

                    return Column(
                      children: [
                        // ── Top Navigation Bar ──
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 16.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (controller.currentPage.value > 0)
                                GestureDetector(
                                  onTap: controller.previousPage,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_back_ios,
                                        color: AppColors.backgroundBlack,
                                        size: 16.sp,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        'Back',
                                        style: AppTextStyles.bodyLarge.copyWith(
                                          color: AppColors.textBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                const SizedBox(width: 60),

                              if (!isLastPage)
                                GestureDetector(
                                  onTap: controller.skipToEnd,
                                  child: Text(
                                    'Skip',
                                    style: AppTextStyles.bodyLarge.copyWith(
                                      color: AppColors.textBlack,
                                    ),
                                  ),
                                )
                              else
                                const SizedBox(width: 40),
                            ],
                          ),
                        ),

                        // ── Page Content ──
                        Expanded(
                          child: PageView.builder(
                            controller: controller.pageController,
                            itemCount: onboardingPages.length,
                            onPageChanged: controller.onPageChanged,
                            itemBuilder: (context, index) {
                              return OnboardingPageView(
                                  data: onboardingPages[index]);
                            },
                          ),
                        ),

                        // ── Page Indicators ──
                        Padding(
                          padding: EdgeInsets.only(bottom: 24.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              onboardingPages.length,
                                  (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: EdgeInsets.symmetric(horizontal: 3.w),
                                width: controller.currentPage.value == index
                                    ? 20.w
                                    : 5.w,
                                height: 5.h,
                                decoration: BoxDecoration(
                                  color: controller.currentPage.value == index
                                      ? AppColors.backgroundBlack
                                      : AppColors.backgroundGrey,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // ── Bottom Button ──
                        Padding(
                          padding:
                          EdgeInsets.fromLTRB(20.w, 0, 20.w, 32.h),
                          child: SizedBox(
                            width: 358.w,
                            height: 48.h,
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8.r),
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: AppColors.splashGradient,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: InkWell(
                                  onTap: controller.nextPage,
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Center(
                                    child: Text(
                                      isLastPage ? 'Get Started' : 'Next',
                                      style: AppTextStyles.buttonLarge,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}