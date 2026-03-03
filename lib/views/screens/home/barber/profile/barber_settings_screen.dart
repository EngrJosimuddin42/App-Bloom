import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_text_styles.dart';
import 'barber_edit_profile_screen.dart';
import 'barber_change_password_screen.dart';

class BarberSettingsScreen extends StatelessWidget {
  const BarberSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
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
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
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
                      _SectionTitle(title: 'Account'),
                      SizedBox(height: 8.h),
                      _SettingsItem(
                        icon: Icons.person_outline,
                        iconColor: Colors.purple,
                        iconBg: Colors.purple.shade50,
                        title: 'Edit Profile',
                        onTap: () => Get.to(() => const BarberEditProfileScreen(),
                            transition: Transition.rightToLeft),
                      ),
                      _SettingsItem(
                        icon: Icons.notifications_outlined,
                        iconColor: Colors.blue,
                        iconBg: Colors.blue.shade50,
                        title: 'Notification',
                        trailing: Switch(
                          value: true,
                          onChanged: (val) {},
                          activeColor: Colors.green,
                        ),
                        showArrow: false,
                      ),
                      _SettingsItem(
                        icon: Icons.lock_outline,
                        iconColor: Colors.orange,
                        iconBg: Colors.orange.shade50,
                        title: 'Change Password',
                        onTap: () => Get.to(() => const BarberChangePasswordScreen(),
                            transition: Transition.rightToLeft),
                      ),

                      SizedBox(height: 16.h),

                      // ── Payment ──
                      _SectionTitle(title: 'Payment'),
                      SizedBox(height: 8.h),
                      _SettingsItem(
                        icon: Icons.credit_card_outlined,
                        iconColor: Colors.green,
                        iconBg: Colors.green.shade50,
                        title: 'Payment Methods',
                        onTap: () {},
                      ),

                      SizedBox(height: 16.h),

                      // ── Support ──
                      _SectionTitle(title: 'Support'),
                      SizedBox(height: 8.h),
                      _SettingsItem(
                        icon: Icons.help_outline,
                        iconColor: Colors.teal,
                        iconBg: Colors.teal.shade50,
                        title: 'Help Centre',
                        onTap: () {},
                      ),

                      SizedBox(height: 32.h),

                      // ── Logout ──
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: logout logic
                          },
                          icon: Icon(Icons.logout,
                              size: 18.r, color: Colors.red.shade300),
                          label: Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.red.shade300,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            side: BorderSide(color: Colors.red.shade200),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
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
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w700,
        color: Colors.grey.shade600,
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showArrow;

  const _SettingsItem({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    this.onTap,
    this.trailing,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFEEEEEE)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, size: 18.r, color: iconColor),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
            ),
            trailing ??
                (showArrow
                    ? Icon(Icons.arrow_forward_ios,
                    size: 14.r, color: Colors.grey)
                    : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}