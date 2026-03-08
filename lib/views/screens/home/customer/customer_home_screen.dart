import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/customer/customer_home_controller.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';
import '../../../base/barber_list_tile.dart';
import '../../../base/customer_bottom_nav.dart';
import '../../../base/customer_map_section.dart';
import '../../../base/customer_nav_helper.dart';
import '../../../base/quick_action_button.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerHomeController());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundBlack1,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundBlack1,
        bottomNavigationBar: CustomerBottomNav(
          currentIndex: 0,
          onTap: (index) => CustomerNavHelper.onTap(index, 0),
        ),
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
                  child: Column(
                    children: [
                      // ── Map Section ──
                      CustomerMapSection(controller: controller),

                      // ── Bottom Content ──
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 16.h),

                                // ── Quick Actions ──
                                Row(
                                  children: [
                                    Expanded(
                                      child: QuickActionButton(
                                        icon: Icons.account_balance_wallet_outlined,
                                        label: 'Wallet',
                                        subtitle: 'R350',
                                        onTap: controller.goToWallet,
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: QuickActionButton(
                                        icon: Icons.content_cut,
                                        label: 'Membership',
                                        subtitle: 'View premium membership',
                                        onTap: controller.goToMembership,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 24.h),

                                // ── Nearby Barbers Header ──
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Nearby Barbers',
                                      style: AppTextStyles.sectionTitle.copyWith(
                                        color: AppColors.textBlack,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'See All',
                                        style: AppTextStyles.bodyMedium.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textBlack,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 8.h),

                                // ── Barbers List ──
                                Obx(() {
                                  if (controller.isLoading) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  return Column(
                                    children: controller.nearbyBarbers
                                        .map((b) => BarberListTile(
                                      barber: b,
                                      onTap: () =>
                                          controller.goToBarberProfile(b),
                                    ))
                                        .toList(),
                                  );
                                }),

                                SizedBox(height: 20.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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


