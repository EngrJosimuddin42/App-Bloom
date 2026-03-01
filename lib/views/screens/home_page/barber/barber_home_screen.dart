import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/barber_home_controller.dart';
import '../../../base/Barber_top_header.dart';
import '../../../base/barber_bottom_nav.dart';
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
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<BarberHomeController>(
          builder: (_) {
            return Column(
              children: [
                // ── Top Header ──
                Obx(() => BarberTopHeader(
                  userName: controller.userName,
                  isOnline: controller.isOnline,
                  onToggle: controller.toggleOnlineStatus,
                  onNotificationTap: controller.goToNotifications,
                )),

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
                                        schedule: controller.todaySchedule,
                                        onSeeMore: controller.seeMoreSchedule,
                                        onNewBookingTap: () {
                                          // Get.to(() => BookingRequestScreen())
                                        },
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
                          onTap: (index) {
                            // navigate based on index
                          },
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
    );
  }
}