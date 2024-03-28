import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_app/src/shared/blur_container.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class VehicleRegistrationField extends StatelessWidget {
  const VehicleRegistrationField({
    Key? key,
    required this.svgIconPath,
    required this.labelText,
    required this.child,
  }) : super(key: key);

  final String svgIconPath;
  final String labelText;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              svgIconPath,
              height: 40.h,
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
                      fontSize: 15.sp,
                    ),
                  ),
                  VerticalSpacing(5.h),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: AppColors.vehicleRegTextFieldBoxShadows,
                    ),
                    // padding: EdgeInsets.all(10),
                    // height: multiline ? 100.h : null,
                    child: child,
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
