import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../themes/app_colors.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final String avatarUrl;
  final String service;
  final String date;
  final int userRating;
  final ValueChanged<int> onRatingChanged;

  const ReviewCard({
    super.key,
    required this.name,
    required this.avatarUrl,
    required this.service,
    required this.date,
    required this.userRating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.border3)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top Row ──
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: NetworkImage(avatarUrl),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.border3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: List.generate(
                        5,
                            (i) => Image.asset('assets/images/star.png', width: 15.r, height: 15.r,color: AppColors.orange,),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      service,
                      style: TextStyle(fontSize: 12.sp, color: AppColors.border4),
                    ),
                  ],
                ),
              ),
              Text(
                date,
                style: TextStyle(fontSize: 12.sp, color: AppColors.border3),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // ── Provide Your Rating ──
          Text(
            'Provide Your Rating',
            style: TextStyle(fontSize: 14.sp, color: AppColors.border4),
          ),
          SizedBox(height: 8.h),
          Row(
            children: List.generate(5, (i) {
              final filled = i < userRating;
              return GestureDetector(
                onTap: () => onRatingChanged(i + 1),
                child: Padding(
                  padding: EdgeInsets.only(right: 6.w),
                  child: Image.asset(
                    filled ? 'assets/images/star.png' : 'assets/images/star.png',
                    width: 28.r,
                    height: 28.r,
                    color: filled ? AppColors.textYellow : AppColors.backgroundAss2,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}