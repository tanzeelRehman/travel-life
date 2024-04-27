import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_app/src/shared/blur_container.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class VehicleRegistrationTextField extends StatelessWidget {
  const VehicleRegistrationTextField({
    Key? key,
    this.controller,
    this.multiline = false,
    required this.svgIconPath,
    this.hintText,
    required this.labelText,
    this.inputType,
    this.textInputFormatters,
    this.onchangeAction,
    this.readOnly = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool multiline;

  final String svgIconPath;
  final String? hintText;
  final String labelText;

  final TextInputType? inputType;
  final List<TextInputFormatter>? textInputFormatters;
  final Function(String)? onchangeAction;

  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              svgIconPath,
              height: 36.h,
            ),
            HorizontalSpacing(20.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    labelText,
                    style: TextStyling.regular.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                  VerticalSpacing(5.h),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: AppColors.vehicleRegTextFieldBoxShadows,
                    ),
                    padding: EdgeInsets.all(10),
                    height: multiline ? 100.h : null,
                    child: TextField(
                      onChanged: onchangeAction,
                      controller: controller,
                      keyboardType: inputType,
                      textInputAction: TextInputAction.next,
                      inputFormatters: textInputFormatters,
                      decoration: null,
                      expands: multiline,
                      maxLines: multiline ? null : 1,
                      readOnly: readOnly,
                      style: TextStyling.thin.copyWith(
                        fontSize: 13.sp,
                        color: AppColors.white.withOpacity(0.7),
                      ),
                      cursorColor: AppColors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
