import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_text_styles.dart';

class BarberChangePasswordScreen extends StatefulWidget {
  const BarberChangePasswordScreen({super.key});

  @override
  State<BarberChangePasswordScreen> createState() =>
      _BarberChangePasswordScreenState();
}

class _BarberChangePasswordScreenState
    extends State<BarberChangePasswordScreen> {
  final _currentPwController = TextEditingController();
  final _newPwController = TextEditingController();
  final _confirmPwController = TextEditingController();

  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;

  @override
  void dispose() {
    _currentPwController.dispose();
    _newPwController.dispose();
    _confirmPwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // ── Header ──
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(Icons.arrow_back_ios_new,
                          size: 18.r, color: AppColors.textBlack),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Change Password',
                      style: AppTextStyles.headingLarge.copyWith(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textBlack,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h),
                      _PasswordField(
                        label: 'Current Password',
                        controller: _currentPwController,
                        obscure: !_showCurrent,
                        onToggle: () =>
                            setState(() => _showCurrent = !_showCurrent),
                      ),
                      SizedBox(height: 14.h),
                      _PasswordField(
                        label: 'New Password',
                        controller: _newPwController,
                        obscure: !_showNew,
                        onToggle: () => setState(() => _showNew = !_showNew),
                      ),
                      SizedBox(height: 14.h),
                      _PasswordField(
                        label: 'Confirm Password',
                        controller: _confirmPwController,
                        obscure: !_showConfirm,
                        onToggle: () =>
                            setState(() => _showConfirm = !_showConfirm),
                      ),

                      SizedBox(height: 40.h),

                      // ── Save Button ──
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: change password logic
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Save Changes',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
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

class _PasswordField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onToggle;

  const _PasswordField({
    required this.label,
    required this.controller,
    required this.obscure,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
        ),
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          obscureText: obscure,
          style: TextStyle(fontSize: 14.sp, color: const Color(0xFF1A1A1A)),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            prefixIcon: Icon(Icons.lock_outline, size: 18.r, color: Colors.grey),
            suffixIcon: GestureDetector(
              onTap: onToggle,
              child: Icon(
                obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 18.r,
                color: Colors.grey,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            contentPadding:
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          ),
        ),
      ],
    );
  }
}