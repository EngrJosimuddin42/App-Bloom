import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/customer/barber_profile_controller.dart';
import '../../../../models/customer/review_model.dart';
import '../../../../models/customer/barber_model.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';
import '../../../base/custom_button.dart';
import 'Book_service_bottom_sheet.dart';


class BarberProfileScreen extends StatelessWidget {
  const BarberProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BarberProfileController());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Obx(() {
          final barber = controller.barber;
          if (barber == null) return const SizedBox();

          return Stack(
            children: [
              // Scrollable content
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 100.h),
                child: Column(
                  children: [
                    // ── Profile Header ──
                    _ProfileHeader(barber: barber),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h),

                          // ── Stats Row ──
                          _StatsRow(barber: barber),

                          SizedBox(height: 20.h),

                          // ── Starting Price ──
                          _InfoTile(
                            icon: Icons.attach_money,
                            iconColor: Colors.amber,
                            text: 'Starting Price  R\$${barber.startingPrice.toInt()}',
                          ),
                          SizedBox(height: 10.h),
                          _InfoTile(
                            icon: Icons.access_time_outlined,
                            iconColor: Colors.green,
                            text: 'Next Available  ${barber.nextAvailable}',
                          ),

                          SizedBox(height: 20.h),

                          // ── Specialties ──
                          if (barber.specialties.isNotEmpty) ...[
                            ...barber.specialties.map(
                                  (s) => _CheckTile(text: s),
                            ),
                            SizedBox(height: 8.h),
                          ],

                          // ── Badges ──
                          if (barber.isLicensed)
                            _BadgeTile(
                              icon: Icons.verified_outlined,
                              text: 'Licensed & Certified',
                            ),
                          if (barber.isBackgroundVerified)
                            _BadgeTile(
                              icon: Icons.shield_outlined,
                              text: 'Background Verified',
                            ),
                          if (barber.isCovidVaccinated)
                            _BadgeTile(
                              icon: Icons.health_and_safety_outlined,
                              text: 'COVID-19 Vaccinated',
                            ),

                          SizedBox(height: 20.h),

                          // ── About ──
                          Text('About', style: AppTextStyles.sectionTitle.copyWith(color: AppColors.textBlack1)),
                          SizedBox(height: 8.h),
                          Text(
                            'Professional barber with ${barber.experience} years of experience in classic and modern styles. Specializes in business cuts, fades, and beard trims.',
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textBlack2),
                          ),

                          SizedBox(height: 20.h),

                          // ── Portfolio ──
                          Row(
                            children: List.generate(3, (i) => Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: i < 2 ? 8.w : 0),
                                height: 90.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Icon(Icons.image, color: Colors.grey[400]),
                              ),
                            )),
                          ),

                          SizedBox(height: 24.h),

                          // ── Reviews ──
                          Text('Reviews', style: AppTextStyles.sectionTitle.copyWith(color: AppColors.textBlack1)),
                          SizedBox(height: 12.h),

                          ...barber.reviews.map((r) => _ReviewTile(review: r)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Sticky Bottom Bar ──
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Starting from', style: AppTextStyles.caption.copyWith(color: AppColors.textBlack2)),
                          Text(
                            'R\$${barber.startingPrice.toInt()}',
                            style: AppTextStyles.sectionTitle.copyWith(
                              color: AppColors.textBlack1,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: CustomButton(
                          label: 'Book Now',
                          isLoading: false,
                          isEnabled: true,
                          onTap: () => _showBookingSheet(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  void _showBookingSheet(BuildContext context) {
    Get.bottomSheet(
      const BookServiceBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}

// ── Profile Header ──
class _ProfileHeader extends StatelessWidget {
  final BarberModel barber;
  const _ProfileHeader({required this.barber});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundBlack1,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8.h, bottom: 20.h),
      child: Column(
        children: [
          // Back button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),
          ),

          // Avatar
          CircleAvatar(
            radius: 44.r,
            backgroundColor: Colors.grey[700],
            child: Icon(Icons.person, color: Colors.grey[400], size: 44.sp),
          ),
          SizedBox(height: 12.h),

          // Availability badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.green, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8.w,
                  height: 8.h,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  '● Available Now',
                  style: AppTextStyles.caption.copyWith(color: Colors.green),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          Text(
            barber.fullName,
            style: AppTextStyles.onboardingTitle.copyWith(
              color: Colors.white,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '${barber.title} • ${barber.experience} years exp',
            style: AppTextStyles.caption.copyWith(color: Colors.grey[400]),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined, size: 14.sp, color: Colors.grey[400]),
              Text(
                '${barber.location} • ${barber.distance.toStringAsFixed(1)} km away',
                style: AppTextStyles.caption.copyWith(color: Colors.grey[400]),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, size: 14.sp, color: Colors.amber),
              SizedBox(width: 4.w),
              Text(
                '${barber.rating}(${barber.reviewCount} reviews)',
                style: AppTextStyles.caption.copyWith(color: Colors.grey[400]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Stats Row ──
class _StatsRow extends StatelessWidget {
  final BarberModel barber;
  const _StatsRow({required this.barber});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatItem(value: '${barber.totalBookings}', label: 'Bookings'),
        _divider(),
        _StatItem(value: '${barber.experience}+', label: 'Years Exp.'),
        _divider(),
        _StatItem(value: '${barber.rating.toInt()}%', label: 'Rating'),
      ],
    );
  }

  Widget _divider() => Container(
    width: 1,
    height: 40.h,
    color: Colors.grey[300],
  );
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.sectionTitle.copyWith(
              color: AppColors.textBlack1,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.textBlack2)),
        ],
      ),
    );
  }
}

// ── Info Tile ──
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  const _InfoTile({required this.icon, required this.iconColor, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant1,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: iconColor),
          SizedBox(width: 10.w),
          Text(text, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textBlack1)),
        ],
      ),
    );
  }
}

// ── Check Tile ──
class _CheckTile extends StatelessWidget {
  final String text;
  const _CheckTile({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant1,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Icon(Icons.check, size: 16.sp, color: AppColors.primary),
            SizedBox(width: 10.w),
            Text(text, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textBlack1)),
          ],
        ),
      ),
    );
  }
}

// ── Badge Tile ──
class _BadgeTile extends StatelessWidget {
  final IconData icon;
  final String text;
  const _BadgeTile({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant1,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18.sp, color: AppColors.primary),
            SizedBox(width: 10.w),
            Text(text, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textBlack1)),
          ],
        ),
      ),
    );
  }
}

// ── Review Tile ──
class _ReviewTile extends StatelessWidget {
  final ReviewModel review;
  const _ReviewTile({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant1,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, color: Colors.grey[500], size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(review.reviewerName,
                    style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w600, color: AppColors.textBlack1)),
                Text(review.timeAgo,
                    style: AppTextStyles.caption.copyWith(color: AppColors.textBlack2)),
              ],
            ),
          ),
          Row(
            children: List.generate(
              5,
                  (i) => Icon(
                Icons.star,
                size: 14.sp,
                color: i < review.rating.toInt() ? Colors.amber : Colors.grey[300],
              ),
            ),
          ),
        ],
      ),
    );
  }
}