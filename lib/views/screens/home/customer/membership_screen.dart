import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundBlack1,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundBlack1,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Membership',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: [
              // ── The Routine ──
              _MembershipCard(
                title: 'The Routine',
                subtitle: 'Essential Care',
                tagline: 'Well kept, without excess.',
                price: '329',
                features: const [
                  'Once per month',
                  'Beard trim & shave',
                  'Standard booking',
                ],
                isHighlighted: false,
              ),

              SizedBox(height: 16.h),

              // ── The Standard Plus ──
              _MembershipCard(
                title: 'The Standard Plus',
                subtitle: 'The Quietly Superior Option',
                tagline: 'Consistency is the true luxury.',
                price: 'R549',
                features: const [
                  'Every second week',
                  'Beard trim & shave',
                  'Priority booking',
                  'One complimentary reschedule per month',
                ],
                isHighlighted: true,
              ),

              SizedBox(height: 16.h),

              // ── The Inner Circle ──
              _MembershipCard(
                title: 'The Inner Circle',
                subtitle: 'Private • Unspoken',
                tagline: 'For those who require certainty.',
                price: '1199',
                features: const [
                  'Every week',
                  'Beard trim & shave',
                  'VIP scheduling',
                  'Same-barber preference',
                  'Same-day booking when available',
                ],
                isHighlighted: false,
              ),

              SizedBox(height: 24.h),

              // ── Footer ──
              Text(
                'All memberships include professional service\nand premium products.',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textBlack,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 6.h),
              Text(
                'Unused sessions expire and cannot be carried forward',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textBlack2,
                  fontSize: 11.sp,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _MembershipCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String tagline;
  final String price;
  final List<String> features;
  final bool isHighlighted;

  const _MembershipCard({
    required this.title,
    required this.subtitle,
    required this.tagline,
    required this.price,
    required this.features,
    required this.isHighlighted,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isHighlighted ? const Color(0xFF1A1A2E) : AppColors.background;
    final textColor = isHighlighted ? Colors.white : AppColors.textBlack;
    final subtitleColor = isHighlighted ? Colors.white60 : AppColors.textBlack2;
    final dividerColor = isHighlighted ? Colors.white24 : Colors.grey.shade200;
    final checkColor = isHighlighted ? Colors.white70 : AppColors.textBlack;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14.r),
        border: isHighlighted
            ? null
            : Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: AppTextStyles.sectionTitle.copyWith(
              color: textColor,
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: AppTextStyles.caption.copyWith(
              color: subtitleColor,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            tagline,
            style: AppTextStyles.caption.copyWith(
              color: subtitleColor,
              fontSize: 12.sp,
            ),
          ),

          SizedBox(height: 14.h),

          // Price
          Text(
            '$price/month',
            style: AppTextStyles.sectionTitle.copyWith(
              color: textColor,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 14.h),
          Divider(color: dividerColor, height: 1),
          SizedBox(height: 14.h),

          // Features
          ...features.map(
                (f) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                children: [
                  Icon(Icons.check, size: 16.sp, color: checkColor),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      f,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: checkColor,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 8.h),

          // Subscribe Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isHighlighted ? Colors.white : AppColors.textBlack,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                elevation: 0,
              ),
              child: Text(
                'Subscribe',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isHighlighted ? AppColors.textBlack : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}