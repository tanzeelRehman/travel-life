import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class MainOutlinedButton extends StatelessWidget {
  const MainOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.height,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String buttonText;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 55.h,
      child: OutlinedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(vertical: 10.h, horizontal: 24.w),
          ),
          side: MaterialStateProperty.all(
            BorderSide(
              color: AppColors.appSkyBlue,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyling.medium.copyWith(
            fontSize: 18.sp,
            // color: AppColors.appSkyBlue,
          ),
        ),
      ),
    );
  }
}
