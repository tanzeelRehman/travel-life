import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_app/src/base/enums/vehicle_status.dart';
import 'package:starter_app/src/models/ui_models/vehicle_status_button_model.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/vehicle_registration/vehicle_detail/vehicle_detail_view_model.dart';

class VehicleStatusDialog extends StatefulWidget {
  final String title;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  final VehicleDetailViewModel model;

  VehicleStatusDialog(
      {required this.title,
      required this.onCancel,
      required this.onConfirm,
      required this.model});

  @override
  State<VehicleStatusDialog> createState() => _VehicleStatusDialogState();
}

class _VehicleStatusDialogState extends State<VehicleStatusDialog> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background blur effect
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            decoration: BoxDecoration(
                // gradient: AppColors.homeButtonGradient,
                // color: Colors.black.withOpacity(0.5),
                ),
            constraints: BoxConstraints.expand(),
          ),
        ),
        // Dialog content
        AlertDialog(
          backgroundColor: AppColors.grey.withOpacity(0.7),
          title: Text(widget.title),
          titleTextStyle: TextStyling.bold.copyWith(fontSize: 18.sp),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: vehicleStatusButtons.map((e) {
              return GestureDetector(
                onTap: () {
                  widget.model.toggleStatus(e.status);
                  setState(() {});
                },
                child: Container(
                  height: 100,
                  // width: 90.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                    vertical: 15.w,
                  ),

                  decoration: BoxDecoration(
                    color: widget.model.selectedStatus != null &&
                            widget.model.selectedStatus == e.status
                        ? AppColors.appFaddedBlue
                        : null,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        e.iconPath,
                        height: 30.h,
                      ),
                      Text(
                        getReadableVehicleStatus(e.status),
                        style: TextStyling.regular.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: widget.onCancel,
              child: Text(
                'Cancel',
                style: TextStyling.semiBold.copyWith(
                  color: AppColors.appDarkBlue,
                  fontSize: 14.sp,
                ),
              ),
            ),
            TextButton(
              onPressed: widget.onConfirm,
              child: Text(
                'Confirm',
                style: TextStyling.semiBold.copyWith(
                  color: AppColors.appSkyBlue,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
