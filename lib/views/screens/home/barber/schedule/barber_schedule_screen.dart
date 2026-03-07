import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../controllers/barber/barber_home_controller.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_text_styles.dart';
import '../../../../base/appointment_card.dart';
import '../../../../base/barber_bottom_nav.dart';
import '../../../../base/barber_nav_helper.dart';

class BarberScheduleScreen extends StatelessWidget {
  const BarberScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BarberHomeController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundBlack1,
        statusBarIconBrightness: Brightness.light,
      ),
      child:
      Scaffold(
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
                    "Today's Schedule",
                    style: AppTextStyles.headingLarge.copyWith(
                      color: AppColors.textBlack,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${controller.scheduleAppointments.length} appointments',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textBlack,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              )),
            ),

            // ── Appointment List ──
            Expanded(
              child: Obx(() => ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: controller.scheduleAppointments.length,
                separatorBuilder: (_, __) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final apt = controller.scheduleAppointments[index];
                  return AppointmentCard.fromMap(
                    apt,
                    borderColor: AppColors.border1,
                    onNavigate: () => controller.startNavigation(apt),
                  );
                },
              )),
            ),

            // ── Bottom Nav ──
            BarberBottomNav(
              currentIndex: 1,
              onTap: (index) => BarberNavHelper.onTap(index, 1),
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