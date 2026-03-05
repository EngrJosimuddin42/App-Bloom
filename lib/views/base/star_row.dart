import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StarRow extends StatelessWidget {
  final int count;
  final double? size;

  const StarRow({
    super.key,
    required this.count,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final double iconSize = size ?? 16.r;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        return Image.asset(
          i < count
              ? 'assets/images/star.png'
              : 'assets/images/star_icon.png',
          width: iconSize,
          height: iconSize,
        );
      }),
    );
  }
}