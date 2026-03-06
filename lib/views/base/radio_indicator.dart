import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioIndicator extends StatelessWidget {
  final bool isSelected;
  final Color selectedColor;

  const RadioIndicator({
    super.key,
    required this.isSelected,
    this.selectedColor = Colors.red,
  });

  @override
  @override
  Widget build(BuildContext context) {
    if (!isSelected) return SizedBox(width: 24.r, height: 24.r);

    return Container(
      width: 24.r,
      height: 24.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: selectedColor, width: 2),
      ),
      child: Center(
        child: Container(
          width: 13.r,
          height: 13.r,
          decoration: BoxDecoration(
              color: selectedColor, shape: BoxShape.circle),
        ),
      ),
    );
  }
}