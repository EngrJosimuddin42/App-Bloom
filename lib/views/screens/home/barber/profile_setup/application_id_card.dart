import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../controllers/barber/barber_home_controller.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_text_styles.dart';
import '../../../../base/Barber_top_header.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/offline_banner.dart';

class ApplicationIdCard extends StatefulWidget {
  const ApplicationIdCard({super.key});

  @override
  State<ApplicationIdCard> createState() => _ApplicationIdCardState();
}

class _ApplicationIdCardState extends State<ApplicationIdCard> {
  bool _isRevealed = false;

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(BarberHomeController());

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
                child: GetBuilder<BarberHomeController>(
                  builder: (_) {
                    return Column(
                      children: [
                        // ── Top Header ──
                        ColoredBox(
                          color: Colors.white,
                          child: Obx(() => BarberTopHeader(
                            userName: controller.userName,
                            isOnline: controller.isOnline,
                            onToggle: controller.toggleOnlineStatus,
                            onNotificationTap: controller.goToNotifications,
                          )),
                        ),

                        // ── White Background Section ──
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 16.h),
                                    child: Column(
                                      children: [
                                        // ── Application ID Card ──
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(8.w),
                                          decoration: BoxDecoration(
                                            color: AppColors.cardColor,
                                            borderRadius: BorderRadius.circular(12.r),
                                            border: Border.all(color:AppColors.textBlack4)
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Your Application ID',
                                                style: AppTextStyles.bodyPrimary.copyWith(
                                                  fontSize: 12.sp,
                                                    color: AppColors.textBlack),
                                              ),
                                              SizedBox(height: 12.h),

                                              // ── ID Box ──
                                              GestureDetector(
                                                onTap: () => setState(() =>
                                                _isRevealed = !_isRevealed),
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.symmetric(vertical: 14.h,horizontal: 14.w),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.backgroundWhite,
                                                    borderRadius:BorderRadius.circular(12.r),
                                                    border: Border.all(color:AppColors.textBlack),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          _isRevealed
                                                              ? controller.applicationId
                                                              : '-' * controller.applicationId.length,
                                                          style: AppTextStyles.headingLarge.copyWith(
                                                            color: AppColors.textBlack,
                                                            fontWeight: FontWeight.w900,
                                                            letterSpacing: 3,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              SizedBox(height: 8.h),
                                              Text(
                                                'Save this ID for tracking your application status',
                                                style: AppTextStyles.caption.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                    color: AppColors.textBlack),
                                                     textAlign: TextAlign.center),
                                              SizedBox(height: 16.h),

                                              // ── Verify Button ──
                                              CustomButton(
                                                label: 'Verify',
                                                isEnabled: _isRevealed,
                                                onTap: _isRevealed ? controller.goToVerify : () {},
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 16.h),

                                        // ── Offline Banner ──
                                        Obx(() => controller.isOnline
                                            ? const SizedBox()
                                            : OfflineBanner(
                                          onGoOnline: () => controller.toggleOnlineStatus(true),
                                          buttonColor: AppColors.textSecondary,
                                         buttonWidth: 200.w,
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // ── Bottom Nav ──
                                Container(
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Image.asset('assets/images/home.png', width: 24.r, height: 24.r),
                                              SizedBox(height: 4.h),
                                              Text('Home',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.textBlack)),
                                              SizedBox(height: 4.h),
                                              Container(
                                                width: 15.w,
                                                height: 2.h,
                                                decoration: BoxDecoration(
                                                  color: AppColors.textBlack,
                                                  borderRadius: BorderRadius.circular(2.r),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // ── Safe area ──
                                Container(
                                  height:
                                  MediaQuery.of(context).padding.bottom,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}