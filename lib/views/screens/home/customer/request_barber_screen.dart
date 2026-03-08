import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';

class RequestBarberScreen extends StatelessWidget {
  const RequestBarberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundBlack1,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundBlack1,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Request barber',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Selected Services ──
                    _SectionHeader(
                      icon: Icons.content_cut,
                      title: 'Selected Services',
                    ),
                    SizedBox(height: 12.h),

                    _ServiceTile(
                      name: 'Haircut',
                      duration: '30 minutes',
                      price: 'R300',
                      isSelected: true,
                    ),
                    SizedBox(height: 8.h),
                    _ServiceTile(
                      name: 'Beard Trim',
                      duration: '20 minutes',
                      price: 'R200',
                    ),
                    SizedBox(height: 8.h),
                    _ServiceTile(
                      name: 'Shave',
                      duration: '25 minutes',
                      price: 'R250',
                    ),
                    SizedBox(height: 8.h),
                    _ServiceTile(
                      name: 'Hair & Bread',
                      duration: '45 minutes',
                      price: 'R450',
                    ),

                    SizedBox(height: 28.h),

                    // ── Payment Method ──
                    _SectionHeader(
                      icon: Icons.content_cut,
                      title: 'Payment method',
                    ),
                    SizedBox(height: 12.h),

                    _PaymentTile(),
                  ],
                ),
              ),
            ),

            // ── Bottom Buttons ──
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
              decoration: const BoxDecoration(
                color: AppColors.background,
              ),
              child: Row(
                children: [
                  // Cancel
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                      ),
                      child: Text(
                        'Cancel',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Confirm
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: confirm booking
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.textBlack,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        elevation: 0,
                      ),
                      child: Text(
                        'Confirm',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Section Header ──
class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: AppColors.textBlack),
        SizedBox(width: 8.w),
        Text(
          title,
          style: AppTextStyles.sectionTitle.copyWith(
            color: AppColors.textBlack,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ── Service Tile ──
class _ServiceTile extends StatelessWidget {
  final String name;
  final String duration;
  final String price;
  final bool isSelected;

  const _ServiceTile({
    required this.name,
    required this.duration,
    required this.price,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.textBlack : AppColors.background,
        borderRadius: BorderRadius.circular(10.r),
        border: isSelected
            ? null
            : Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isSelected ? Colors.white : AppColors.textBlack,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                duration,
                style: AppTextStyles.caption.copyWith(
                  color: isSelected ? Colors.white70 : AppColors.textBlack2,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          Text(
            price,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isSelected ? Colors.white : AppColors.textBlack,
              fontWeight: FontWeight.w700,
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Payment Tile ──
class _PaymentTile extends StatelessWidget {
  const _PaymentTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.account_balance_wallet_outlined,
              size: 20.sp,
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wallet Balance',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Available: R0.00',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textBlack2,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}