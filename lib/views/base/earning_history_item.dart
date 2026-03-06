import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../themes/app_colors.dart';

class EarningHistoryItem extends StatelessWidget {
  final String name;
  final String service;
  final String time;
  final String amount;
  final String base;
  final String tip;

  const EarningHistoryItem({
    super.key,
    required this.name,
    required this.service,
    required this.time,
    required this.amount,
    required this.base,
    required this.tip,
  });

  factory EarningHistoryItem.fromMap(Map<String, dynamic> map) {
    return EarningHistoryItem(
      name:    map['name']    ?? '',
      service: map['service'] ?? '',
      time:    map['time']    ?? '',
      amount:  map['amount']  ?? '',
      base:    map['base']    ?? '',
      tip:     map['tip']     ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.textBlack)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500,
                          color: AppColors.textBlack)),
                  SizedBox(height: 8.h),
                  Text(service,
                      style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,
                          color: AppColors.textBlack4)),
                  SizedBox(height: 6.h),
                  Text(time,
                      style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,
                          color: AppColors.textBlack4)),
                ],
              ),
              Text(amount,
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600,
                      color:AppColors.secondary)),
            ],
          ),
          SizedBox(height: 10.h),
          Divider(height: 1, color: AppColors.textBlack),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Base: $base',
                  style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400, color:AppColors.textBlack)),
              Text(tip,
                  style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w600,
                      color: AppColors.textBlack)),
            ],
          ),
        ],
      ),
    );
  }
}