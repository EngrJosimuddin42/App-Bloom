import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../themes/app_colors.dart';

class PasswordRequirementRow extends StatelessWidget {
  final bool met;
  final String label;

  const PasswordRequirementRow({
    super.key,
    required this.met,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 10.sp,
          color: met ? const Color(0xFF4CAF50) : AppColors.textSecondary,
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 12.sp,
            color: met ? AppColors.bg : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}