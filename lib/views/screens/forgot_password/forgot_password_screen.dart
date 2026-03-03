import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/forgot_password_controller.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';
import '../../base/sign_up_row.dart';
import 'forgot_password_otp_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                      MediaQuery.of(context).padding.bottom,
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

                      SizedBox(height: 100.h),

                      // ── Title ──
                      Text(
                        'Forgot Password',
                        style: AppTextStyles.onboardingTitle.copyWith(
                          color: AppColors.textBlack1,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Enter your email address and we'll send you a\nverification code.",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.onboardingSubtitle.copyWith(
                          color: AppColors.textSecondary1,
                          fontWeight: FontWeight.w600,
                          height: 1.6,
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // ── Email Field ──
                      CustomTextField(
                        controller: controller.emailController,
                        hint: 'your@email.com',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Image.asset(
                            'assets/images/email_icon.png',
                            width: 20.w,
                            height: 20.w,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        errorText: controller.emailError,
                        label: 'Email Address',
                      ),

                      SizedBox(height: 32.h),

                      // ── Send Button ──
                      CustomButton(
                        label: 'Send Verification Code',
                        isLoading: controller.isLoading,
                        isEnabled: true,
                        onTap: () async {
                          await controller.sendVerificationCode();
                          if (controller.step == ForgotPasswordStep.enterOtp) {
                            Get.to(() => const ForgotPasswordOtpScreen());
                          }
                        },
                      ),

                      SizedBox(height: 250.h),

                      // ── Sign Up Link ──
                      SignUpRow(
                        onTap: controller.goToSignUp,
                          isLoginMode: false,
                        signUpColor: AppColors.textPrimary
                      ),
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