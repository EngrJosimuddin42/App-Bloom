import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/barber_home_controller.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';
import '../../../base/custom_button.dart';

class BarberHomeScreen extends StatelessWidget {
  const BarberHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BarberHomeController());

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF0F0F0F),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: const Color(0xFF0F0F0F),
          body: GetBuilder<BarberHomeController>(
            builder: (_) {
              return Column(
                children: [
                  // ── Top Header (gradient + rounded bottom) ──
                  _TopHeader(controller: controller),

                  // ── Scrollable Content ──
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),

                          // ── White Card (always visible) ──
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ── Earnings (both states) ──
                                _EarningsCard(controller: controller),

                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 16.h),

                                      // ── Stats (both states) ──
                                      _StatsRow(controller: controller),

                                      SizedBox(height: 16.h),

                                      // ── Offline → Banner | Online → Schedule + Booking ──
                                      Obx(() => !controller.isOnline
                                          ? _OfflineBanner(controller: controller)
                                          : Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 8.h),
                                          _TodaySchedule(
                                              controller: controller),
                                          SizedBox(height: 16.h),
                                          _NewBookingRequest(),
                                        ],
                                      )),

                                      SizedBox(height: 20.h),
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

                  // ── Bottom Nav ──
                  _BottomNav(),
                ],
              );
            },
          ),
        )
        );
    }
}

