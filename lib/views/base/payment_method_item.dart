import 'package:app_bloom/views/base/radio_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../themes/app_colors.dart';

class PaymentMethodItem extends StatelessWidget {
  final Map<String, dynamic> method;
  final bool isPrimary;
  final VoidCallback onSetPrimary;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PaymentMethodItem({
    super.key,
    required this.method,
    required this.isPrimary,
    required this.onSetPrimary,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isBank = method['type'] == 'bank';

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ── Icon + Info ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: isBank ? AppColors.backgroundGreen1 : AppColors.backgroundOrange1,
                  borderRadius: BorderRadius.circular(44.r),
                ),
                child: Image.asset(
                  isBank ? 'assets/images/bank.png' : 'assets/images/debit_card.png',
                  width: 40.r,
                  height: 40.r,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ── Title + Primary badge + Radio ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              method['title'],
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textBlack),
                            ),
                            if (isPrimary) ...[
                              SizedBox(width: 8.w),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                                decoration: BoxDecoration(
                                  color: AppColors.purple,
                                  borderRadius: BorderRadius.circular(40.r),
                                ),
                                child: Text(
                                  'Primary',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.textBlack5,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ],
                        ),
                        RadioIndicator(isSelected: isPrimary),
                      ],
                    ),

                    SizedBox(height: 4.h),
                    Text(
                      method['subtitle'],
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textBlack),
                    ),
                    if (method['last4'] != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        '**** **** **** ${method['last4']}',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textBlack),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // ── Buttons ──
          Row(
            children: [
              if (!isPrimary)
                Expanded(
                  child: OutlinedButton(
                    onPressed: onSetPrimary,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      side: BorderSide(color: AppColors.border6),
                      backgroundColor: AppColors.backgroundBlack,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                    child: Text('Set as Primary',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textWhite,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
              if (!isPrimary) SizedBox(width: 8.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: onEdit,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    side: BorderSide(color: AppColors.border6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                  child: Text('Edit',
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: onDelete,
                child: Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border6),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Image.asset(
                    'assets/images/delete.png',
                    height: 12,
                    width: 12,
                    color: AppColors.borderRed,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}