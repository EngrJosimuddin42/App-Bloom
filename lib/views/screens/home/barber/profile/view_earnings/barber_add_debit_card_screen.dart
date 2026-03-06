import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../themes/app_colors.dart';
import '../../../../../../themes/app_text_styles.dart';
import '../../../../../base/custom_text_field.dart';

class BarberAddDebitCardScreen extends StatefulWidget {
  const BarberAddDebitCardScreen({super.key});

  @override
  State<BarberAddDebitCardScreen> createState() => _BarberAddDebitCardScreenState();
}

class _BarberAddDebitCardScreenState extends State<BarberAddDebitCardScreen> {
  final _cardNumberController = TextEditingController();
  final _expiryController     = TextEditingController();
  final _cvvController        = TextEditingController();
  final _billingZipController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _billingZipController.dispose();
    super.dispose();
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
                  color: AppColors.background,
                  child: Column(
                    children: [

                      // ── Header ──
                      Container(
                        color: AppColors.background,
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Icon(Icons.arrow_back_ios_new,
                                  size: 18.r, color: AppColors.textBlack),
                            ),
                            SizedBox(width: 12.w),
                            Text('Add Debit Card',
                                style: AppTextStyles.headingLarge.copyWith(
                                    color: AppColors.textBlack,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),

                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ── Card Number ──
                              CustomTextField(
                                label: 'Card Number',
                                labelFontSize: 14.sp,
                                labelColor: AppColors.textBlack,
                                borderColor: AppColors.textBlack4,
                                fillColor: AppColors.cardColor,
                                textColor: AppColors.textBlack1,
                                controller: _cardNumberController,
                                hint: '456453456345',
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 16.h),

                              // ── Expiry + CVV ──
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      label: 'Expiry Date',
                                      labelFontSize: 14.sp,
                                      labelColor: AppColors.textBlack,
                                      borderColor: AppColors.textBlack4,
                                      fillColor: AppColors.cardColor,
                                      textColor: AppColors.textBlack,
                                      controller: _expiryController,
                                      hint: 'MM/YY',
                                      keyboardType: TextInputType.datetime,
                                      suffixIcon: GestureDetector(
                                        onTap: () async {
                                          final picked = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2035),
                                          );
                                          if (picked != null) {
                                            _expiryController.text =
                                            '${picked.month.toString().padLeft(2, '0')}/${picked.year.toString().substring(2)}';
                                          }
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(12.r),
                                          child: Image.asset('assets/images/calendar.png', width: 16.r, height: 16.r),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: CustomTextField(
                                      label: 'CVV',
                                      labelFontSize: 14.sp,
                                      labelColor: AppColors.textBlack,
                                      borderColor: AppColors.textBlack4,
                                      fillColor: AppColors.cardColor,
                                      textColor: AppColors.textBlack,
                                      controller: _cvvController,
                                      hint: '123',
                                      keyboardType: TextInputType.number,
                                      obscureText: true,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),

                              // ── Billing ZIP ──
                              CustomTextField(
                                label: 'Billing ZIP Code',
                                labelFontSize: 14.sp,
                                labelColor: AppColors.textBlack,
                                borderColor: AppColors.textBlack4,
                                fillColor: AppColors.cardColor,
                                textColor: AppColors.textBlack1,
                                controller: _billingZipController,
                                hint: '000112541',
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 24.h),
                            ],
                          ),
                        ),
                      ),

                      // ── Submit ──
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(12.w),
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundBlack,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text('Add Debit Card',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textWhite)),
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