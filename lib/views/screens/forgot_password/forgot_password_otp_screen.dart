import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/forgot_password_controller.dart';
import '../../../themes/app_colors.dart';
import '../../base/custom_button.dart';
import '../../base/otp_input_field.dart';
import '../../base/sign_up_row.dart';
import 'forgot_password_new_password_screen.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  final ForgotPasswordController controller;

  const ForgotPasswordOtpScreen({super.key, required this.controller});

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());

  ForgotPasswordController get _controller => widget.controller;

  @override
  void dispose() {
    for (final f in _otpFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  Future<void> _onVerify() async {
    await _controller.verifyCode(context);
    if (_controller.step == ForgotPasswordStep.createPassword &&
        context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              ForgotPasswordNewPasswordScreen(controller: _controller),
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

                  SizedBox(height: 80.h),

                  // ── Title ──
                  Text(
                    'Enter Verification Code',
                    style: GoogleFonts.montserrat(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.bg,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "We've sent a 6-digit code to",
                    style: GoogleFonts.montserrat(
                        fontSize: 13.sp, color: AppColors.textSecondary),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _controller.sentEmail,
                    style: GoogleFonts.montserrat(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4A90E2),
                    ),
                  ),

                  SizedBox(height: 36.h),

                  // ── OTP Boxes ──
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (i) {
                      return OtpInputField(
                        controller: _controller.otpControllers[i],
                        focusNode: _otpFocusNodes[i],
                        onChanged: (val) {
                          if (val.isNotEmpty && i < 5) {
                            _otpFocusNodes[i + 1].requestFocus();
                          } else if (val.isEmpty && i > 0) {
                            _otpFocusNodes[i - 1].requestFocus();
                          }
                          _controller.notifyListeners();
                        },
                      );
                    }),
                  ),

                  if (_controller.otpError != null) ...[
                    SizedBox(height: 8.h),
                    Text(
                      _controller.otpError!,
                      style: GoogleFonts.montserrat(
                          fontSize: 11.sp, color: Colors.redAccent),
                    ),
                  ],

                  SizedBox(height: 24.h),

                  // ── Verify Button ──
                  GradientButton(
                    label: 'Verify Code',
                    isLoading: _controller.isLoading,
                    isEnabled: true,
                    onTap: _onVerify,
                  ),

                  SizedBox(height: 16.h),

                  // ── Resend Timer ──
                  GestureDetector(
                    onTap:
                    _controller.canResend ? _controller.resendCode : null,
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.montserrat(
                            fontSize: 13.sp, color: AppColors.textSecondary),
                        children: [
                          const TextSpan(text: 'Resend code in '),
                          TextSpan(
                            text: _controller.canResend
                                ? 'Resend now'
                                : '${_controller.resendSeconds}s',
                            style: GoogleFonts.montserrat(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: _controller.canResend
                                  ? AppColors.bg
                                  : const Color(0xFF4A90E2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // ── Info Box ──
                  Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4FF),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline,
                            size: 18.sp, color: const Color(0xFF4A90E2)),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            "Check your spam folder if you don't see the code. The code expires in 10 minutes.",
                            style: GoogleFonts.montserrat(
                                fontSize: 12.sp,
                                color: AppColors.textSecondary,
                                height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 120.h),
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