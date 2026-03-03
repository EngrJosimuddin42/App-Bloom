import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../themes/app_colors.dart';
import '../../../../../../themes/app_text_styles.dart';
import 'barber_payment_method_screen.dart';

class BarberEarningScreen extends StatefulWidget {
  const BarberEarningScreen({super.key});

  @override
  State<BarberEarningScreen> createState() => _BarberEarningScreenState();
}

class _BarberEarningScreenState extends State<BarberEarningScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = ['Week', 'Month', 'Year'];

  final List<Map<String, dynamic>> _history = [
    {'name': 'David Chen', 'service': "Men's Haircut", 'time': 'Today 2:30 PM', 'amount': '\$34.75', 'base': '\$29.75', 'tip': '+\$5.00 tip'},
    {'name': 'David Chen', 'service': "Men's Haircut", 'time': 'Today 2:30 PM', 'amount': '\$34.75', 'base': '\$29.75', 'tip': '+\$5.00 tip'},
    {'name': 'David Chen', 'service': "Men's Haircut", 'time': 'Today 2:30 PM', 'amount': '\$34.75', 'base': '\$29.75', 'tip': '+\$5.00 tip'},
  ];

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
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Icon(Icons.arrow_back_ios_new, size: 18.r, color: AppColors.textBlack),
                            ),
                            SizedBox(width: 12.w),
                            Text('Earning',
                                style: AppTextStyles.headingLarge.copyWith(
                                  color: AppColors.textBlack,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                )),
                          ],
                        ),
                      ),

                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16.h),

                              // ── Earnings Card ──
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(20.w),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF6C3FE8), Color(0xFF9B6BFF)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("This Week's Earnings",
                                              style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12.sp)),
                                          Icon(Icons.content_cut,
                                              color: Colors.white.withOpacity(0.6), size: 20.r),
                                        ],
                                      ),
                                      SizedBox(height: 8.h),
                                      Text('\$867.50',
                                          style: TextStyle(color: Colors.white, fontSize: 28.sp, fontWeight: FontWeight.w800)),
                                      SizedBox(height: 12.h),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [
                                            Icon(Icons.trending_up, color: Colors.greenAccent, size: 14.r),
                                            SizedBox(width: 4.w),
                                            Text('+18% from last week',
                                                style: TextStyle(color: Colors.greenAccent, fontSize: 11.sp)),
                                          ]),
                                          Text('09/25',
                                              style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11.sp)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 16.h),

                              // ── Tabs ──
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Container(
                                  padding: EdgeInsets.all(4.r),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Row(
                                    children: List.generate(_tabs.length, (i) => Expanded(
                                      child: GestureDetector(
                                        onTap: () => setState(() => _selectedTab = i),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 8.h),
                                          decoration: BoxDecoration(
                                            color: _selectedTab == i ? Colors.black : Colors.transparent,
                                            borderRadius: BorderRadius.circular(8.r),
                                          ),
                                          child: Text(_tabs[i],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600,
                                                color: _selectedTab == i ? Colors.white : Colors.grey,
                                              )),
                                        ),
                                      ),
                                    )),
                                  ),
                                ),
                              ),

                              SizedBox(height: 16.h),

                              // ── Payment Method ──
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8.r),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade50,
                                          borderRadius: BorderRadius.circular(8.r),
                                        ),
                                        child: Icon(Icons.account_balance, size: 18.r, color: Colors.blue),
                                      ),
                                      SizedBox(width: 12.w),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Payment Method', style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
                                          Text('Bank Account',
                                              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.textBlack)),
                                          Text('**** **** **** 4242', style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
                                        ],
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () => Get.to(() => const BarberPaymentMethodScreen(), transition: Transition.rightToLeft),
                                        child: Text('Change',
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textBlack,
                                              decoration: TextDecoration.underline,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 16.h),

                              // ── Earning History ──
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Text('Earning History',
                                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700, color: AppColors.textBlack)),
                              ),
                              SizedBox(height: 10.h),

                              ..._history.map((item) => Padding(
                                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 10.h),
                                child: Container(
                                  padding: EdgeInsets.all(14.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(item['name'],
                                                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.textBlack)),
                                              Text(item['service'], style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
                                              Text(item['time'], style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
                                            ],
                                          ),
                                          Text(item['amount'],
                                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.green)),
                                        ],
                                      ),
                                      SizedBox(height: 8.h),
                                      Divider(height: 1, color: Colors.grey.shade200),
                                      SizedBox(height: 8.h),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Base: ${item['base']}', style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
                                          Text(item['tip'],
                                              style: TextStyle(fontSize: 11.sp, color: Colors.green, fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                              SizedBox(height: 24.h),
                            ],
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