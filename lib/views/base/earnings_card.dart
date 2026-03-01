import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';

class EarningsCard extends StatelessWidget {
  final String earnings;
  final String earningsChange;
  final String earningsDate;

  const EarningsCard({
    super.key,
    required this.earnings,
    required this.earningsChange,
    required this.earningsDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      padding: EdgeInsets.all(25.w),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/earnings_card_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "This Week's Earnings",
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textWhite,
                ),
              ),
              Image.asset(
                'assets/images/content_cut1.png',
                width: 40.w,
                height: 40.w,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            earnings,
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 36.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/auto-conversations.png',
                    width: 16.w,
                    height: 16.w,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    earningsChange,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textWhite),
                  ),
                ],
              ),
              Text(
                earningsDate,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textWhite,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}