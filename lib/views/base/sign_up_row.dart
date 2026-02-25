import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';

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
          style: AppTextStyles.bodySecondary,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            'Sign Up',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: signUpColor ?? AppColors.textBlack,
            ),
          ),
        ),
      ],
    );
  }
}