import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../themes/app_colors.dart';
import '../../../../../../themes/app_text_styles.dart';
import '../../../../../base/account_type_toggle.dart';
import '../../../../../base/custom_text_field.dart';

class BarberAddBankAccountScreen extends StatefulWidget {
  const BarberAddBankAccountScreen({super.key});

  @override
  State<BarberAddBankAccountScreen> createState() => _BarberAddBankAccountScreenState();
}

class _BarberAddBankAccountScreenState extends State<BarberAddBankAccountScreen> {
  final _accountNumberController = TextEditingController();
  final _bankNameController      = TextEditingController();
  final _billingZipController    = TextEditingController();
  int _accountType = 0; // 0=Checking, 1=Savings

  @override
  void dispose() {
    _accountNumberController.dispose();
    _bankNameController.dispose();
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
                              child: Icon(Icons.arrow_back_ios_new, size: 18.r, color: AppColors.textBlack),
                            ),
                            SizedBox(width: 12.w),
                            Text('Add Bank Account',
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
                              // ── Account Number ──
                              CustomTextField(
                                label: 'Account Number',labelFontSize: 14.sp,labelColor: AppColors.textBlack,borderColor: AppColors.textBlack4,fillColor: AppColors.cardColor,
                                controller: _accountNumberController,
                                hint: '0001112541',
                                keyboardType: TextInputType.number,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(12.r),
                                  child: Image.asset('assets/images/id_card.png', width: 18.r, height: 18.r),
                                ),
                              ),
                              SizedBox(height: 16.h),

                              // ── Bank Name ──
                              CustomTextField(
                                label: 'Bank Name',labelFontSize: 14.sp,labelColor: AppColors.textBlack,borderColor: AppColors.textBlack4,fillColor: AppColors.cardColor,
                                controller: _bankNameController,
                                hint: 'Brac Bank',
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(12.r),
                                  child: Image.asset('assets/images/bank.png', width: 18.r, height: 18.r,color: AppColors.textBlack                                                                       ),
                                ),                              ),
                              SizedBox(height: 16.h),

                              // ── Account Type ──
                              AccountTypeToggle(
                                selectedIndex: _accountType,
                                onChanged: (i) => setState(() => _accountType = i),
                              ),
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
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text('Add Bank Account',
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