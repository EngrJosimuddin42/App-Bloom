import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../themes/app_colors.dart';
import 'custom_text_field.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final Color? fillColor;
  final Color? borderColor;
  final Color? labelColor;
  final double? labelFontSize;

  const PasswordField({
    super.key,
    required this.controller,
    this.label = 'Password',
    this.hint = '* * * * * * * *',
    this.errorText,
    this.fillColor,
    this.borderColor,
    this.labelColor,
    this.labelFontSize,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      hint: widget.hint ?? '* * * * * * * *',
      label: widget.label,
      fillColor: widget.fillColor ?? AppColors.cardColor,
      borderColor: widget.borderColor ?? AppColors.textBlack4,
      obscureText: _obscure,
      errorText: widget.errorText,
      labelColor: widget.labelColor,
      labelFontSize: widget.labelFontSize,
      prefixIcon: Padding(
        padding: EdgeInsets.all(12.w),
        child: Image.asset(
          'assets/images/key.png',
          width: 24.w, height: 24.w,
          color: AppColors.textBlack3,
        ),
      ),
      suffixIcon: GestureDetector(
        onTap: () => setState(() => _obscure = !_obscure),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Image.asset(
            _obscure
                ? 'assets/images/view-of.png'
                : 'assets/images/view-on.png',
            width: 20.w, height: 20.w,
            color: AppColors.textBlack3,
          ),
        ),
      ),
    );
  }
}