import 'package:app_bloom/views/screens/home/barber/profile/view_earnings/barber_earning_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'barber_settings_screen.dart';
import '../../../../../controllers/barber_home_controller.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_text_styles.dart';
import '../../../../base/barber_bottom_nav.dart';
import '../../../../base/barber_nav_helper.dart';


class BarberProfileScreen extends StatelessWidget {
  const BarberProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BarberHomeController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Header ──
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My Profile',
                              style: AppTextStyles.headingLarge.copyWith(
                                color: AppColors.textBlack,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.to(() => const BarberSettingsScreen(),
                                  transition: Transition.rightToLeft),
                              child: Container(
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.border1),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Icon(Icons.settings_outlined,
                                    size: 20.r, color: AppColors.textBlack),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ── Avatar + Info ──
                      Center(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 46.r,
                                  backgroundColor: Colors.grey.shade200,
                                  backgroundImage: const NetworkImage(
                                    'https://i.pravatar.cc/150?img=12',
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(4.r),
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.camera_alt,
                                        size: 12.r, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    controller.userName,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.headingLarge.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textBlack,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Icon(Icons.verified, size: 16.r, color: Colors.blue),
                              ],
                            ),

                            SizedBox(height: 4.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.location_on_outlined,
                                    size: 13.r, color: Colors.grey),
                                SizedBox(width: 2.w),
                                Text(
                                  'New York, USA',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // ── Stats Row ──
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            _StatBox(icon: Icons.star, value: '5', label: '127 reviews'),
                            SizedBox(width: 10.w),
                            _StatBox(icon: Icons.work_outline, value: '856', label: 'Job Bone'),
                            SizedBox(width: 10.w),
                            _StatBox(icon: Icons.calendar_today_outlined, value: '8 Years', label: 'Experience'),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // ── Online Toggle ──
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Obx(() => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 8.r,
                                height: 8.r,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: controller.isOnline
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.isOnline
                                        ? 'You are Online'
                                        : 'You are Offline',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textBlack,
                                    ),
                                  ),
                                  Text(
                                    controller.isOnline
                                        ? 'Accepting new booking'
                                        : 'Not accepting bookings',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Switch(
                                value: controller.isOnline,
                                onChanged: controller.toggleOnlineStatus,
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                        )),
                      ),

                      SizedBox(height: 16.h),

                      // ── Action Buttons ──
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => Get.to(
                                      () => const BarberEarningScreen(),
                                  transition: Transition.rightToLeft,
                                ),
                                icon: Icon(Icons.trending_up,
                                    size: 16.r, color: AppColors.textBlack),
                                label: Text(
                                  'View Earnings',
                                  style: TextStyle(
                                      color: AppColors.textBlack,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  side: BorderSide(color: AppColors.border1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.star_border,
                                    size: 16.r, color: AppColors.textBlack),
                                label: Text(
                                  'Reviews',
                                  style: TextStyle(
                                      color: AppColors.textBlack,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  side: BorderSide(color: AppColors.border1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // ── Work Gallery ──
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          'Work Gallery',
                          style: AppTextStyles.headingLarge.copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textBlack,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 6,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 10.h,
                            childAspectRatio: 1.0,
                          ),
                          itemBuilder: (context, index) {
                            // ✅ Fix: index 5 এর broken URL replace করা হয়েছে
                            final imageUrls = [
                              'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=300',
                              'https://images.unsplash.com/photo-1622286342621-4bd786c2447c?w=300',
                              'https://images.unsplash.com/photo-1605497788044-5a32c7078486?w=300',
                              'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?w=300',
                              'https://images.unsplash.com/photo-1621605815971-fbc98d665033?w=300',
                              'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=300',
                            ];
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.network(
                                    imageUrls[index],
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    // ✅ errorBuilder যোগ করা হয়েছে — future 404 handle করবে
                                    errorBuilder: (context, error, stackTrace) =>
                                        Container(
                                          color: Colors.grey.shade200,
                                          child: Icon(
                                            Icons.image_not_supported_outlined,
                                            color: Colors.grey,
                                            size: 32.r,
                                          ),
                                        ),
                                  ),
                                ),
                                Positioned(
                                  top: 6.r,
                                  right: 6.r,
                                  child: Container(
                                    padding: EdgeInsets.all(4.r),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.delete_outline,
                                        size: 14.r, color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),

              // ── Bottom Nav ──
              BarberBottomNav(
                currentIndex: 3,
                onTap: (index) => BarberNavHelper.onTap(index, 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _StatBox(
      {required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE5E5E5)),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18.r, color: AppColors.textBlack),
            SizedBox(height: 4.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textBlack,
              ),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 10.sp, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}