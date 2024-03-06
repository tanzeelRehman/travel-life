import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.titleText,
    this.showNotification = true,
    this.showBackButton = true,
    this.showSettings = false,
    this.trailingWidget,
  }) : super(key: key);

  final bool showBackButton;
  final bool showNotification;
  final bool showSettings;

  final Widget? title;
  final String? titleText;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40.h, left: 27.w, right: 27.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // if (!showBackButton)
          //   SvgPicture.asset(
          //     AssetIcons.logo,
          //     height: 40.h,
          //   ),
          // // HorizontalSpacing(20.w),
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
                  // child: IconButton(
                  //   constraints: BoxConstraints(),
                  //   onPressed: () {
                  //     NavService.back();
                  //   },
                  //   padding: EdgeInsets.zero,
                  //   icon: Icon(Icons.arrow_back_ios),
                  // ),
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
                style: TextStyling.bold.copyWith(fontSize: 20.sp),
              ),
          Spacer(),
          Row(
            children: [
              if (showNotification)
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications),
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              if (showSettings)
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.settings),
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              if (trailingWidget != null) trailingWidget!
            ],
          ),
        ],
      ),
    );
  }
}
