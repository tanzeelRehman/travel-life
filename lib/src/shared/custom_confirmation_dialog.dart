import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class CustomConfirmationDialog extends StatelessWidget {
  const CustomConfirmationDialog({
    Key? key,
    required this.onClickYes,
    required this.title,
    required this.description,
    this.yesText,
    this.noText,
  }) : super(key: key);

  final VoidCallback onClickYes;
  final String title;
  final String description;
  final String? yesText;
  final String? noText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.appDarkBlue,
      insetPadding: EdgeInsets.only(left: 10.0, right: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      title: Text(
        // (isVehicleEnabled ?? true) ? 'Disable Vehicle' : 'Enable Vehicle',
        title,
        textAlign: TextAlign.center,
        style: TextStyling.medium.copyWith(
          fontSize: 16.sp,
        ),
      ),
      content: Text(
        description,
        style: TextStyling.thin.copyWith(fontSize: 12.sp),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onClickYes,
              child: Container(
                height: 40.0.h,
                width: 70.0.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: AppColors.appSkyBlue,
                ),
                child: Center(
                  child: Text(
                    yesText ?? "Yes",
                    style: TextStyling.regular.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
            HorizontalSpacing(15.w),
            GestureDetector(
              onTap: () {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                height: 40.0.h,
                width: 70.0.w,
                decoration: BoxDecoration(
                  color: AppColors.appFaddedBlue,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: Text(
                    noText ?? "No",
                    style: TextStyling.regular.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        VerticalSpacing(10),
      ],
    );
  }
}
