import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/forgot_password_controller.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';
import '../../base/custom_button.dart';
import '../../base/password_field.dart';
import '../../base/password_requirement_row.dart';
import '../../base/sign_up_row.dart';

class ForgotPasswordNewPasswordScreen extends StatelessWidget {
  const ForgotPasswordNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());

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
                  child: GetBuilder<ForgotPasswordController>(
                    builder: (_) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top -
                                MediaQuery.of(context).padding.bottom -
                                10.h,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // ── Logo ──
                                Image.asset(
                                  'assets/images/content_cut_outlined.png',
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(height: 40.h),

                                // ── Title ──
                                Center(
                                  child: Text(
                                    'Create New Password',
                                    style:
                                    AppTextStyles.onboardingTitle.copyWith(
                                      color: AppColors.textBlack1,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Center(
                                  child: Text(
                                    'Provide new password',
                                    style: AppTextStyles.onboardingSubtitle,
                                  ),
                                ),

                                SizedBox(height: 18.h),

                                // ── New Password ──
                                PasswordField(
                                  controller: controller.newPasswordController,
                                  label: 'New Password',
                                ),

                                SizedBox(height: 16.h),

                                // ── Confirm Password ──
                                PasswordField(
                                  controller: controller.confirmPasswordController,
                                  label: 'Confirm Password',
                                  errorText: controller.passwordError,
                                ),

                                SizedBox(height: 24.h),

                                // ── Password Requirements Box ──
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(16.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceVariant1,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Password must contain:',
                                        style: AppTextStyles.bodyMedium
                                            .copyWith(
                                          color: AppColors.textBlack2,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      ...controller.passwordRequirements.map(
                                            (req) => Padding(
                                          padding:
                                          EdgeInsets.only(bottom: 6.h),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}