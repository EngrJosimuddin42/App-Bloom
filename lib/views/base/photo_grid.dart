import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';

class PhotoGrid extends StatelessWidget {
  final List<String> photos;
  final VoidCallback onAddMore;
  final String buttonLabel;

  const PhotoGrid({
    super.key,
    required this.photos,
    required this.onAddMore,
    this.buttonLabel = 'Add More',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Image.asset(
            photos.first,
            width: double.infinity,
            height: 160.h,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onAddMore,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColors.border),
            ),
            child: Center(
              child: Text(
                buttonLabel,
                style: AppTextStyles.bodyPrimary.copyWith(
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}