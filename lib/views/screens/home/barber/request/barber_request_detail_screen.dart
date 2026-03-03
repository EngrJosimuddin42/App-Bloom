import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../controllers/barber_home_controller.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_text_styles.dart';
import '../../../../base/info_row_item.dart';

class BarberRequestDetailScreen extends StatelessWidget {
  final Map<String, dynamic> request;

  const BarberRequestDetailScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BarberHomeController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.backgroundBlack1,
          statusBarIconBrightness: Brightness.light,
        ),
        child:
        Scaffold(
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
          children: [
            // ── Header ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back_ios, size: 20.w, color: AppColors.textBlack),
                  ),
                  SizedBox(width: 8.w),
                  Text('New Booking Request',
                      style: AppTextStyles.headingLarge.copyWith(color: AppColors.textBlack)),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Customer Info ──
                    Row(
                      children: [
                        Container(
                          width: 56.w,
                          height: 56.w,
                          decoration: BoxDecoration(
                            color: AppColors.cardColor,
                            borderRadius: BorderRadius.circular(28.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28.r),
                            child: request['avatar'] != null
                                ? Image.network(
                              request['avatar'],
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Image.asset(
                                'assets/images/user.png',
                                width: 56.w,
                                height: 56.w,
                                fit: BoxFit.cover,
                              ),
                            )
                                : Image.asset(
                              'assets/images/profile.png',
                              width: 56.w,
                              height: 56.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(request['name'],
                                style: AppTextStyles.headingLarge.copyWith(color: AppColors.textBlack)),
                            Row(
                              children: [
                                Icon(Icons.star, size: 20.w, color: AppColors.textBlack),
                                SizedBox(width: 4.w),
                                Text('${request['rating']} Customer Rating',
                                    style: AppTextStyles.caption.copyWith(
                                        color: AppColors.textBlack,
                                      fontSize: 13.sp
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // ── Message Button ──
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.textBlack)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Message',
                              style: AppTextStyles.bodyPrimary.copyWith(
                                  color: AppColors.textBlack,
                                fontSize: 16.sp
                              )),
                          SizedBox(width: 8.w),
                          Image.asset(
                            'assets/images/bubble_chat.png',
                            width: 24.w,
                            height: 24.w,
                            color: AppColors.textBlack,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // ── Info Rows ──
                    InfoRowItem(
                      color: AppColors.border1,
                      assetIcon: 'assets/images/bx_cut.png',
                      label: 'Service',
                      value: request['service'],
                      note: 'Duration: ${request['duration']}',
                    ),
                    InfoRowItem(
                      color: AppColors.backgroundBlue,
                      assetIcon: 'assets/images/schedule.png',
                      label: 'Scheduled Time',
                      value: request['time'],
                      note: request['timeNote'],
                    ),
                    InfoRowItem(
                      color: AppColors.secondary,
                      assetIcon: 'assets/images/lucide_map-pin.png',
                      label: 'Location',
                      value: request['address'],
                      note: request['addressNote'],
                    ),
                    InfoRowItem(
                      color: AppColors.backgroundOrange,
                      assetIcon: 'assets/images/solar_map-arrow-square-outline.png',
                      label: 'Distance',
                      value: request['distance'],
                      note: request['distanceNote'],
                    ),
                    SizedBox(height: 8.h),

                    // ── Special Instructions ──
                    if (request['instructions'] != null && request['instructions'].isNotEmpty) ...[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: AppColors.cardColor,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.textBlack)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Special Instructions:',
                                style: AppTextStyles.bodyPrimary.copyWith(
                                    color: AppColors.textBlack,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 6.h),
                            Text(request['instructions'],
                                style: AppTextStyles.caption.copyWith(
                                    color: AppColors.border,
                                  fontSize: 13.sp
                                )),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],

                    // ── Earning Breakdown ──
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: AppColors.textBlack)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Earning Breakdown',
                              style: AppTextStyles.bodyPrimary.copyWith(
                                  color: AppColors.textBlack,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 12.h),
                          _earningRow('Service Fee', request['serviceFee'], isTotal: false),
                          SizedBox(height: 6.h),
                          _earningRow('Platform Fee (15%)', request['platformFee'], isTotal: false),
                          Divider(height: 20.h, color: AppColors.border),
                          _earningRow("You'll Earn", request['youEarn'], isTotal: true),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // ── Decline / Accept ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      // ── Decline ──
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.declineRequest(request);
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundRed,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: AppColors.borderRed)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.close, size: 20.w, color: AppColors.borderRed),
                                SizedBox(width: 6.w),
                                Text('Decline',
                                    style: AppTextStyles.bodyPrimary.copyWith(
                                        color: AppColors.borderRed, fontWeight: FontWeight.w600,fontSize: 16.sp)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      // ── Accept ──
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.acceptRequest(request);
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundGreen,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: AppColors.secondary)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check, size: 20.w, color:AppColors.secondary),
                                SizedBox(width: 6.w),
                                Text('Accept',
                                    style: AppTextStyles.bodyPrimary.copyWith(
                                        color: AppColors.secondary, fontWeight: FontWeight.w600,fontSize: 16.sp)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Accepting this booking commits you to provide the service',
                    style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
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

  Widget _earningRow(String label, String value, {required bool isTotal}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: isTotal
                ? AppTextStyles.bodyPrimary.copyWith(color: AppColors.textBlack, fontWeight: FontWeight.w600,fontSize: 14.sp)
                : AppTextStyles.caption.copyWith(color: AppColors.textBlack,fontSize: 14.sp,fontWeight: FontWeight.w400)),
        Text(value,
            style: isTotal
                ? AppTextStyles.headingLarge.copyWith(color: AppColors.textBlack,fontWeight: FontWeight.w600,fontSize: 20.sp)
                : AppTextStyles.caption.copyWith(color: AppColors.textBlack,fontWeight: FontWeight.w600,fontSize: 14.sp)),
      ],
    );
  }
}