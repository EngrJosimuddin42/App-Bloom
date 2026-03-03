import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_text_styles.dart';


class BarberEditProfileScreen extends StatefulWidget {
  const BarberEditProfileScreen({super.key});

  @override
  State<BarberEditProfileScreen> createState() =>
      _BarberEditProfileScreenState();
}

class _BarberEditProfileScreenState extends State<BarberEditProfileScreen> {
  final _nameController = TextEditingController(text: 'Akash Saha');
  final _emailController = TextEditingController(text: 'aksaha9@gmail.com');
  final _phoneController = TextEditingController(text: '+880 | 0179 299 85 87');
  final _idController = TextEditingController(text: '000 000 000');
  final _locationController =
  TextEditingController(text: 'Mohakhali, Dhaka, Bangladesh 1212');
  int _experience = 1;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _idController.dispose();
    _locationController.dispose();
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
                      'Edit Profile',
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
                      _ProfileField(
                        label: 'Name',
                        controller: _nameController,
                        prefixIcon: Icons.person_outline,
                      ),
                      SizedBox(height: 12.h),
                      _ProfileField(
                        label: 'Email',
                        controller: _emailController,
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 12.h),
                      _ProfileField(
                        label: 'Phone',
                        controller: _phoneController,
                        prefixIcon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 12.h),
                      _ProfileField(
                        label: 'ID Number',
                        controller: _idController,
                        prefixIcon: Icons.badge_outlined,
                      ),
                      SizedBox(height: 12.h),
                      _ProfileField(
                        label: 'Location',
                        controller: _locationController,
                        prefixIcon: Icons.location_on_outlined,
                        suffixIcon: Icons.my_location,
                      ),
                      SizedBox(height: 12.h),

                      // ── Year of Experience ──
                      Text(
                        'Year of Experience',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.work_outline,
                                size: 18.r, color: Colors.grey),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                _experience.toString().padLeft(2, '0'),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.textBlack,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_experience > 0) {
                                  setState(() => _experience--);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(6.r),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6.r),
                                  border: Border.all(
                                      color: const Color(0xFFE0E0E0)),
                                ),
                                child: Icon(Icons.remove,
                                    size: 14.r, color: Colors.grey),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            GestureDetector(
                              onTap: () => setState(() => _experience++),
                              child: Container(
                                padding: EdgeInsets.all(6.r),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6.r),
                                  border: Border.all(
                                      color: const Color(0xFFE0E0E0)),
                                ),
                                child: Icon(Icons.add,
                                    size: 14.r, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // ── Save Button ──
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: save logic
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

class _ProfileField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;

  const _ProfileField({
    required this.label,
    required this.controller,
    required this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
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
          keyboardType: keyboardType,
          style: TextStyle(fontSize: 14.sp, color: const Color(0xFF1A1A1A)),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            prefixIcon: Icon(prefixIcon, size: 18.r, color: Colors.grey),
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, size: 18.r, color: Colors.grey)
                : null,
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