import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    Key? key,
    required this.text,
    this.color,
    this.icon,
  }) : super(key: key);
  final String text;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 27.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.do_disturb_alt_sharp,
              color: color ?? AppColors.white,
              size: 30.sp,
            ),
            VerticalSpacing(10.h),
            Text(
              text,
              style: TextStyling.bold.copyWith(
                fontSize: 14.sp,
                color: color ?? AppColors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
