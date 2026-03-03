import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../themes/app_colors.dart';
import '../../../../../../themes/app_text_styles.dart';
import 'barber_add_bank_account_screen.dart';
import 'barber_add_debit_card_screen.dart';

class BarberPaymentMethodScreen extends StatefulWidget {
  const BarberPaymentMethodScreen({super.key});

  @override
  State<BarberPaymentMethodScreen> createState() => _BarberPaymentMethodScreenState();
}

class _BarberPaymentMethodScreenState extends State<BarberPaymentMethodScreen> {
  int _primaryIndex = 0;

  final List<Map<String, dynamic>> _methods = [
    {'type': 'bank', 'title': 'Bank Account', 'subtitle': 'Brac Bank', 'last4': '4245'},
    {'type': 'card', 'title': 'Debit Card', 'subtitle': 'Visa', 'last4': null},
  ];

  void _showAddPaymentSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (_) => Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4.r))),
            SizedBox(height: 20.h),
            Text('Add Payment Method',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: AppColors.textBlack)),
            SizedBox(height: 6.h),
            Text("Choose the type of payment method\nyou'd like to add",
                style: TextStyle(fontSize: 12.sp, color: Colors.grey), textAlign: TextAlign.center),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.to(() => const BarberAddDebitCardScreen(), transition: Transition.rightToLeft);
                  },
                  child: Text('Debit Card',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.blue)),
                ),
                SizedBox(width: 32.w),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.to(() => const BarberAddBankAccountScreen(), transition: Transition.rightToLeft);
                  },
                  child: Text('Bank Account',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.blue)),
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            children: [
              Container(height: 10.h, color: AppColors.backgroundBlack1),
              Expanded(
                child: ColoredBox(
                  color: const Color(0xFFF5F5F5),
                  child: Column(
                    children: [
                      // ── Header ──
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child: Icon(Icons.arrow_back_ios_new, size: 18.r, color: AppColors.textBlack),
                                ),
                                SizedBox(width: 12.w),
                                Text('Payment Method',
                                    style: AppTextStyles.headingLarge.copyWith(
                                        color: AppColors.textBlack, fontSize: 18.sp, fontWeight: FontWeight.w700)),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Padding(
                              padding: EdgeInsets.only(left: 30.w),
                              child: Text('Manage your payment methods for receiving earnings',
                                  style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            children: [
                              ...List.generate(_methods.length, (i) {
                                final m = _methods[i];
                                return Container(
                                  margin: EdgeInsets.only(bottom: 12.h),
                                  padding: EdgeInsets.all(16.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8.r),
                                            decoration: BoxDecoration(
                                              color: m['type'] == 'bank' ? Colors.blue.shade50 : Colors.orange.shade50,
                                              borderRadius: BorderRadius.circular(8.r),
                                            ),
                                            child: Icon(
                                              m['type'] == 'bank' ? Icons.account_balance : Icons.credit_card,
                                              size: 18.r,
                                              color: m['type'] == 'bank' ? Colors.blue : Colors.orange,
                                            ),
                                          ),
                                          SizedBox(width: 12.w),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(m['title'],
                                                      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.textBlack)),
                                                  if (_primaryIndex == i) ...[
                                                    SizedBox(width: 8.w),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                                                      decoration: BoxDecoration(
                                                        color: Colors.green.shade100,
                                                        borderRadius: BorderRadius.circular(20.r),
                                                      ),
                                                      child: Text('Primary',
                                                          style: TextStyle(fontSize: 10.sp, color: Colors.green, fontWeight: FontWeight.w600)),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                              Text(m['subtitle'], style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
                                              if (m['last4'] != null)
                                                Text('**** **** **** ${m['last4']}',
                                                    style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
                                            ],
                                          ),
                                          const Spacer(),
                                          Container(
                                            width: 20.r,
                                            height: 20.r,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: _primaryIndex == i ? Colors.red : Colors.grey.shade300,
                                                width: 2,
                                              ),
                                            ),
                                            child: _primaryIndex == i
                                                ? Center(child: Container(width: 10.r, height: 10.r, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)))
                                                : null,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                      Row(
                                        children: [
                                          if (_primaryIndex != i)
                                            Expanded(
                                              child: OutlinedButton(
                                                onPressed: () => setState(() => _primaryIndex = i),
                                                style: OutlinedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                                  side: const BorderSide(color: Colors.black),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                                                ),
                                                child: Text('Set as Primary',
                                                    style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.w600)),
                                              ),
                                            )
                                          else
                                            Expanded(
                                              child: OutlinedButton(
                                                onPressed: () {},
                                                style: OutlinedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                                  side: BorderSide(color: Colors.grey.shade300),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                                                ),
                                                child: Text('Edit',
                                                    style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.w600)),
                                              ),
                                            ),
                                          SizedBox(width: 8.w),
                                          if (_primaryIndex == i)
                                            Expanded(
                                              child: OutlinedButton(
                                                onPressed: () {},
                                                style: OutlinedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                                  side: BorderSide(color: Colors.grey.shade300),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                                                ),
                                                child: Text('Edit',
                                                    style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.w600)),
                                              ),
                                            ),
                                          Container(
                                            width: 36.r,
                                            height: 36.r,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey.shade300),
                                              borderRadius: BorderRadius.circular(8.r),
                                            ),
                                            child: Icon(Icons.delete_outline, size: 18.r, color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),

                      // ── Add New ──
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(16.w),
                        child: GestureDetector(
                          onTap: _showAddPaymentSheet,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, size: 18.r, color: Colors.white),
                                SizedBox(width: 8.w),
                                Text('Add New Payment Method',
                                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white)),
                              ],
                            ),
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