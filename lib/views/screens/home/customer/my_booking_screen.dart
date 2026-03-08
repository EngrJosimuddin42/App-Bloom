import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';
import '../../../base/customer_bottom_nav.dart';
import '../../../base/customer_nav_helper.dart';
import 'booking_detail_screen.dart';

class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.background,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        bottomNavigationBar: CustomerBottomNav(
          currentIndex: 1,
          onTap: (index) => CustomerNavHelper.onTap(index, 1),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),

                // ── Title ──
                Text(
                  'My Booking',
                  style: AppTextStyles.onboardingTitle.copyWith(
                    color: AppColors.textBlack,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 20.h),

                // ── Booking Card ──
                _BookingCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.blue.shade200,
          width: 1.5,
          // dashed border via CustomPaint below
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: CustomPaint(
          painter: _DashedBorderPainter(
            color: Colors.blue.shade300,
            strokeWidth: 1.5,
            dashWidth: 8,
            dashSpace: 5,
            radius: 12.r,
          ),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Barber Info ──
                _BarberInfoRow(),

                SizedBox(height: 12.h),

                // ── Divider ──
                Divider(color: Colors.grey.shade200, height: 1),

                SizedBox(height: 12.h),

                // ── Date & Time ──
                _InfoRow(
                  icon: Icons.calendar_today_outlined,
                  iconColor: Colors.purple,
                  label: 'Date & Time',
                  value: 'Today, 3:00 PM',
                ),

                SizedBox(height: 10.h),

                // ── Service Location ──
                _InfoRow(
                  icon: Icons.location_on_outlined,
                  iconColor: Colors.purple,
                  label: 'Service Location',
                  value: '1234 Main St, Apt 5B, New York, NY 10001',
                ),

                SizedBox(height: 16.h),

                // ── View More Button ──
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => const BookingDetailScreen()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                    ),
                    child: Text(
                      'View More',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10.h),

                // ── Call Button ──
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.phone_outlined,
                      size: 18.sp,
                      color: Colors.blue,
                    ),
                    label: Text(
                      'Call',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),

                SizedBox(height: 10.h),

                // ── Cancel Booking Button ──
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.close,
                      size: 16.sp,
                      color: Colors.red,
                    ),
                    label: Text(
                      'Cancel Booking',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red.shade50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Barber Info Row ──
class _BarberInfoRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        CircleAvatar(
          radius: 28.r,
          backgroundColor: Colors.grey[300],
          backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=12'),
        ),
        SizedBox(width: 12.w),

        // Name + Service
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Marcus Johnson',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Men's Haircut + Beard",
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textBlack2,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Icon(Icons.star, size: 14.sp, color: Colors.amber),
                  SizedBox(width: 3.w),
                  Text(
                    '4.9',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Price
        Text(
          '\$50',
          style: AppTextStyles.sectionTitle.copyWith(
            color: AppColors.textBlack,
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
          ),
        ),
      ],
    );
  }
}

// ── Info Row ──
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34.w,
          height: 34.h,
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, size: 18.sp, color: iconColor),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textBlack2,
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Dashed Border Painter ──
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double radius;

  const _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ));

    final dashPath = Path();
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        dashPath.addPath(
          metric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}