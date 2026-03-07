import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/customer/customer_home_controller.dart';
import '../../../../models/customer/barber_model.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';

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
        bottomNavigationBar: _BottomNav(controller: controller),
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
                      _MapSection(controller: controller),

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
                                      child: _QuickActionButton(
                                        icon: Icons.account_balance_wallet_outlined,
                                        label: 'Wallet',
                                        onTap: controller.goToWallet,
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: _QuickActionButton(
                                        icon: Icons.card_membership_outlined,
                                        label: 'View premium\nmembership',
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
                                        color: AppColors.textBlack1,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'See All',
                                        style: AppTextStyles.bodyMedium.copyWith(
                                          color: AppColors.primary,
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
                                        .map((b) => _BarberListTile(
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

// ── Map Section ──
class _MapSection extends StatelessWidget {
  final CustomerHomeController controller;
  const _MapSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.h,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 220.h,
            decoration: const BoxDecoration(color: Color(0xFFE8E8E8)),
            child: CustomPaint(painter: _MapPainter()),
          ),

          // ETA card
          Positioned(
            top: 50.h,
            left: 16.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
              ),
              child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('ETA',
                      style: AppTextStyles.caption.copyWith(color: Colors.grey)),
                  Text(controller.eta,
                      style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w700, color: Colors.black)),
                ],
              )),
            ),
          ),

          // Distance card
          Positioned(
            top: 50.h,
            left: 130.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
              ),
              child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Distance',
                      style: AppTextStyles.caption.copyWith(color: Colors.grey)),
                  Text(controller.distance,
                      style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w700, color: Colors.black)),
                ],
              )),
            ),
          ),

          // Location label
          Positioned(
            bottom: 60.h,
            left: 16.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r)),
              child: Text('New York, NY',
                  style: AppTextStyles.caption
                      .copyWith(fontWeight: FontWeight.w600, color: Colors.black)),
            ),
          ),

          // Barbers nearby
          Positioned(
            bottom: 60.h,
            right: 16.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r)),
              child: Text('5 barbers nearby',
                  style: AppTextStyles.caption
                      .copyWith(color: Colors.grey[700])),
            ),
          ),

          // Request Barber Button
          Positioned(
            bottom: 16.h,
            left: 16.w,
            right: 16.w,
            child: ElevatedButton(
              onPressed: controller.requestBarber,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
              ),
              child: Text('Request Barber', style: AppTextStyles.button),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Quick Action Button ──
class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant1,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: 22.sp, color: AppColors.textBlack1),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(label,
                  style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textBlack1,
                      fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Barber List Tile ──
class _BarberListTile extends StatelessWidget {
  final BarberModel barber;
  final VoidCallback onTap;

  const _BarberListTile({required this.barber, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant1,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26.r,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, color: Colors.grey[600], size: 28.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(barber.fullName,
                          style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textBlack1)),
                      SizedBox(width: 6.w),
                      Icon(Icons.star, size: 14.sp, color: Colors.amber),
                      Text(barber.rating.toStringAsFixed(1),
                          style: AppTextStyles.caption
                              .copyWith(color: AppColors.textBlack2)),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(barber.title,
                      style: AppTextStyles.caption
                          .copyWith(color: AppColors.textBlack2)),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: barber.isAvailable ? Colors.green : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        barber.isAvailable ? 'Available' : 'Unavailable',
                        style: AppTextStyles.caption.copyWith(
                            color: barber.isAvailable
                                ? Colors.green
                                : Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text('R\$${barber.startingPrice.toInt()}',
                style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700, color: AppColors.textBlack1)),
          ],
        ),
      ),
    );
  }
}

// ── Bottom Navigation ──
class _BottomNav extends StatelessWidget {
  final CustomerHomeController controller;
  const _BottomNav({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavItem(icon: Icons.home, label: 'Home', active: true, onTap: () {}),
          _NavItem(
              icon: Icons.calendar_today_outlined,
              label: 'My Bookings',
              onTap: controller.goToMyBookings),
          _NavItem(
              icon: Icons.person_outline,
              label: 'Profile',
              onTap: controller.goToProfile),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem(
      {required this.icon,
        required this.label,
        this.active = false,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              size: 24.sp,
              color: active ? AppColors.primary : Colors.grey),
          SizedBox(height: 4.h),
          Text(label,
              style: AppTextStyles.caption.copyWith(
                  color: active ? AppColors.primary : Colors.grey)),
        ],
      ),
    );
  }
}

// ── Map Painter ──
class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD0D0D0)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    final routePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.8)
      ..lineTo(size.width * 0.2, size.height * 0.4)
      ..lineTo(size.width * 0.6, size.height * 0.4)
      ..lineTo(size.width * 0.6, size.height * 0.2);
    canvas.drawPath(path, routePaint);

    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.8),
      8,
      Paint()..color = const Color(0xFF4285F4),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}