import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../themes/app_colors.dart';
import '../../../../../../themes/app_text_styles.dart';


class BarberAddDebitCardScreen extends StatefulWidget {
  const BarberAddDebitCardScreen({super.key});

  @override
  State<BarberAddDebitCardScreen> createState() => _BarberAddDebitCardScreenState();
}

class _BarberAddDebitCardScreenState extends State<BarberAddDebitCardScreen> {
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _billingZipController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _billingZipController.dispose();
    super.dispose();
  }

  Widget _buildField({required String label, required TextEditingController controller, String? hint, TextInputType? keyboardType, bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.textBlack)),
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey.shade400),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Colors.grey.shade200)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Colors.grey.shade200)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Colors.black)),
          ),
        ),
      ],
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
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Icon(Icons.arrow_back_ios_new, size: 18.r, color: AppColors.textBlack),
                            ),
                            SizedBox(width: 12.w),
                            Text('Add Debit Card',
                                style: AppTextStyles.headingLarge.copyWith(
                                    color: AppColors.textBlack, fontSize: 18.sp, fontWeight: FontWeight.w700)),
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
                              SizedBox(height: 8.h),

                              // ── Card Number ──
                              _buildField(
                                label: 'Card Number',
                                controller: _cardNumberController,
                                hint: '456453456345',
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 16.h),

                              // ── Expiry + CVV ──
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Expiry Date',
                                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.textBlack)),
                                        SizedBox(height: 6.h),
                                        TextField(
                                          controller: _expiryController,
                                          keyboardType: TextInputType.datetime,
                                          decoration: InputDecoration(
                                            hintText: 'MM/YY',
                                            hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey.shade400),
                                            suffixIcon: Icon(Icons.calendar_today_outlined, size: 16.r, color: Colors.grey),
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Colors.grey.shade200)),
                                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Colors.grey.shade200)),
                                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Colors.black)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('CVV',
                                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.textBlack)),
                                        SizedBox(height: 6.h),
                                        TextField(
                                          controller: _cvvController,
                                          keyboardType: TextInputType.number,
                                          obscureText: true,
                                          maxLength: 3,
                                          decoration: InputDecoration(
                                            hintText: '123',
                                            hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey.shade400),
                                            counterText: '',
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Colors.grey.shade200)),
                                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Colors.grey.shade200)),
                                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Colors.black)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),

                              // ── Billing ZIP ──
                              _buildField(
                                label: 'Billing ZIP Code',
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
                        padding: EdgeInsets.all(16.w),
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text('Add Debit Card',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white)),
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