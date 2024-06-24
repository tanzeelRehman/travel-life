import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/src/styles/app_colors.dart';

class MainFloatingActionButton extends StatelessWidget {
  const MainFloatingActionButton({
    Key? key,
    required this.onTap,
    this.heightAndWidth,
    this.icon,
    this.iconColor,
  }) : super(key: key);

  final VoidCallback onTap;
  final double? heightAndWidth;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: heightAndWidth ?? 55.w,
        width: heightAndWidth ?? 55.w,
        decoration: BoxDecoration(
          gradient: AppColors.mainButtonGradient,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon ?? Icons.add,
          size: 36.w,
          color: iconColor ?? AppColors.white,
        ),
      ),
    );
  }
}
