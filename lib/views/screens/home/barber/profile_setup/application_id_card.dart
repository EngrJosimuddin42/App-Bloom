import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_text_styles.dart';
import '../../../../base/custom_button.dart';

class ApplicationIdCard extends StatefulWidget {
  final String applicationId;
  final VoidCallback onVerify;

  const ApplicationIdCard({
    super.key,
    required this.applicationId,
    required this.onVerify,
  });

  @override
  State<ApplicationIdCard> createState() => _ApplicationIdCardState();
}

class _ApplicationIdCardState extends State<ApplicationIdCard> {
  bool _isRevealed = false;

  String get _displayId => _isRevealed
      ? widget.applicationId
      : '─' * widget.applicationId.length;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Your Application ID',
            style: AppTextStyles.bodyPrimary.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 12.h),

          // ── ID Box ──
          GestureDetector(
            onTap: () => setState(() => _isRevealed = !_isRevealed),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.textBlack, width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      _displayId,
                      style: AppTextStyles.headingLarge.copyWith(
                        color: AppColors.textBlack,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Clipboard.setData(ClipboardData(text: widget.applicationId)),
                    child: Image.asset(
                      'assets/images/copy.png',
                      width: 18.w,
                      height: 18.w,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 8.h),
          Text(
            'Save this ID for tracking your application status',
            style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),

          CustomButton(
            label: 'Verify',
            isEnabled: true,
            onTap: widget.onVerify,
          ),
        ],
      ),
    );
  }
}