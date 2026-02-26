import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/forgot_password_controller.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';
import '../../base/custom_button.dart';
import '../../base/otp_input_field.dart';
import '../../base/sign_up_row.dart';
import 'forgot_password_new_password_screen.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  const ForgotPasswordOtpScreen({super.key});

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());
  final controller = Get.put(ForgotPasswordController());

  @override
  void dispose() {
    for (final f in _otpFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      Text(
                        'Enter Verification Code',
                        style: AppTextStyles.onboardingTitle.copyWith(
                          color: AppColors.textBlack1,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "We've sent a 6-digit code to",
                        style: AppTextStyles.onboardingSubtitle,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        controller.sentEmail,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.info,
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // ── OTP Boxes ──
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (i) {
                          return OtpInputField(
                            controller: controller.otpControllers[i],
                            focusNode: _otpFocusNodes[i],
                            onChanged: (val) {
                              if (val.isNotEmpty && i < 5) {
                                _otpFocusNodes[i + 1].requestFocus();
                              } else if (val.isEmpty && i > 0) {
                                _otpFocusNodes[i - 1].requestFocus();
                              }
                            },
                          );
                        }),
                      ),

                      if (controller.otpError != null) ...[
                        SizedBox(height: 8.h),
                        Text(
                          controller.otpError!,
                          style: AppTextStyles.inputError,
                        ),
                      ],

                      SizedBox(height: 24.h),

                      // ── Verify Button ──
                      CustomButton(
                        label: 'Verify Code',
                        isLoading: controller.isLoading,
                        isEnabled: true,
                        onTap: () async {
                          await controller.verifyCode();
                          if (controller.step ==
                              ForgotPasswordStep.createPassword) {
                            Get.to(
                                    () => const ForgotPasswordNewPasswordScreen());
                          }
                        },
                      ),

                      SizedBox(height: 32.h),

                      // ── Resend Timer ─
          Container(
            width: double.infinity,
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
          color: AppColors.surfaceVariant1,
          borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() => GestureDetector(
                        onTap:
                        controller.canResend ? controller.resendCode : null,
                        child: RichText(
                          text: TextSpan(
                            style: AppTextStyles.bodySecondary,
                            children: [
                              const TextSpan(text: 'Resend code in '),
                              TextSpan(
                                text: controller.canResend
                                    ? 'Resend now'
                                    : '${controller.resendSeconds}s',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: controller.canResend
                                      ? AppColors.textPrimary
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ),
                      ],
                     ),
                     ),

                      SizedBox(height: 16.h),

                      // ── Info Box ──
                      Container(
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant1,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 18.sp,
                              color: AppColors.info,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                "Check your spam folder if you don't see the code. The code expires in 10 minutes.",
                                style: AppTextStyles.caption.copyWith(
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),

                      // ── Sign Up Link ──
                      SignUpRow(onTap: controller.goToSignUp,
                        signUpColor: AppColors.textPrimary
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