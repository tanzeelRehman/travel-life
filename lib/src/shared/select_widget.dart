import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class SelectWidget extends StatelessWidget {
  const SelectWidget({
    Key? key,
    required this.hintText,
    this.text,
    required this.onTap,
    this.icon,
    this.bgColor,
    this.hideIcon = false,
    required this.isLoading,
  }) : super(key: key);

  final String hintText;
  final String? text;
  final Widget? icon;
  final VoidCallback onTap;
  final bool isLoading;
  final Color? bgColor;
  final bool hideIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !isLoading ? onTap : null,
      child: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        height: 50.0.h,
        // width: 330.0.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          // color: bgColor ?? AppColors.textFieldBg,
          color: Colors.transparent,
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  height: 25.h,
                  width: 25.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.appSkyBlue.withOpacity(0.5),
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (text != null)
                    Expanded(
                      child: Text(
                        text!,
                        style: TextStyling.bold.copyWith(
                          color: AppColors.black,
                          fontSize: 15.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (text == null)
                    Expanded(
                      child: Text(
                        hintText,
                        style: TextStyling.regular.copyWith(
                          color: AppColors.grey,
                          fontSize: 15.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (!hideIcon)
                    if (icon != null) icon!,
                  if (!hideIcon)
                    if (icon == null)
                      Padding(
                        padding: EdgeInsets.only(bottom: 6.h),
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.grey,
                            size: 16.w,
                          ),
                        ),
                      ),
                ],
              ),
      ),
    );
  }
}
