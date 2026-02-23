import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/forgot_password_controller.dart';
import '../../../themes/app_colors.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';
import '../../base/password_requirement_row.dart';
import '../../base/sign_up_row.dart';

class ForgotPasswordNewPasswordScreen extends StatelessWidget {
  final ForgotPasswordController controller;

  const ForgotPasswordNewPasswordScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textPrimary,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 48.h),

                  // ── Logo ──
                  Center(
                    child: Icon(Icons.content_cut_outlined,
                        size: 36.sp, color: AppColors.bg),
                  ),

                  SizedBox(height: 40.h),

                  // ── Title ──
                  Center(
                    child: Text(
                      'Create New Password',
                      style: GoogleFonts.montserrat(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bg,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Center(
                    child: Text(
                      'Provide new password',
                      style: GoogleFonts.montserrat(
                          fontSize: 13.sp, color: AppColors.textSecondary),
                    ),
                  ),

                  SizedBox(height: 28.h),

                  // ── New Password ──
                  AppInputField(
                    controller: controller.newPasswordController,
                    hint: '• • • • • • • • •',
                    prefixIcon: Icons.key_outlined,
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
                  AppInputField(
                    controller: controller.confirmPasswordController,
                    hint: '• • • • • • • • •',
                    prefixIcon: Icons.key_outlined,
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
                      style: GoogleFonts.montserrat(
                          fontSize: 11.sp, color: Colors.redAccent),
                    ),
                  ],

                  SizedBox(height: 16.h),

                  // ── Password Requirements Box ──
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4FF),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password must contain:',
                          style: GoogleFonts.montserrat(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.bg),
                        ),
                        SizedBox(height: 10.h),
                        ...controller.passwordRequirements.map((req) =>
                            Padding(
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
                  GradientButton(
                    label: 'Reset Password',
                    isLoading: controller.isLoading,
                    isEnabled: true,
                    onTap: () => controller.resetPassword(context),
                  ),

                  SizedBox(height: 150.h),
                  Center(
                    child: SignUpRow(
                        onTap: () => controller.goToSignUp(context),
                      signUpColor: const Color(0xFF5B89FF),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}