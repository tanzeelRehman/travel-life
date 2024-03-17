import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/src/styles/app_colors.dart';

class BlurContainer extends StatelessWidget {
  const BlurContainer({
    Key? key,
    this.height,
    required this.child,
    this.border,
    this.borderRadius,
    this.radius,
  }) : super(key: key);

  final double? height;
  final Widget child;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: border ??
            Border.all(
              color: AppColors.grey.withOpacity(0.1),
              width: 2,
            ),
        gradient: AppColors.homeButtonGradient,
        borderRadius: borderRadius ??
            BorderRadius.circular(
              radius ?? 20.r,
            ),
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 20.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 3,
            sigmaY: 3,
          ),
          child: child,
        ),
      ),
    );
  }
}
