import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../controllers/barber_home_controller.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_text_styles.dart';
import '../../../../base/barber_bottom_nav.dart';
import '../../../../base/barber_nav_helper.dart';
import '../../../../base/request_card.dart';
import 'barber_request_detail_screen.dart';

class BarberRequestScreen extends StatelessWidget {
  const BarberRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BarberHomeController>();

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
        child: ColoredBox(
          color: AppColors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Request's",
                    style: AppTextStyles.headingLarge.copyWith(
                        color: AppColors.textBlack),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "${controller.requests.length} request's available",
                    style: AppTextStyles.caption.copyWith(
                        color: AppColors.textBlack,
                      fontSize: 12.sp
                    ),
                  ),
                ],
              )),
            ),

            // ── Request List ──
            Expanded(
              child: Obx(() {
                if (controller.requests.isEmpty) {
                  return Center(
                    child: Text(
                      'No requests available',
                      style: AppTextStyles.bodyPrimary.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: controller.requests.length,
                  separatorBuilder: (_, __) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    final req = controller.requests[index];
                    return RequestCard(
                      request: req,
                      onCheckNow: () => Get.to(
                            () => BarberRequestDetailScreen(request: req),
                        transition: Transition.rightToLeft,
                      ),
                    );
                  },
                );
              }),
            ),

            // ── Bottom Nav ──
            BarberBottomNav(
              currentIndex: 2,
              onTap: (index) => BarberNavHelper.onTap(index, 2),
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
