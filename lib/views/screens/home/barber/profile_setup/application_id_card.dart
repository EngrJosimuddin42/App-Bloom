import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../controllers/barber_home_controller.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_text_styles.dart';
import '../../../../base/barber_bottom_nav.dart';
import '../../../../base/barber_nav_helper.dart';
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
                                          padding: EdgeInsets.all(16.w),
                                          decoration: BoxDecoration(
                                            color: AppColors.cardColor,
                                            borderRadius:
                                            BorderRadius.circular(16.r),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Your Application ID',
                                                style: AppTextStyles.bodyPrimary
                                                    .copyWith(
                                                    color: AppColors
                                                        .textSecondary),
                                              ),
                                              SizedBox(height: 12.h),

                                              // ── ID Box ──
                                              GestureDetector(
                                                onTap: () => setState(() =>
                                                _isRevealed = !_isRevealed),
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 14.h,
                                                      horizontal: 16.w),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10.r),
                                                    border: Border.all(
                                                        color:
                                                        AppColors.border2),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          _isRevealed
                                                              ? controller
                                                              .applicationId
                                                              : '•' *
                                                              controller
                                                                  .applicationId
                                                                  .length,
                                                          style: AppTextStyles
                                                              .headingLarge
                                                              .copyWith(
                                                            color: AppColors
                                                                .textBlack,
                                                            letterSpacing: 3,
                                                          ),
                                                          textAlign:
                                                          TextAlign.center,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () =>
                                                            Clipboard.setData(
                                                                ClipboardData(
                                                                    text: controller
                                                                        .applicationId)),
                                                        child: Icon(
                                                            Icons.copy_outlined,
                                                            size: 18.w,
                                                            color: AppColors
                                                                .textSecondary),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              SizedBox(height: 8.h),
                                              Text(
                                                'Save this ID for tracking your application status',
                                                style: AppTextStyles.caption
                                                    .copyWith(
                                                    color: AppColors
                                                        .textSecondary),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 16.h),

                                              // ── Verify Button ──
                                              CustomButton(
                                                label: 'Verify',
                                                isEnabled: true,
                                                onTap: controller.goToVerify,
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 16.h),

                                        // ── Offline Banner ──
                                        OfflineBanner(
                                          onGoOnline: () => controller
                                              .toggleOnlineStatus(true),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // ── Bottom Nav ──
                                BarberBottomNav(
                                  currentIndex: 0,
                                  onTap: (index) =>
                                      BarberNavHelper.onTap(index, 0),
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