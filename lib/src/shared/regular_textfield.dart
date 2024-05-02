import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class RegularTextFeild extends StatelessWidget {
  const RegularTextFeild({
    Key? key,
    this.controller,
    this.onChanged,
    required this.hintText,
    this.isMultiLine = false,
    this.textInputType,
    this.readOnly,
    this.error,
    this.inputFormatters,
    this.fillColor,
    this.textStyle,
  }) : super(key: key);

  final String hintText;

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool isMultiLine;
  final TextInputType? textInputType;
  final bool? readOnly;
  final String? error;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      expands: isMultiLine,
      maxLines: isMultiLine ? null : 1,
      minLines: isMultiLine ? null : 1,
      textAlignVertical: TextAlignVertical.top,
      keyboardType: textInputType,
      readOnly: readOnly ?? false,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      style: textStyle ?? TextStyle(color: AppColors.white, fontSize: 16.sp),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyling.regular.copyWith(
          color: AppColors.grey,
          fontSize: 16.sp,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: (readOnly != null && readOnly!)
            ? null
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(
                  color: AppColors.appSkyBlue,
                ),
              ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.w,
        ),
        filled: true,
        fillColor: fillColor ?? AppColors.lightGrey.withOpacity(0.3),
      ),
    );
  }
}
