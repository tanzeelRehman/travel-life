import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class HomeActionButton extends StatelessWidget {
  const HomeActionButton({
    Key? key,
    required this.buttonText,
    required this.buttonTextColor,
    required this.iconPath,
    required this.iconGradeint,
    required this.onTap,
    required this.bgPath,
  }) : super(key: key);

  final String buttonText;
  final Color buttonTextColor;
  final String iconPath;
  final String bgPath;
  final Gradient iconGradeint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.grey.withOpacity(0.1),
            width: 2,
          ),
          gradient: AppColors.homeButtonGradient,
          borderRadius: BorderRadius.circular(
            20.r,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 3,
              sigmaY: 3,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Opacity(
                  opacity: 0.8,
                  child: SvgPicture.asset(
                    bgPath,
                    alignment: Alignment.centerRight,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        buttonText,
                        style: TextStyling.bold.copyWith(
                          color: buttonTextColor,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 70.h,
                          width: 70.h,
                          padding: EdgeInsets.all(18.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow:
                                AppColors.homeScreenButtonIconsBoxShadows,
                            gradient: iconGradeint,
                          ),
                          child: SvgPicture.asset(
                            iconPath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
