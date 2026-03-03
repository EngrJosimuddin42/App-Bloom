import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/barber_home_controller.dart';
import '../../../../themes/app_colors.dart';
import '../../../base/Barber_top_header.dart';
import '../../../base/barber_bottom_nav.dart';
import '../../../base/barber_nav_helper.dart';
import '../../../base/earnings_card.dart';
import '../../../base/offline_banner.dart';
import '../../../base/online_content.dart';
import '../../../base/stats_row.dart';

class BarberHomeScreen extends StatelessWidget {
  const BarberHomeScreen({super.key});

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                // ── Status bar extended area ──
                Container(
                height: 10.h,
                color: AppColors.backgroundBlack1,
              ),

              // ── Main Content ──
              Expanded(
        child:  GetBuilder<BarberHomeController>(
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
                            child: Column(
                              children: [
                                SizedBox(height: 16.h),
                                EarningsCard(
                                  earnings: controller.earnings,
                                  earningsChange: controller.earningsChange,
                                  earningsDate: controller.earningsDate,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(16.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      StatsRow(stats: controller.stats),
                                      SizedBox(height: 24.h),
                                      Obx(() => !controller.isOnline
                                          ? OfflineBanner(
                                        onGoOnline: () => controller.toggleOnlineStatus(true),
                                      )
                                          : OnlineContent(
                                        schedule: controller.previewSchedule,
                                        onSeeMore: controller.seeMoreSchedule,
                                        onNewBookingTap: () {
                                          // Get.to(() => BookingRequestScreen())
                                        },
                                        onNavigate: controller.startNavigation,
                                      )),
                                      SizedBox(height: 16.h),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // ── Bottom Nav ──
                        BarberBottomNav(
                          currentIndex: 0,
                          onTap: (index) => BarberNavHelper.onTap(index, 0),
                        ),

                        // ── Safe area ──
                        Container(
                          height: MediaQuery.of(context).padding.bottom,
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