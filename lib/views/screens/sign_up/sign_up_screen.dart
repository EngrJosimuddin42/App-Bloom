 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/sign_up_controller.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';
import '../../base/role_toggle.dart';
import '../../base/sign_up_row.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());


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
                      // ── Logo ──
                      Image.asset(
                        'assets/images/content_cut_outlined.png',
                        height: 150.h,
                        width: 150.w,
                        fit: BoxFit.contain,
                      ),

                      // ── Title ──
                      Text(
                        'Create Account',
                        style: AppTextStyles.onboardingTitle.copyWith(
                          color: AppColors.textBlack,
                        ),
                      ),

                      SizedBox(height: 4.h),

                      Text(
                        'Choose Your Role First, Join as',
                        style: AppTextStyles.onboardingSubtitle,
                      ),

                      SizedBox(height: 16.h),

                      // ── Role Toggle ──
                      RoleToggle(
                        selectedRole: controller.isCustomer ? 'customer' : 'barber',
                        onRoleChanged: (role) => controller.selectRole(
                          role == 'customer' ? UserRole.customer : UserRole.barber,
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // ── First & Last Name ──
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: controller.firstNameController,
                              hint: 'your@Name',
                              label: 'First Name',
                              errorText: controller.firstNameError,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: CustomTextField(
                              controller: controller.lastNameController,
                              hint: 'your@Name',
                              label: 'Last Name',
                              errorText: controller.lastNameError,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 14.h),

                      // ── Email ──
                      CustomTextField(
                        controller: controller.emailController,
                        hint: 'your@email.com',
                        label: controller.isCustomer
                            ? 'Email'
                            : 'Professional Email',
                        keyboardType: TextInputType.emailAddress,
                        errorText: controller.emailError,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Image.asset(
                            'assets/images/email_icon.png',
                            width: 20.w,
                            height: 20.w,
                          ),
                        ),
                      ),

                      SizedBox(height: 14.h),

                      // ── Password ──
                      CustomTextField(
                        controller: controller.passwordController,
                        hint: '* * * * * * * * *',
                        label: 'Password',
                        obscureText: controller.obscurePassword,
                        errorText: controller.passwordError,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Image.asset(
                            'assets/images/key.png',
                            width: 20.w,
                            height: 20.w,
                          ),
                        ),
                        suffixIcon: Obx(() => GestureDetector(
                          onTap: controller.toggleObscurePassword,
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
                        )),
                      ),

                      SizedBox(height: 14.h),

                      // ── Confirm Password ──
                      CustomTextField(
                        controller: controller.confirmPasswordController,
                        hint: '* * * * * * * * *',
                        label: 'Confirm Password',
                        obscureText: controller.obscureConfirm,
                        errorText: controller.confirmError,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Image.asset(
                            'assets/images/key.png',
                            width: 20.w,
                            height: 20.w,
                          ),
                        ),
                        suffixIcon: Obx(() => GestureDetector(
                          onTap: controller.toggleObscureConfirm,
                          child: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: Image.asset(
                              controller.obscureConfirm
                                  ? 'assets/images/view-of.png'
                                  : 'assets/images/view-on.png',
                              width: 20.w,
                              height: 20.w,
                              color: AppColors.textBlack,
                            ),
                          ),
                        )),
                      ),

                      SizedBox(height: 28.h),

                      // ── Create Account Button ──
                      CustomButton(
                        label: 'Create Account',
                        isLoading: controller.isLoading,
                        isEnabled: controller.isFormFilled,
                        onTap: controller.createAccount,
                      ),

                      const Spacer(),

                      SizedBox(height: 16.h),

                      // ── Sign In Link ──
                      Center(
                        child: SignUpRow(
                          onTap: controller.goToLogin,
                          isLoginMode: true,
                          signUpColor: AppColors.textBlack,
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
