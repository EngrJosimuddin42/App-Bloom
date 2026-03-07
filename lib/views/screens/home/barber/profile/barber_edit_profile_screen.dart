import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../controllers/barber/barber_home_controller.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_text_styles.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_text_field.dart';
import '../../../../base/counter_field.dart';

class BarberEditProfileScreen extends StatefulWidget {
  const BarberEditProfileScreen({super.key});

  @override
  State<BarberEditProfileScreen> createState() =>
      _BarberEditProfileScreenState();
}

class _BarberEditProfileScreenState extends State<BarberEditProfileScreen> {
  late final BarberHomeController _c;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _idController;
  late final TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _c = Get.find<BarberHomeController>();
    _nameController     = TextEditingController(text: _c.editName);
    _emailController    = TextEditingController(text: _c.editEmail);
    _phoneController    = TextEditingController(text: _c.editPhone);
    _idController       = TextEditingController(text: _c.editIdNumber);
    _locationController = TextEditingController(text: _c.editLocation);
  }

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
        statusBarColor: AppColors.backgroundBlack1,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundBlack1,
        body: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Status bar extended area ──
              Container(height: 10.h, color: AppColors.backgroundBlack1),

              // ── Main Content ──
              Expanded(
                child: ColoredBox(
                  color: AppColors.background,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // ── Header ──
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Icon(Icons.arrow_back_ios_new,
                                  size: 18.r, color: AppColors.textBlack),
                            ),
                            SizedBox(width: 12.w),
                            Text('Edit Profile',
                                style: AppTextStyles.headingLarge.copyWith(
                                  color: AppColors.textBlack,
                                  fontWeight: FontWeight.w500
                                )),
                          ],
                        ),
                      ),

                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // ── Name ──
                              CustomTextField(
                                controller: _nameController,
                                hint: 'Josimuddin',
                                label: 'Name',
                                labelColor: AppColors.textSecondary2,
                                textColor: AppColors.textBlack1,
                                fillColor: AppColors.cardColor,
                                borderColor: AppColors.cardColor,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child: Image.asset(
                                    'assets/images/user.png',
                                    width: 24.w, height: 24.w,
                                    color: AppColors.textBlack,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),

                              // ── Email ──
                              CustomTextField(
                                controller: _emailController,
                                hint: 'josimcse@gmail.com',
                                label: 'Email',
                                labelColor: AppColors.textSecondary2,
                                textColor: AppColors.textBlack1,
                                fillColor: AppColors.cardColor,
                                borderColor: AppColors.cardColor,
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child: Image.asset(
                                    'assets/images/email_icon.png',
                                    width: 24.w, height: 24.w,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),

                              // ── Phone ──
                              CustomTextField(
                                controller: _phoneController,
                                hint: '+880 | 0173 866 43 82',
                                label: 'Phone',
                                labelColor: AppColors.textSecondary2,
                                textColor: AppColors.textBlack1,
                                fillColor: AppColors.cardColor,
                                borderColor: AppColors.cardColor,
                                keyboardType: TextInputType.phone,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child: Image.asset(
                                    'assets/images/phone.png',
                                    width: 24.w, height: 24.w,
                                    color: AppColors.textBlack,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),

                              // ── ID Number ──
                              CustomTextField(
                                controller: _idController,
                                hint: '000 000 000',
                                label: 'ID Number',
                                labelColor: AppColors.textSecondary2,
                                textColor: AppColors.textBlack1,
                                fillColor: AppColors.cardColor,
                                borderColor: AppColors.cardColor,
                                keyboardType: TextInputType.number,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child: Image.asset(
                                    'assets/images/id_card.png',
                                    width: 24.w, height: 24.w,
                                    color: AppColors.textBlack,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),

                              // ── Location ──
                              CustomTextField(
                                controller: _locationController,
                                hint: 'Mohakhali, Dhaka, Bangladesh 1212',
                                label: 'Location',
                                labelColor: AppColors.textSecondary2,
                                textColor: AppColors.textBlack1,
                                fillColor: AppColors.cardColor,
                                borderColor: AppColors.cardColor,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child: Image.asset(
                                    'assets/images/location1.png',
                                    width: 24.w, height: 24.w,
                                    color: AppColors.textBlack,
                                  ),
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child: Image.asset(
                                    'assets/images/gps-off.png',
                                    width: 24.w, height: 24.w,
                                    color: AppColors.textBlack,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),

                              // ── Year of Experience ──
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Text('Year of Experience',
                                    style: AppTextStyles.inputLabel.copyWith(
                                        color: AppColors.textSecondary2)),
                              ),
                              Obx(() => CounterField(
                                value: _c.editExperience,
                                onIncrease: _c.incrementExperience,
                                onDecrease: _c.decrementExperience,
                              )),

                              SizedBox(height: 130.h),

                              // ── Save Button ──
                              CustomButton(
                                label: 'Save Changes',
                                onTap: () => _c.saveProfile(
                                  name:     _nameController.text,
                                  email:    _emailController.text,
                                  phone:    _phoneController.text,
                                  idNumber: _idController.text,
                                  location: _locationController.text,
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
            ],
          ),
        ),
      ),
    );
  }
}