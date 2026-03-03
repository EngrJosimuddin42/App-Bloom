import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/sign_up_controller.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';
import '../../base/custom_button.dart';
import '../../base/otp_input_field.dart';

class SignUpOtpScreen extends StatefulWidget {
  const SignUpOtpScreen({super.key});

  @override
  State<SignUpOtpScreen> createState() => _SignUpOtpScreenState();
}

class _SignUpOtpScreenState extends State<SignUpOtpScreen> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final controller = Get.put(SignUpController());

  @override
  void dispose() {
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: GetBuilder<SignUpController>(
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
                      // ── Back ──
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: Get.back,
                          icon: const Icon(Icons.arrow_back_ios_new,
                              size: 14, color: AppColors.textBlack),
                          label: Text(
                            'Back',
                            style: AppTextStyles.bodyPrimary.copyWith(
                              color: AppColors.textBlack,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            overlayColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      // ── Email Icon ──
                      Container(
                        width: 120.w,
                        height: 110.w,
                        decoration: BoxDecoration(
                          color: AppColors.textWhite,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(18.w),
                          child: Image.asset(
                            'assets/images/mail.png',
                          ),
                        ),
                      ),
                      // ── Title ──
                      Text(
                        'Enter Verification Code',
                        style: AppTextStyles.onboardingTitle.copyWith(
                          color: AppColors.textBlack1,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 6.h),

                      Text(
                        "We've sent a 6-digit code to",
                        style: AppTextStyles.onboardingSubtitle,
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 4.h),

                      Text(
                        controller.sentEmail,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.info,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 24.h),

                      // ── OTP Boxes ──
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (i) {
                          return OtpInputField(
                            controller: controller.otpControllers[i],
                            focusNode: _focusNodes[i],
                            onChanged: (val) {
                              controller.onOtpChanged(i, val);
                              if (val.isNotEmpty && i < 5) {
                                _focusNodes[i + 1].requestFocus();
                              } else if (val.isEmpty && i > 0) {
                                _focusNodes[i - 1].requestFocus();
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

                      SizedBox(height: 20.h),

                      // ── Verify Button ──
                      CustomButton(
                        label: 'Verify Code',
                        isLoading: controller.isLoading,
                        isEnabled: controller.isOtpFilled,
                        onTap: controller.verifyOtp,
                      ),

                      SizedBox(height: 16.h),

                      // ── Resend Timer ──
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: AppColors.cardColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Obx(() => GestureDetector(
                            onTap: controller.canResend
                                ? controller.resendCode
                                : null,
                            child: RichText(
                              text: TextSpan(
                                style: AppTextStyles.bodySecondary.copyWith(
                                  fontSize: AppTextStyles.bodyPrimary.fontSize,
                                ),
                                children: [
                                  const TextSpan(text: 'Resend code in '),
                                  TextSpan(
                                    text: controller.canResend
                                        ? 'Resend Code'
                                        : '${controller.resendSeconds}s',
                                    style: AppTextStyles.bodySecondary.copyWith(
                                      fontSize:
                                      AppTextStyles.bodyPrimary.fontSize,
                                      fontWeight: FontWeight.w600,
                                      color: controller.canResend
                                          ? AppColors.border
                                          : AppColors.textBlack,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // ── Info Box ──
                      Container(
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: AppColors.cardColor,
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
                                  color: AppColors.border,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),
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