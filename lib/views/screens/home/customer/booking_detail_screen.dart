import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';

class BookingDetailScreen extends StatelessWidget {
  const BookingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ── Map Section ──
                    _MapPlaceholder(),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // ── Barber Info ──
                          Text(
                            'Marcus Johnson',
                            style: AppTextStyles.onboardingTitle.copyWith(
                              color: AppColors.textBlack,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Master Barber',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textBlack2,
                              fontSize: 13.sp,
                            ),
                          ),

                          SizedBox(height: 14.h),

                          // ── Message Button ──
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.grey.shade300),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 13.h),
                              ),
                              child: Text(
                                'Message',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textBlack,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 24.h),

                          // ── Job Details ──
                          Text(
                            'Job Details',
                            style: AppTextStyles.sectionTitle.copyWith(
                              color: AppColors.textBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10.h),

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              children: [
                                _DetailRow(
                                  icon: Icons.content_cut,
                                  iconBg: Colors.purple.shade50,
                                  iconColor: Colors.purple,
                                  title: 'Service',
                                  subtitle: "Men's Haircut\n30 minutes • \$35.00",
                                  showDivider: true,
                                ),
                                _DetailRow(
                                  icon: Icons.access_time_outlined,
                                  iconBg: Colors.blue.shade50,
                                  iconColor: Colors.blue,
                                  title: 'Scheduled Time',
                                  subtitle: 'Today, 2:00 PM',
                                  showDivider: true,
                                ),
                                _DetailRow(
                                  icon: Icons.location_on_outlined,
                                  iconBg: Colors.green.shade50,
                                  iconColor: Colors.green,
                                  title: 'Destination',
                                  subtitle: '123 Main Street\nDowntown, Apartment 4B',
                                  showDivider: false,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 24.h),

                          // ── Live Updates ──
                          Text(
                            'Live updates',
                            style: AppTextStyles.sectionTitle.copyWith(
                              color: AppColors.textBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10.h),

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              children: [
                                _DetailRow(
                                  icon: Icons.access_time_outlined,
                                  iconBg: Colors.blue.shade50,
                                  iconColor: Colors.blue,
                                  title: 'Barber started journey',
                                  subtitle: '2 mins ago',
                                  showDivider: true,
                                ),
                                _DetailRow(
                                  icon: Icons.location_on_outlined,
                                  iconBg: Colors.green.shade50,
                                  iconColor: Colors.green,
                                  title: 'En route to your location',
                                  subtitle: 'Now',
                                  showDivider: false,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Bottom Buttons ──
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 32.h),
              color: AppColors.background,
              child: Column(
                children: [
                  // Work Done
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.textBlack,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        elevation: 0,
                      ),
                      child: Text(
                        'Work Done',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  // Cancel Booking
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.red.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                      ),
                      child: Text(
                        'Cancel Booking',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Map Placeholder (real map পরে integrate করুন) ──
class _MapPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 220.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFE8E0D0),
            border: Border.all(color: Colors.blue.shade300, width: 2),
          ),
          child: Center(
            child: Icon(Icons.map_outlined, size: 60.sp, color: Colors.grey.shade400),
          ),
        ),

        // ETA Card
        Positioned(
          top: 16.h,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 8),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.navigation, size: 16.sp, color: Colors.orange),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ETA',
                          style: AppTextStyles.caption.copyWith(
                              color: AppColors.textBlack2, fontSize: 10.sp)),
                      Text('5 minutes',
                          style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.w700,
                              fontSize: 13.sp)),
                    ],
                  ),
                  SizedBox(width: 16.w),
                  Container(width: 1, height: 28.h, color: Colors.grey.shade300),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Distance',
                          style: AppTextStyles.caption.copyWith(
                              color: AppColors.textBlack2, fontSize: 10.sp)),
                      Text('1.2 km',
                          style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.w700,
                              fontSize: 13.sp)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // Back button
        Positioned(
          top: 40.h,
          left: 8.w,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Icon(Icons.arrow_back_ios, size: 16.sp, color: AppColors.textBlack),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Detail Row ──
class _DetailRow extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool showDivider;

  const _DetailRow({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, size: 18.sp, color: iconColor),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textBlack2,
                        fontSize: 12.sp,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(height: 1, color: Colors.grey.shade200, indent: 14.w, endIndent: 14.w),
      ],
    );
  }
}