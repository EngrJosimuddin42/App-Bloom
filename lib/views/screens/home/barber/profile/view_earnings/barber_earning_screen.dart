import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../controllers/barber_home_controller.dart';
import '../../../../../../themes/app_colors.dart';
import '../../../../../../themes/app_text_styles.dart';
import '../../../../../base/earning_history_item.dart';
import '../../../../../base/earnings_card.dart';
import '../../../../../base/payment_method_card.dart';
import '../../../../../base/segmented_tab_bar.dart';


class BarberEarningScreen extends StatefulWidget {
  const BarberEarningScreen({super.key});

  @override
  State<BarberEarningScreen> createState() => _BarberEarningScreenState();
}

class _BarberEarningScreenState extends State<BarberEarningScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = ['Week', 'Month', 'Year'];

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
            children: [
              Container(height: 10.h, color: AppColors.backgroundBlack1),
              Expanded(
                child: ColoredBox(
                  color: AppColors.background,
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
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                      ),

                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ── Earnings Card ──
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: EarningsCard(
                                  earnings: c.earningsSummary,
                                  earningsChange: c.earningsGrowth,
                                  earningsDate: c.earningsPeriodDate,
                                ),
                              ),
                              SizedBox(height: 24.h),

                              // Tabs section:
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: SegmentedTabBar(
                                  tabs: _tabs,
                                  selectedIndex: _selectedTab,
                                  onTabChanged: (i) => setState(() => _selectedTab = i),
                                ),
                              ),

                              SizedBox(height: 32.h),

                              // Payment Method section:
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: PaymentMethodCard(
                                  label: c.paymentMethodLabel,
                                  number: c.paymentMethodNumber,
                                ),
                              ),

                              SizedBox(height: 16.h),

                              // ── Earning History ──
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Text('Earning History',
                                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.textBlack)),
                              ),
                              SizedBox(height: 10.h),

                              // Earning History list:
                              ...c.earningHistory(_selectedTab).map((item) => Padding(
                                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 10.h),
                                child: EarningHistoryItem.fromMap(item),
                              )),

                              SizedBox(height: 24.h),
                            ],
                          )),
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