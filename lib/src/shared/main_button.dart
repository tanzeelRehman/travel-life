import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class MainButton extends StatelessWidget {
  final String buttonText;
  final Color buttonFontColor;
  final VoidCallback? onPressed;
  final bool fullWidth;
  final bool isLoading;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final double? fontSize;
  final Gradient? gradient;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;

  const MainButton({
    Key? key,
    required this.buttonText,
    this.buttonFontColor = Colors.white,
    required this.onPressed,
    this.fullWidth = true,
    required this.isLoading,
    this.height,
    this.width,
    this.padding,
    this.fontSize,
    this.gradient,
    this.borderRadius,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60.h,
      width: fullWidth ? double.infinity : width,
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.mainButtonGradient,
        borderRadius: borderRadius ?? BorderRadius.circular(10.r),
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(3),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          padding: MaterialStatePropertyAll(
            padding ?? EdgeInsets.symmetric(vertical: 10.h, horizontal: 24.w),
          ),
          visualDensity: VisualDensity.compact,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: isLoading
            ? Padding(
                padding: const EdgeInsets.all(4.0),
                child: Transform.scale(
                  scale: 0.6,
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                  ),
                ),
              )
            : child ??
                Text(
                  buttonText,
                  style: TextStyling.bold.copyWith(
                    fontSize: fontSize ?? 18.sp,
                  ),
                ),
      ),
    );
  }
}
