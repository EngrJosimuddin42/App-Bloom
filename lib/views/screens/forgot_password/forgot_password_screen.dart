import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/forgot_password_controller.dart';
import '../../../themes/app_colors.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';
import '../../base/sign_up_row.dart';
import 'forgot_password_otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ForgotPasswordController _controller = ForgotPasswordController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onSend() async {
    await _controller.sendVerificationCode(context);
    if (_controller.step == ForgotPasswordStep.enterOtp && context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ForgotPasswordOtpScreen(controller: _controller),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textPrimary,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 48.h),

                  // ── Logo ──
                  Icon(Icons.content_cut_outlined,
                      size: 36.sp, color: AppColors.bg),

                  SizedBox(height: 150.h),

                  // ── Title ──
                  Text(
                    'Forgot Password',
                    style: GoogleFonts.montserrat(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary1,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Enter your email address and we'll send you a\nverification code.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),

                  SizedBox(height: 26.h),

                  // ── Email Field ──
                  AppInputField(
                    controller: _controller.emailController,
                    hint: 'your@email.com',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    errorText: _controller.emailError,
                    label: 'Email Address',
                  ),

                  SizedBox(height: 24.h),

                  // ── Send Button ──
                  GradientButton(
                    label: 'Send Verification Code',
                    isLoading: _controller.isLoading,
                    isEnabled: true,
                    onTap: _onSend,
                  ),

                  SizedBox(height: 260.h),
                  SignUpRow(onTap: () => _controller.goToSignUp(context)),
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