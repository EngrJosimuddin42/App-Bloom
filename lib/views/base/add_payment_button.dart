import 'package:app_bloom/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'add_payment_sheet.dart';

class AddPaymentButton extends StatelessWidget {
  const AddPaymentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: GestureDetector(
        onTap: () => AddPaymentSheet.show(context),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 24.r, color:AppColors.textWhite),
              SizedBox(width: 8.w),
              Text(
                'Add New Payment Method',
                style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,
                    color: AppColors.textWhite),
              ),
            ],
          ),
        ),
      ),
    );
  }
}