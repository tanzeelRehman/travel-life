import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({
    Key? key,
    required this.title,
    required this.controller,
    this.readOnly = false,
    this.textInputType,
    this.onTap,
    this.suffixIcon,
  }) : super(key: key);

  final String title;
  final TextEditingController controller;
  final bool readOnly;
  final TextInputType? textInputType;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyling.medium.copyWith(
              color: AppColors.white.withOpacity(0.7),
              fontSize: 12.sp,
            ),
          ),
          TextField(
            keyboardType: textInputType,
            readOnly: readOnly,
            controller: controller,
            style: TextStyling.bold.copyWith(
              fontSize: 15.sp,
            ),
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: title,
              hintStyle: TextStyling.thin.copyWith(
                fontSize: 13.sp,
                // color: AppColors.darkGrey.withOpacity(1),
                color: Colors.white.withOpacity(.3),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 8.h,
                horizontal: 0,
              ),
              isDense: true,
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.appTextfieldBorderColor,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.appTextfieldBorderColor,
                ),
              ),
              focusedBorder: !readOnly
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.lightGrey,
                      ),
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.appTextfieldBorderColor,
                      ),
                    ),
            ),
            cursorColor: AppColors.appSkyBlue,
          ),
        ],
      ),
    );
  }
}
