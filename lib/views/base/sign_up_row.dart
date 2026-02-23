import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../themes/app_colors.dart';

class SignUpRow extends StatelessWidget {
  final VoidCallback onTap;
  final Color? signUpColor;

  const SignUpRow({super.key, required this.onTap, this.signUpColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: GoogleFonts.montserrat(
              fontSize: 13.sp, color: AppColors.textSecondary),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            'Sign Up',
            style: GoogleFonts.montserrat(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: signUpColor ?? AppColors.bg),
          ),
        ),
      ],
    );
  }
}






























