import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/group_action.dart';
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart';
import 'package:starter_app/src/base/enums/vehicle_status.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/manufacturor.dart';
import 'package:starter_app/src/models/ui_models/vehicle_status_button_model.dart';
import 'package:starter_app/src/models/vehicle.dart';
import 'package:starter_app/src/models/vehicle_model.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/custom_datepicker_dialog.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/shared/vehicle_registration_field.dart';
import 'package:starter_app/src/shared/vehicle_registration_select_widget.dart';
import 'package:starter_app/src/shared/vehicle_registration_textfield.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/bottomsheets/manufacturer_bottomsheet/manufacturer_bottomsheet_view.dart';
import 'package:starter_app/src/views/bottomsheets/vehicle_model_bottomsheet/vehicle_model_bottomsheet_view.dart';
import 'package:starter_app/src/views/groups/group_create/group_create_view_model.dart';
import 'package:starter_app/src/views/vehicle_registration/vehicle_detail/vehicle_detail_view_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class GroupCreateView extends StackedView<GroupCreateViewModel> {
  final GroupAction action;

  GroupCreateView({
    required this.action,
  });

  @override
  Widget builder(
    BuildContext context,
    GroupCreateViewModel model,
    Widget? child,
  ) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 27.w,
            vertical: 10.h,
          ),
          child: MainButton(
            buttonText: action == VehicleRegistrationAction.add
                ? 'Create Group'
                : 'Save',
            onPressed: () {},
            isLoading: false,
          ),
        ),
        body: Container(
          width: context.screenSize().width,
          height: context.screenSize().height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset(
                AssetImages.vehicleRegistrationBg,
                height: context.screenSize().height,
                width: context.screenSize().width,
              ).image,
              fit: BoxFit.cover,
              opacity: 0.7,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 00,
                child: Container(
                  height: context.screenSize().height * 0.30,
                  width: context.screenSize().width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                    color: AppColors.white.withOpacity(0.1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 70.h,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 60.sp,
                          width: 60.sp,
                          decoration: BoxDecoration(
                            gradient: AppColors.mainButtonGradient,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(
                            Icons.add,
                            color: AppColors.white,
                            size: 40.sp,
                          ),
                        ),
                      ),
                      VerticalSpacing(10.h),
                      Text(
                        'Add Image',
                        style: TextStyling.regular.copyWith(
                          fontSize: 12.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomAppBar(
                    titleText: 'Create Group',
                  ),
                  VerticalSpacing(context.screenSize().height * 0.23),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 27.w,
                        vertical: 10.h,
                      ),
                      child: Column(
                        children: [
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.groupNameIcon,
                            labelText: 'Group Name',
                            controller: TextEditingController(),
                          ),
                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.groupAdminIcon,
                            labelText: 'Group Admin',
                            controller: TextEditingController(),
                          ),
                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            height: 200.h,
                            svgIconPath: AssetIcons.tfDescription,
                            labelText: 'Description',
                            multiline: true,
                          ),
                          VerticalSpacing(20.h),
                          VehicleRegistrationField(
                            // labelText: 'Model',
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          boxShadow: AppColors
                                              .vehicleRegTextFieldBoxShadows,
                                        ),
                                        height: 50.h,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Private',
                                              style:
                                                  TextStyling.medium.copyWith(
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    HorizontalSpacing(10.w),
                                    Checkbox(
                                      value: false,
                                      onChanged: (v) {},
                                      activeColor: AppColors.appSkyBlue,
                                      side: BorderSide(
                                        color: AppColors.appSkyBlue,
                                      ),
                                    ),
                                  ],
                                ),
                                VerticalSpacing(10.h),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          boxShadow: AppColors
                                              .vehicleRegTextFieldBoxShadows,
                                        ),
                                        height: 50.h,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Public',
                                              style:
                                                  TextStyling.medium.copyWith(
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    HorizontalSpacing(10.w),
                                    Checkbox(
                                      value: true,
                                      onChanged: (v) {},
                                      activeColor: AppColors.appSkyBlue,
                                      side: BorderSide(
                                        color: AppColors.appSkyBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.groupLimitIcon,
                            labelText: 'Total Limit',
                            controller: TextEditingController(),
                            inputType: TextInputType.number,
                          ),
                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.groupCreatedIcon,
                            labelText: 'Created on',
                            controller: TextEditingController(),
                          ),
                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.groupCreatedByIcon,
                            labelText: 'Created by',
                            controller: TextEditingController(),
                          ),
                          VerticalSpacing(20.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  GroupCreateViewModel viewModelBuilder(BuildContext context) =>
      GroupCreateViewModel();

  @override
  void onViewModelReady(GroupCreateViewModel model) => model.init();
}
