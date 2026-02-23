import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/login_controller.dart';
import '../../themes/app_colors.dart';
import '../base/custom_button.dart';
import '../base/custom_text_field.dart';
import '../base/sign_up_row.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _controller = LoginController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

                  // ── Scissors Logo ──
                  Icon(
                    Icons.content_cut_outlined,
                    size: 36.sp,
                    color: AppColors.bg,
                  ),

                  SizedBox(height: 28.h),

                  // ── Title ──
                  Text(
                    'Welcome Back!',
                    style: GoogleFonts.montserrat(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.bg,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  // ── Subtitle ──
                  Text(
                    'Sign in to continue your journey',
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  SizedBox(height: 36.h),

                  // ── Email Field ──
                  AppInputField(
                    controller: _controller.emailController,
                    hint: 'your@email.com',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    errorText: _controller.emailError,
                    label: 'Email',
                  ),
                  SizedBox(height: 20.h),

                  // ── Password Field ──
                  AppInputField(
                    controller: _controller.passwordController,
                    hint: '• • • • • • • • •',
                    prefixIcon: Icons.key_outlined,
                    obscureText: _controller.obscurePassword,
                    errorText: _controller.passwordError,
                    label: 'Password',
                    suffixIcon: GestureDetector(
                      onTap: _controller.togglePasswordVisibility,
                      child: Icon(
                        _controller.obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.textSecondary,
                        size: 20.sp,
                      ),
                    ),
                  ),

                  // ── Forgot Password ──
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => _controller.forgotPassword(context),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        overlayColor: Colors.transparent,
                      ),
                      child: Text(
                        'Forgot password?',
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.bg,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // ── Sign In Button ──
                  GradientButton(
                    label: 'Sign In',
                    isLoading: _controller.isLoading,
                    isEnabled: _controller.isFormFilled,
                    height: 48.h,
                    borderRadius: 8,
                    onTap: () => _controller.signIn(context),
                  ),

                  SizedBox(height: 250.h),

                  // ── Sign Up Link ──
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