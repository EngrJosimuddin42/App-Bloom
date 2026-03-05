import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_text_styles.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/password_field.dart';

class BarberChangePasswordScreen extends StatelessWidget {
  const BarberChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPwController = TextEditingController();
    final newPwController     = TextEditingController();
    final confirmPwController = TextEditingController();

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
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Icon(Icons.arrow_back_ios_new,
                                  size: 18.r, color: AppColors.textBlack),
                            ),
                            SizedBox(width: 12.w),
                            Text('Change Password',
                                style: AppTextStyles.headingLarge.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textBlack,
                                )),
                          ],
                        ),
                      ),

                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8.h),

                              // ── Current Password ──
                              PasswordField(
                                controller: currentPwController,
                                label: 'Current Password',
                                labelColor: AppColors.textSecondary2,
                                labelFontSize: 14.sp,
                              ),
                              SizedBox(height: 14.h),

                              // ── New Password ──
                              PasswordField(
                                controller: newPwController,
                                label: 'New Password',
                                labelColor: AppColors.textSecondary2,
                                labelFontSize: 14.sp,
                              ),
                              SizedBox(height: 14.h),

                              // ── Confirm Password ──
                              PasswordField(
                                controller: confirmPwController,
                                label: 'Confirm Password',
                                labelColor: AppColors.textSecondary2,
                                labelFontSize: 14.sp,
                              ),

                              SizedBox(height: 380.h),

                              // ── Save Button ──
                              CustomButton(
                                label: 'Save Changes',
                                borderRadius: 12,
                                onTap: () {
                                  // TODO: change password logic
                                  Get.back();
                                },
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