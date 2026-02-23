import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/onboarding_model.dart';

class OnboardingPageView extends StatelessWidget {
  final OnboardingModel data;

  const OnboardingPageView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon Box
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              color: const Color(0x3C3C4333),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              data.icon,
              color: Colors.black,
              size: 44.sp,
            ),
          ),

          SizedBox(height: 48.h),

          // Title
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),

          SizedBox(height: 16.h),

          // Description
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF8F8F8F),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}