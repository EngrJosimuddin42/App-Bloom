import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../controllers/barber_home_controller.dart';
import '../../../../../../themes/app_colors.dart';
import '../../../../../../themes/app_text_styles.dart';
import '../../../../../base/add_payment_button.dart';
import '../../../../../base/payment_method_item.dart';
import 'barber_add_bank_account_screen.dart';
import 'barber_add_debit_card_screen.dart';

class BarberPaymentMethodScreen extends StatelessWidget {
  const BarberPaymentMethodScreen({super.key});

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
                        color:AppColors.background,
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child: Icon(Icons.arrow_back_ios_new,
                                      size: 18.r, color: AppColors.textBlack),
                                ),
                                SizedBox(width: 12.w),
                                Text('Payment Method',
                                    style: AppTextStyles.headingLarge.copyWith(
                                        color: AppColors.textBlack,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Padding(
                              padding: EdgeInsets.only(left: 5.w),
                              child: Text(
                                'Manage your payment methods for receiving earnings',
                                style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400,
                                    color: AppColors.textBlack4),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ── Payment Methods List ──
                      Expanded(
                        child: Obx(() {
                          final methods = c.paymentMethods;
                          if (methods.isEmpty) return const SizedBox();

                          final sorted = [...methods];
                          final primary = sorted.removeAt(c.primaryIndex);
                          sorted.insert(0, primary);

                          return SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              children: List.generate(sorted.length, (i) {
                                final isPrimary = sorted[i] == primary;
                                return PaymentMethodItem(
                                  method: sorted[i],
                                  isPrimary: isPrimary,
                                  onSetPrimary: () => c.setPrimaryMethod(
                                    methods.indexOf(sorted[i]),
                                  ),
                                  onEdit: () {
                                    final type = sorted[i]['type'];
                                    if (type == 'bank') {
                                      Get.to(() => const BarberAddBankAccountScreen(),
                                          transition: Transition.rightToLeft);
                                    } else {
                                      Get.to(() => const BarberAddDebitCardScreen(),
                                          transition: Transition.rightToLeft);
                                    }
                                  },
                                  onDelete: () => c.deletePaymentMethod(
                                    methods.indexOf(sorted[i]),
                                  ),
                                );
                              }),
                            ),
                          );
                        }),
                      ),

                      // ── Add New ──
                      const AddPaymentButton(),
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