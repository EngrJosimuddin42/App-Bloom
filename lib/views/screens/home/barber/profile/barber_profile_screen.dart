import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../base/outlined_icon_button.dart';
import '../../../../base/stat_box.dart';
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
    final c = Get.find<BarberHomeController>();


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
                            Text('My Profile',
                                style: AppTextStyles.headingLarge.copyWith(
                                  color: AppColors.textBlack,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                )),
                            GestureDetector(
                              onTap: () => Get.to(() => const BarberSettingsScreen(),
                                  transition: Transition.rightToLeft),
                                child: Icon(Icons.settings_outlined,
                                    size: 20.r, color: AppColors.textBlack),
                              ),
                          ],
                        ),
                      ),

                      // ── Avatar + Info ──
                     Obx(() => Center(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 46.r,
                                  backgroundImage: c.avatarUrl.isNotEmpty
                                      ? NetworkImage(c.avatarUrl)
                                      : null,
                                  child: c.avatarUrl.isEmpty
                                       ? Icon(Icons.person, size: 46.r, color: Colors.grey)
                                      : null,
                                ),
                                Positioned(
                                  bottom: 0, right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(4.r),
                                    decoration: BoxDecoration(
                                        color: AppColors.textSecondary2, shape: BoxShape.circle),
                                    child: Icon(Icons.camera_alt,
                                        size: 12.r, color: AppColors.background),
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
                                  child: Text(c.userName,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.headingLarge.copyWith(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textBlack,
                                      )),
                                ),
                                SizedBox(width: 4.w),
                                Image.asset('assets/images/checkmark-badge.png', width: 24.r, height: 24.r),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset('assets/images/lucide_map-pin.png', width: 14.r, height: 14.r),

                                SizedBox(width: 2.w),
                                Text(c.location,
                                    style: TextStyle(fontSize: 13.sp, color: AppColors.textBlack)),
                              ],
                            ),
                          ],
                        ),
                      )),

                      SizedBox(height: 16.h),

                      // ── Stats Row ──
                      Obx(() => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            StatBox(iconPath: 'assets/images/star.png',
                                value: c.rating, label: c.reviewCount),
                            SizedBox(width: 10.w),
                            StatBox(iconPath: '',
                                value: c.jobsDone, label: 'Jobs Done'),
                            SizedBox(width: 10.w),
                            StatBox(iconPath: '',
                                value: c.experience, label: 'Experience'),
                          ],
                        ),
                      )),

                      SizedBox(height: 16.h),

                      // ── Online Toggle ──
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Obx(() => Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color:AppColors.cardColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 8.r, height: 8.r,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: c.isOnline ? Colors.green : Colors.grey,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    c.isOnline ? 'You are Online' : 'You are Offline',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textBlack),
                                  ),
                                  Text(
                                    c.isOnline
                                        ? 'Accepting new booking'
                                        : 'Not accepting bookings',
                                    style: TextStyle(fontSize: 11.sp, color:AppColors.border),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Switch(
                                value: c.isOnline,
                                onChanged: c.toggleOnlineStatus,
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
                            OutlinedIconButton(
                              iconPath: 'assets/images/trend_icon.png',
                              backgroundColor: AppColors.backgroundBlack,
                              iconColor: AppColors.textWhite,
                              textColor: AppColors.textWhite,
                              label: 'View Earnings',
                              onPressed: c.goToEarnings,
                            ),
                            SizedBox(width: 10.w),
                            OutlinedIconButton(
                              iconPath: 'assets/images/hugeicons_note.png',
                              backgroundColor: AppColors.background,
                              iconColor: AppColors.textBlack,
                              textColor: AppColors.textBlack,
                              label: 'Reviews',
                              onPressed: c.goToReviews,
                            ),
                          ],
                        )
                      ),

                      SizedBox(height: 24.h),

                      // ── Work Gallery ──
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text('Work Gallery',
                            style: AppTextStyles.headingLarge.copyWith(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textBlack,
                            )),
                      ),
                      SizedBox(height: 12.h),
                      Obx(() => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: c.galleryImages.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 10.h,
                            childAspectRatio: 1.0,
                          ),
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.network(
                                    c.galleryImages[index],
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Container(
                                          color: Colors.grey.shade200,
                                          child: Icon(Icons.image_not_supported_outlined,
                                              color: Colors.grey, size: 32.r),
                                        ),
                                  ),
                                ),
                                Positioned(
                                  top: 6.r, right: 6.r,
                                  child: GestureDetector(
                                    onTap: () => c.deleteGalleryImage(index),
                                    child: Container(
                                      height: 30.h,
                                      width: 30.w,
                                      padding: EdgeInsets.all(4.r),
                                      decoration: BoxDecoration(
                                        color: AppColors.backgroundBlack,
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      child: Image.asset(
                                        'assets/images/delete.png',
                                        width: 24.r,
                                        height: 24.r,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )),

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
              ],
            ),
        ),
    ),
    );
  }
}