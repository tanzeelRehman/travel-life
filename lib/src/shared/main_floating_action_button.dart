import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/src/styles/app_colors.dart';

class MainFloatingActionButton extends StatelessWidget {
  const MainFloatingActionButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55.w,
        width: 55.w,
        decoration: BoxDecoration(
          gradient: AppColors.mainButtonGradient,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.add,
          size: 36.w,
          color: AppColors.white,
        ),
      ),
    );
  }
}
