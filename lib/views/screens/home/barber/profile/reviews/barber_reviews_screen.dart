
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../controllers/barber_home_controller.dart';
import '../../../../../../themes/app_colors.dart';
import '../../../../../../themes/app_text_styles.dart';
import '../../../../../base/rating_bar_chart.dart';
import '../../../../../base/review_card.dart';
import '../../../../../base/star_row.dart';

class BarberReviewsScreen extends StatelessWidget {
  const BarberReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<BarberHomeController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundBlack1,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundBlack1,
        body: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Status bar extended area ──
              Container(
                height: 10.h,
                color: AppColors.backgroundBlack1,
              ),

              // ── Main Content ──
              Expanded(
                child: ColoredBox(
                  color: AppColors.background,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // ── Header ──
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Icon(Icons.arrow_back_ios,
                                  size: 18.r, color: AppColors.textBlack),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Reviews',
                              style: AppTextStyles.headingLarge.copyWith(
                                color: AppColors.textBlack,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ── Body ──
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Obx(() => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                // ── Rating Summary Card ──
                                Container(
                                  padding: EdgeInsets.all(16.r),
                                  decoration: BoxDecoration(
                                    color: AppColors.cardColor,
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          // ── Big Rating Number ──
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                c.overallRating.toString(),
                                                style: TextStyle(
                                                  fontSize: 64.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.textBlack,
                                                  height: 1.1,
                                                ),
                                              ),
                                              StarRow(
                                                count: c.overallRating.round(),
                                                size: 20.r,
                                              ),
                                              SizedBox(height: 12.h),
                                              Text(
                                                '${c.totalReviews} reviews',
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: AppColors.backgroundAss1),
                                              ),
                                            ],
                                          ),

                                          SizedBox(width: 20.w),

                                          // ── Bar Chart ──
                                          Expanded(
                                            child: RatingBarChart(
                                              starCounts: c.starCounts,
                                              totalReviews: c.totalReviews,
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 12.h),

                                      // ── Positive % Box ──
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12.h, horizontal: 16.w),
                                        decoration: BoxDecoration(
                                          color: AppColors.cardColor,
                                          borderRadius: BorderRadius.circular(15.r),
                                          border: Border.all(color:AppColors.textBlack1),
                                        ),
                                        child: Column(
                                          children: [
                                            Image.asset('assets/images/trend_icon.png', width: 18.r, height: 18.r,color: AppColors.textBlack,),
                                            SizedBox(height: 4.h),
                                            Text(
                                              '${c.positivePercent}%',
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textBlack,
                                              ),
                                            ),
                                            Text(
                                              'Positive',
                                              style: TextStyle(
                                                  fontSize: 13.sp, color: AppColors.backgroundAss1),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 24.h),

                                // ── Customer Reviews Title ──
                                Text(
                                  'Customer Reviews',
                                  style: AppTextStyles.headingLarge.copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textBlack,
                                  ),
                                ),

                                SizedBox(height: 12.h),

                                // ── Review Cards ──
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: c.reviews.length,
                                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                                  itemBuilder: (context, index) {
                                    final review = c.reviews[index];
                                    return ReviewCard(
                                      name: review['name'],
                                      avatarUrl: review['avatar'],
                                      service: review['service'],
                                      date: review['date'],
                                      userRating: review['userRating'],
                                      onRatingChanged: (stars) =>
                                          c.updateReviewRating(index, stars),
                                    );
                                  },
                                ),

                                SizedBox(height: 24.h),
                              ],
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}