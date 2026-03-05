import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../controllers/barber_required_info_controller.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_text_styles.dart';
import '../../../../base/counter_field.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_text_field.dart';
import '../../../../base/disabled_feature_card.dart';
import '../../../../base/photo_grid.dart';
import '../../../../base/upload_box.dart';

class BarberRequiredInfoScreen extends StatelessWidget {
  const BarberRequiredInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BarberRequiredInfoController());

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
                  Container(
                  height: 10.h,
                  color: AppColors.backgroundBlack1,
                ),

                // ── Main Content ──
                Expanded(
                  child: ColoredBox(
                    color: AppColors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Text('Required Info',
                  style: AppTextStyles.headingLarge.copyWith(
                      color: AppColors.textBlack
                  )),
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
                      controller: controller.nameController,
                      hint: 'your@name',
                      label: 'Name',
                      fillColor: AppColors.cardColor,
                      borderColor: AppColors.cardColor,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Image.asset('assets/images/user.png',
                          width: 24.w, height: 24.w, color: AppColors.textBlack,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // ── Email ──
                    CustomTextField(
                      controller: controller.emailController,
                      hint: 'your@email.com',
                      label: 'Email',
                      fillColor: AppColors.cardColor,
                      borderColor: AppColors.cardColor,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Image.asset('assets/images/email_icon.png',
                          width: 24.w, height: 24.w,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // ── Phone ──
                    CustomTextField(
                      controller: controller.phoneController,
                      hint: 'your@phone number',
                      label: 'Phone',
                      keyboardType: TextInputType.phone,
                      fillColor: AppColors.cardColor,
                      borderColor: AppColors.cardColor,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Image.asset('assets/images/phone.png',
                          width: 24.w, height: 24.w, color: AppColors.textBlack,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // ── ID Number ──
                    CustomTextField(
                      controller: controller.idController,
                      hint: 'your@id number',
                      label: 'ID Number',
                      fillColor: AppColors.cardColor,
                      borderColor: AppColors.cardColor,
                      keyboardType: TextInputType.number,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Image.asset('assets/images/id_card.png',
                          width: 24.w, height: 24.w, color: AppColors.textBlack,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // ── Location ──
                    CustomTextField(
                      controller: controller.locationController,
                      hint: 'your@address',
                      label: 'Location',
                      fillColor: AppColors.cardColor,
                      borderColor: AppColors.cardColor,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Image.asset('assets/images/location1.png',
                          width: 24.w, height: 24.w, color: AppColors.textBlack,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Image.asset('assets/images/gps-off.png',
                          width: 24.w, height: 24.w, color: AppColors.textBlack,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // ── Year of Experience ──
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Text('Year of Experience',
                          style: AppTextStyles.inputLabel.copyWith(
                              color: AppColors.textBlack)),
                    ),
                    Obx(() => CounterField(
                      value: controller.experience,
                      onIncrease: controller.increaseExperience,
                      onDecrease: controller.decreaseExperience,
                    )),
                    SizedBox(height: 16.h),

                    // ── Photos & Videos ──
                    _fieldLabel('Photos & Videos of Works'),
                    Obx(() => controller.workPhotos.isEmpty
                        ? UploadBox(
                      icon: 'assets/images/ci_camera.png',
                      title: 'Tap to upload',
                      subtitle: 'Photos or videos of your best work',
                      onTap: controller.pickWorkPhotos,
                      fallbackIcon: Icons.camera_alt_outlined,
                    )
                        : PhotoGrid(
                      photos: controller.workPhotos,
                      onAddMore: controller.pickWorkPhotos,
                      buttonLabel: 'Add More Photo/Video',
                    )),
                    SizedBox(height: 16.h),

                    // ── Certificate Upload ──
                    _fieldLabel('Certificate Upload (Optional)'),
                    Obx(() => controller.certificates.isEmpty
                        ? UploadBox(
                      icon: 'assets/images/docs-outline.png',
                      title: 'Tap to upload',
                      subtitle: 'Professional certificates or licenses',
                      onTap: controller.pickCertificates,
                      fallbackIcon: Icons.upload_file_outlined,
                    )
                        : PhotoGrid(
                      photos: controller.certificates,
                      onAddMore: controller.pickCertificates,
                      buttonLabel: 'Add More Documents',
                    )),
                    SizedBox(height: 16.h),

                    // ── Disabled Section ──
                    DisabledFeatureCard(
                      features: const ['Accept Jobs', 'Go Online'],
                    ),
                    SizedBox(height: 24.h),

                    // ── Submit ──
                    CustomButton(
                      label: 'Submit Application',
                      isEnabled: true,
                      onTap: controller.submitApplication,
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

  Widget _fieldLabel(String label) => Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: Text(
      label,
      style: AppTextStyles.inputLabel.copyWith(color: AppColors.textBlack),
    ),
  );

}