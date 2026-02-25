import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/forgot_password_controller.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';
import '../../base/password_requirement_row.dart';
import '../../base/sign_up_row.dart';

class ForgotPasswordNewPasswordScreen extends StatelessWidget {
  const ForgotPasswordNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: GetBuilder<ForgotPasswordController>(
          builder: (_) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 48.h),

                      // ── Logo ──
                      Center(
                        child: Image.asset(
                          'assets/images/content_cut_outlined.png',
                          height: 150,
                          width: 150,
                          fit: BoxFit.contain,
                        ),
                      ),

                      SizedBox(height: 40.h),

                      // ── Title ──
                      Center(
                        child: Text(
                          'Create New Password',
                          style: AppTextStyles.onboardingTitle.copyWith(
                            color: AppColors.textBlack,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Center(
                        child: Text(
                          'Provide new password',
                          style: AppTextStyles.onboardingSubtitle,
                        ),
                      ),

                      SizedBox(height: 28.h),

                      // ── New Password ──
                      CustomTextField(
                        controller: controller.newPasswordController,
                        hint: '• • • • • • • • •',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Image.asset(
                            'assets/images/key.png',
                            width: 20.w,
                            height: 20.w,
                          ),
                        ),
                        obscureText: controller.obscureNew,
                        label: 'New Password',
                        suffixIcon: GestureDetector(
                          onTap: controller.toggleObscureNew,
                          child: Icon(
                            controller.obscureNew
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.textSecondary,
                            size: 20.sp,
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // ── Confirm Password ──
                      CustomTextField(
                        controller: controller.confirmPasswordController,
                        hint: '• • • • • • • • •',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Image.asset(
                            'assets/images/key.png',
                            width: 20.w,
                            height: 20.w,
                          ),
                        ),
                        obscureText: controller.obscureConfirm,
                        label: 'Confirm Password',
                        suffixIcon: GestureDetector(
                          onTap: controller.toggleObscureConfirm,
                          child: Icon(
                            controller.obscureConfirm
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.textSecondary,
                            size: 20.sp,
                          ),
                        ),
                      ),

                      if (controller.passwordError != null) ...[
                        SizedBox(height: 6.h),
                        Text(
                          controller.passwordError!,
                          style: AppTextStyles.inputError,
                        ),
                      ],

                      SizedBox(height: 16.h),

                      // ── Password Requirements Box ──
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password must contain:',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textBlack,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            ...controller.passwordRequirements.map(
                                  (req) => Padding(
                                padding: EdgeInsets.only(bottom: 6.h),
                                child: PasswordRequirementRow(
                                  met: req.met,
                                  label: req.label,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // ── Reset Button ──
                      CustomButton(
                        label: 'Reset Password',
                        isLoading: controller.isLoading,
                        isEnabled: true,
                        onTap: controller.resetPassword,
                      ),

                      const Spacer(),

                      // ── Sign Up Link ──
                      Center(
                        child: SignUpRow(
                          onTap: controller.goToSignUp,
                          signUpColor: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}