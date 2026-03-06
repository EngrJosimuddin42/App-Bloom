import 'package:app_bloom/views/screens/home/barber/profile/view_earnings/barber_payment_method_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../controllers/barber_home_controller.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_text_styles.dart';
import '../../../../base/section_title.dart';
import '../../../../base/settings_item.dart';
import '../../../login_screen.dart';
import 'barber_edit_profile_screen.dart';
import 'barber_change_password_screen.dart';

class BarberSettingsScreen extends StatelessWidget {
  const BarberSettingsScreen({super.key});

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
                  Container(height: 10.h, color: AppColors.backgroundBlack1),

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
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(Icons.arrow_back_ios_new,
                          size: 18.r, color: AppColors.textBlack),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Settings',
                      style: AppTextStyles.headingLarge.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textBlack,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Account ──
                      SectionTitle(title: 'Account'),
                      SizedBox(height: 8.h),
                      SettingsItem(
                        iconPath: 'assets/images/user.png',
                        iconColor: AppColors.purple,
                        iconBg: AppColors.backgroundPurple,
                        title: 'Edit Profile',
                        onTap: () => Get.to(() => const BarberEditProfileScreen(),
                            transition: Transition.rightToLeft),
                      ),
                      SettingsItem(
                        iconPath: 'assets/images/notification.png',
                        iconColor: AppColors.backgroundBlue,
                        iconBg: AppColors.background1,
                        title: 'Notification',
                        trailing: Obx(() => Switch(
                          value: c.notificationEnabled,
                          onChanged: c.toggleNotification,
                          activeColor: Colors.green,
                        )),
                        showArrow: false,
                      ),
                      SettingsItem(
                        iconPath: 'assets/images/lock.png',
                        iconColor: AppColors.backgroundOrange,
                        iconBg: AppColors.backgroundOrange1,
                        title: 'Change Password',
                        onTap: () => Get.to(() => const BarberChangePasswordScreen(),
                            transition: Transition.rightToLeft),
                      ),

                      SizedBox(height: 16.h),

                      // ── Payment ──
                      SectionTitle(title: 'Payment'),
                      SizedBox(height: 8.h),
                      SettingsItem(
                        iconPath: 'assets/images/credit-card-pos.png',
                        iconColor: AppColors.secondary,
                        iconBg: AppColors.backgroundGreen1,
                        title: 'Payment Methods',
                        onTap: () => Get.to(() => const BarberPaymentMethodScreen(),
                            transition: Transition.rightToLeft),
                      ),

                      SizedBox(height: 16.h),

                      // ── Support ──
                      SectionTitle(title: 'Support'),
                      SizedBox(height: 8.h),
                      SettingsItem(
                        iconPath: 'assets/images/support.png',
                        iconColor: AppColors.backgroundBlue,
                        iconBg: AppColors.background1,
                        title: 'Help Centre',
                        onTap: () {},
                      ),

                      SizedBox(height: 120.h),

                      // ── Logout ──
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => Get.offAll(
                                () => const LoginScreen(),
                            transition: Transition.leftToRight,
                          ),
                          icon: Image.asset(
                            'assets/images/logout-square.png',
                            width: 24.r,
                            height: 24.r,
                            color: AppColors.borderRed,
                          ),
                          label: Text(
                            'Logout',
                            style: AppTextStyles.headingLarge.copyWith(
                              color: AppColors.borderRed,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.backgroundRed1,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            side: BorderSide(color: AppColors.borderRed),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],
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