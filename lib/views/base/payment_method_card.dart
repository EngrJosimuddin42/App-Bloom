import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../themes/app_colors.dart';
import '../screens/home/barber/profile/view_earnings/barber_payment_method_screen.dart';

class PaymentMethodCard extends StatelessWidget {
  final String label;
  final String number;

  const PaymentMethodCard({
    super.key,
    required this.label,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack,
              ),
            ),
            GestureDetector(
              onTap: () => Get.to(
                    () => const BarberPaymentMethodScreen(),
                transition: Transition.rightToLeft,
              ),
              child: Text(
                'Change',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlack,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 20.h),

        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: AppColors.background1,
                borderRadius: BorderRadius.circular(44.r),
              ),
              child: Image.asset('assets/images/bank.png', width: 20.r, height: 20.r),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  number,
                  style: TextStyle(fontSize: 12.sp, color: AppColors.textBlack,  fontWeight: FontWeight.w400, ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}