// ─────────────────────────────────────────
// Top Header
// ─────────────────────────────────────────
class _TopHeader extends StatelessWidget {
  final BarberHomeController controller;
  const _TopHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12.h,
        left: 16.w,
        right: 16.w,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.0221, 0.9779],
          colors: [Color(0xFF2B2B2B), Color(0xFF000000)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header Row ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning',
                    style: AppTextStyles.bodyPrimary.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    controller.userName,
                    style: AppTextStyles.headingLarge.copyWith(
                      color: AppColors.textWhite,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: controller.goToNotifications,
                child: Container(
                  width: 42.w,
                  height: 42.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.textSecondary.withOpacity(0.4),
                    ),
                  ),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: AppColors.textWhite,
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // ── Online Toggle ──
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.textSecondary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Obx(() => Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.isOnline
                        ? AppColors.success
                        : AppColors.textSecondary,
                  ),
                )),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Text(
                        controller.isOnline
                            ? 'You are Online'
                            : 'You are Offline',
                        style: AppTextStyles.bodyPrimary.copyWith(
                          color: AppColors.textWhite,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                      Text(
                        "You're Under Review",
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() => Switch(
                  value: controller.isOnline,
                  onChanged: controller.toggleOnlineStatus,
                  activeColor: AppColors.textWhite,
                  activeTrackColor: AppColors.success,
                  inactiveThumbColor: AppColors.textWhite,
                  inactiveTrackColor:
                  AppColors.textSecondary.withOpacity(0.4),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// Earnings Card
// ─────────────────────────────────────────
class _EarningsCard extends StatelessWidget {
  final BarberHomeController controller;
  const _EarningsCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6C3CE1), Color(0xFF5B89FF)],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "This Week's Earnings",
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textWhite.withOpacity(0.8),
                ),
              ),
              Image.asset(
                'assets/images/content_cut_outlined.png',
                width: 32.w,
                height: 32.w,
                color: AppColors.textWhite.withOpacity(0.6),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            controller.earnings,
            style: AppTextStyles.metricValueLarge.copyWith(
              color: AppColors.textWhite,
              fontSize: 32.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.trending_up,
                      color: AppColors.textWhite, size: 14.sp),
                  SizedBox(width: 4.w),
                  Text(
                    controller.earningsChange,
                    style: AppTextStyles.caption
                        .copyWith(color: AppColors.textWhite),
                  ),
                ],
              ),
              Text(
                controller.earningsDate,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textWhite.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// Stats Row
// ─────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  final BarberHomeController controller;
  const _StatsRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: controller.stats.asMap().entries.map((entry) {
        final isLast = entry.key == controller.stats.length - 1;
        final stat = entry.value;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: isLast ? 0 : 8.w),
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.backgroundGrey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              children: [
                Image.asset(
                  stat['icon']!,
                  width: 20.w,
                  height: 20.w,
                  color: AppColors.textSecondary,
                ),
                SizedBox(height: 6.h),
                Text(
                  stat['value']!,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textBlack,
                    fontSize: 13.sp,
                  ),
                ),
                Text(
                  stat['label']!,
                  style: AppTextStyles.caption
                      .copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────
// Offline Banner
// ─────────────────────────────────────────
class _OfflineBanner extends StatelessWidget {
  final BarberHomeController controller;
  const _OfflineBanner({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.backgroundGrey.withOpacity(0.4),
            ),
            child: Icon(
              Icons.toggle_off_outlined,
              color: AppColors.textSecondary,
              size: 32.sp,
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            "You're Currently Offline",
            style: AppTextStyles.heading.copyWith(color: AppColors.textBlack),
          ),
          SizedBox(height: 6.h),
          Text(
            'Go online to start receiving booking requests',
            style: AppTextStyles.caption
                .copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          CustomButton(
            label: 'Go online',
            isEnabled: true,
            onTap: controller.goOnline,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// Today Schedule
// ─────────────────────────────────────────
class _TodaySchedule extends StatelessWidget {
  final BarberHomeController controller;
  const _TodaySchedule({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today Schedule',
          style: AppTextStyles.heading.copyWith(color: AppColors.textBlack),
        ),
        SizedBox(height: 12.h),
        ...controller.todaySchedule.map((appt) => _AppointmentCard(
          appointment: appt,
          onNavigate: () => controller.startNavigation(appt),
        )),
        SizedBox(height: 8.h),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: controller.seeMoreSchedule,
            child: Text(
              'See More...',
              style: AppTextStyles.bodyPrimary
                  .copyWith(color: AppColors.textSecondary),
            ),
          ),
        ),
      ],
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final Map<String, dynamic> appointment;
  final VoidCallback onNavigate;
  const _AppointmentCard(
      {required this.appointment, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.backgroundGrey.withOpacity(0.6)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.backgroundGrey.withOpacity(0.4),
                ),
                child: Icon(Icons.person_outline,
                    color: AppColors.textSecondary, size: 18.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment['name'],
                      style: AppTextStyles.bodyPrimary.copyWith(
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      appointment['service'],
                      style: AppTextStyles.caption
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              Text(
                appointment['price'],
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textBlack),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(children: [
            Icon(Icons.access_time_outlined,
                color: AppColors.textSecondary, size: 14.sp),
            SizedBox(width: 6.w),
            Text(appointment['time'],
                style: AppTextStyles.caption
                    .copyWith(color: AppColors.textSecondary)),
          ]),
          SizedBox(height: 6.h),
          Row(children: [
            Icon(Icons.location_on_outlined,
                color: AppColors.textSecondary, size: 14.sp),
            SizedBox(width: 6.w),
            Text(appointment['address'],
                style: AppTextStyles.caption
                    .copyWith(color: AppColors.textSecondary)),
          ]),
          SizedBox(height: 6.h),
          Row(children: [
            Icon(Icons.near_me_outlined,
                color: AppColors.secondary, size: 14.sp),
            SizedBox(width: 6.w),
            Text(appointment['distance'],
                style: AppTextStyles.caption
                    .copyWith(color: AppColors.secondary)),
          ]),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: onNavigate,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.backgroundGrey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.near_me_outlined,
                      color: AppColors.textBlack, size: 16.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'Start Navigation',
                    style: AppTextStyles.bodyPrimary.copyWith(
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// New Booking Request
// ─────────────────────────────────────────
class _NewBookingRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.warning.withOpacity(0.15),
            ),
            child: Icon(Icons.warning_amber_rounded,
                color: AppColors.warning, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'New Booking Request!',
                style: AppTextStyles.bodyPrimary.copyWith(
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Tap to view details',
                style: AppTextStyles.caption
                    .copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// Bottom Navigation
// ─────────────────────────────────────────
class _BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        border: Border(
          top: BorderSide(color: AppColors.textSecondary.withOpacity(0.15)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(icon: Icons.home_outlined, label: 'Home', isActive: true),
          _NavItem(icon: Icons.calendar_today_outlined, label: 'Schedule'),
          _NavItem(icon: Icons.inbox_outlined, label: 'Request'),
          _NavItem(icon: Icons.person_outline, label: 'Profile'),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _NavItem({
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.warning : AppColors.textSecondary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 22.sp),
        SizedBox(height: 4.h),
        Text(label, style: AppTextStyles.navLabel.copyWith(color: color)),
        if (isActive) ...[
          SizedBox(height: 4.h),
          Container(
            width: 4.w,
            height: 4.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.warning,
            ),
          ),
        ],
      ],
    );
  }
}