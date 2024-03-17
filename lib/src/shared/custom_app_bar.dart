import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.titleText,
    this.showBackButton = true,
    this.trailingWidget,
    this.padding,
    this.titleTextStyle,
  }) : super(key: key);

  final bool showBackButton;

  final Widget? title;
  final String? titleText;
  final Widget? trailingWidget;
  final EdgeInsets? padding;
  final TextStyle? titleTextStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(top: 50.h, left: 27.w, right: 27.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showBackButton)
            GestureDetector(
              onTap: () {
                NavService.back();
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.mainButtonGradient,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                height: 25.w,
                width: 25.w,
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 20.sp,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          Spacer(),
          title ??
              Text(
                titleText ?? '',
                style: titleTextStyle ??
                    TextStyling.semiBold.copyWith(fontSize: 17.sp),
              ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [if (trailingWidget != null) trailingWidget!],
          ),
        ],
      ),
    );
  }
}
