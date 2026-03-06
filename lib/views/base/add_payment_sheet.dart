import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../themes/app_colors.dart';
import '../screens/home/barber/profile/view_earnings/barber_add_bank_account_screen.dart';
import '../screens/home/barber/profile/view_earnings/barber_add_debit_card_screen.dart';

class AddPaymentSheet {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (_) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Payment Method',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600,
                    color: AppColors.textBlack),
              ),
              SizedBox(height: 6.h),
              Text(
                "Choose the type of payment method\nyou'd like to add",
                style: TextStyle(fontSize: 14.sp, color: AppColors.textBlack1),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Divider(height: 1, color: AppColors.textSecondary2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.to(() => const BarberAddDebitCardScreen(),
                          transition: Transition.rightToLeft);
                    },
                    child: Text(
                      'Debit Card',
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400,
                          color: AppColors.backgroundBlue),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  SizedBox(height: 30.h, child: VerticalDivider(width: 1, color: AppColors.textSecondary2)),
                  SizedBox(width: 16.w),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.to(() => const BarberAddBankAccountScreen(),
                          transition: Transition.rightToLeft);
                    },
                    child: Text(
                      'Bank Account',
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400,
                          color: AppColors.backgroundBlue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}