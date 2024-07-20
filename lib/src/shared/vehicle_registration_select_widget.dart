import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class VehicleRegistrationSelectWidget extends StatelessWidget {
  const VehicleRegistrationSelectWidget({
    Key? key,
    this.value,
    required this.hintText,
    required this.isLoading,
    required this.onTap,
    this.showIcon = true,
    this.hintTextEmptyStateColor,
    this.hintTextColor,
    this.border,
    this.borderRadius,
    this.icon,
  }) : super(key: key);

  final String? value;
  final String hintText;
  final bool isLoading;
  final VoidCallback onTap;
  final bool showIcon;
  final Color? hintTextEmptyStateColor;
  final Color? hintTextColor;
  final Border? border;
  final BorderRadius? borderRadius;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
        ),
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(border: border, borderRadius: borderRadius),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: isLoading
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            if (isLoading)
              SizedBox(
                height: 30.w,
                width: 30.w,
                child: CircularProgressIndicator(
                  color: AppColors.appSkyBlue,
                  strokeWidth: 2,
                ),
              )
            else ...[
              Text(
                (value != null && value!.isNotEmpty) ? value! : hintText,
                style: TextStyling.medium.copyWith(
                  fontSize: 13.sp,
                  color: (value != null && value!.isNotEmpty)
                      ? hintTextColor ?? AppColors.lightGrey
                      : hintTextEmptyStateColor ??
                          AppColors.grey.withOpacity(
                            0.5,
                          ),
                ),
              ),
              if (showIcon)
                icon ??
                    Container(
                      decoration: BoxDecoration(
                        gradient: AppColors.mainButtonGradient,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.white,
                        size: 20.sp,
                      ),
                    ),
            ],
          ],
        ),
      ),
    );
  }
}
