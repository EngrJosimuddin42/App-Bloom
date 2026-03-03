import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../themes/app_colors.dart';
import '../../../../../../themes/app_text_styles.dart';

class BarberAddBankAccountScreen extends StatefulWidget {
  const BarberAddBankAccountScreen({super.key});

  @override
  State<BarberAddBankAccountScreen> createState() => _BarberAddBankAccountScreenState();
}

class _BarberAddBankAccountScreenState extends State<BarberAddBankAccountScreen> {
  final _accountNumberController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _billingZipController = TextEditingController();
  int _accountType = 0; // 0=Checking, 1=Savings

  @override
  void dispose() {
    _accountNumberController.dispose();
    _bankNameController.dispose();
    _billingZipController.dispose();
    super.dispose();
  }

  Widget _buildField({required String label, required TextEditingController controller, required IconData icon, TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.textBlack)),
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 18.r, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Colors.grey.shade200)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Colors.grey.shade200)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Colors.black)),
          ),
        ),
        SizedBox(height: 16.h),
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
                            Text('Add Bank Account',
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

                              _buildField(
                                label: 'Account Number',
                                controller: _accountNumberController,
                                icon: Icons.account_balance_outlined,
                                keyboardType: TextInputType.number,
                              ),

                              _buildField(
                                label: 'Bank Name',
                                controller: _bankNameController,
                                icon: Icons.account_balance,
                              ),

                              // ── Account Type ──
                              Text('Account Type',
                                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.textBlack)),
                              SizedBox(height: 6.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => setState(() => _accountType = 0),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 12.h),
                                        decoration: BoxDecoration(
                                          color: _accountType == 0 ? Colors.black : Colors.white,
                                          borderRadius: BorderRadius.circular(8.r),
                                          border: Border.all(color: _accountType == 0 ? Colors.black : Colors.grey.shade200),
                                        ),
                                        child: Text('Checking',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                              color: _accountType == 0 ? Colors.white : Colors.black,
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => setState(() => _accountType = 1),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 12.h),
                                        decoration: BoxDecoration(
                                          color: _accountType == 1 ? Colors.black : Colors.white,
                                          borderRadius: BorderRadius.circular(8.r),
                                          border: Border.all(color: _accountType == 1 ? Colors.black : Colors.grey.shade200),
                                        ),
                                        child: Text('Savings',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                              color: _accountType == 1 ? Colors.white : Colors.black,
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),

                              _buildField(
                                label: 'Billing ZIP Code',
                                controller: _billingZipController,
                                icon: Icons.location_on_outlined,
                                keyboardType: TextInputType.number,
                              ),
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
                            child: Text('Add Bank Account',
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