import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/login_controller.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';
import '../base/custom_button.dart';
import '../base/custom_text_field.dart';
import '../base/sign_up_row.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

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
                  child: GetBuilder<LoginController>(
                    builder: (_) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top -
                                MediaQuery.of(context).padding.bottom -
                                10.h, // ── status bar extended area ──
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // ── Scissors Logo ──
                                Image.asset(
                                  'assets/images/content_cut_outlined.png',
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.contain,
                                ),

                                // ── Title ──
                                Text(
                                  'Welcome Back!',
                                  style: AppTextStyles.onboardingTitle.copyWith(
                                    color: AppColors.textBlack,
                                  ),
                                ),

                                SizedBox(height: 6.h),

                                // ── Subtitle ──
                                Text(
                                  'Sign in to continue your journey',
                                  style:
                                  AppTextStyles.onboardingSubtitle.copyWith(
                                    color: AppColors.textSecondary,
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
                                  label: 'Email',
                                ),

                                SizedBox(height: 20.h),

                                // ── Password Field ──
                                CustomTextField(
                                  controller: controller.passwordController,
                                  hint: '* * * * * * * * *',
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(12.w),
                                    child: Image.asset(
                                      'assets/images/key.png',
                                      width: 20.w,
                                      height: 20.w,
                                    ),
                                  ),
                                  obscureText: controller.obscurePassword,
                                  errorText: controller.passwordError,
                                  label: 'Password',
                                  suffixIcon: GestureDetector(
                                    onTap:
                                    controller.togglePasswordVisibility,
                                    child: Padding(
                                      padding: EdgeInsets.all(12.w),
                                      child: Image.asset(
                                        controller.obscurePassword
                                            ? 'assets/images/view-of.png'
                                            : 'assets/images/view-on.png',
                                        width: 20.w,
                                        height: 20.w,
                                        color: AppColors.textBlack,
                                      ),
                                    ),
                                  ),
                                ),

                                // ── Forgot Password ──
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () =>
                                        controller.forgotPassword(context),
                                    style: TextButton.styleFrom(
                                      overlayColor: Colors.transparent,
                                    ),
                                    child: Text(
                                      'Forgot password?',
                                      style: AppTextStyles.link.copyWith(
                                        color: AppColors.textBlack,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 20.h),

                                // ── Sign In Button ──
                                CustomButton(
                                  label: 'Sign In',
                                  isLoading: controller.isLoading,
                                  isEnabled: controller.isFormFilled,
                                  height: 48.h,
                                  borderRadius: 8,
                                  onTap: () => controller.signIn(context),
                                ),

                                SizedBox(height: 220.h),

                                // ── Sign Up Link ──
                                SignUpRow(
                                    onTap: () =>
                                        controller.goToSignUp(context)),
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