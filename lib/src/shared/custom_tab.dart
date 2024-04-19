import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({
    Key? key,
    required this.title,
    required this.onTap,
    required this.isSelected,
    this.height,
    this.width,
    this.fontSize,
    this.padding,
    this.count,
  }) : super(key: key);

  final String title;
  final VoidCallback? onTap;
  final bool isSelected;
  final double? height;
  final double? width;
  final double? fontSize;
  final int? count;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 45.h,
        width: width,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.appDarkBlue : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
        ),
        padding:
            padding ?? EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
        child: Center(
          child: count == null
              ? Text(
                  title,
                  style: TextStyling.semiBold.copyWith(
                    color: isSelected ? AppColors.white : AppColors.appDarkBlue,
                    fontSize: fontSize ?? 12.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                )
              : Badge(
                  backgroundColor:
                      isSelected ? AppColors.white : AppColors.appDarkBlue,
                  offset: Offset(16, -6),
                  label: Text(
                    count.toString(),
                    style: TextStyle(
                        color:
                            isSelected ? AppColors.appDarkBlue : Colors.white),
                  ),
                  child: Text(
                    title,
                    style: TextStyling.semiBold.copyWith(
                      color:
                          isSelected ? AppColors.white : AppColors.appDarkBlue,
                      fontSize: fontSize ?? 12.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
        ),
      ),
    );
  }
}
