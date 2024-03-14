import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_app/src/base/enums/blood_group.dart';
import 'package:starter_app/src/base/enums/gender.dart';
import 'package:starter_app/src/base/enums/riding_experience.dart';
import 'package:starter_app/src/shared/profile_textfield.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/profile/profile_view_model.dart';

class PersonalDetailSection extends StatelessWidget {
  const PersonalDetailSection({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ProfileViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalSpacing(10.h),
        Text(
          'Personal Information',
          style: TextStyling.medium.copyWith(
            color: AppColors.white.withOpacity(0.7),
            fontSize: 18.sp,
          ),
        ),
        VerticalSpacing(24.h),
        ProfileTextField(
          controller: model.firstnameController,
          title: 'First Name',
        ),
        VerticalSpacing(10.h),
        ProfileTextField(
          controller: model.lastnameController,
          title: 'Last Name',
        ),
        VerticalSpacing(10.h),
        ProfileTextField(
          controller: model.emailController,
          title: 'Email',
          readOnly: true,
        ),
        VerticalSpacing(10.h),
        ProfileTextField(
          controller: model.aliasController,
          title: 'Alias',
        ),
        VerticalSpacing(10.h),
        ProfileTextField(
          controller: model.bioController,
          title: 'Bio',
        ),
        VerticalSpacing(10.h),
        ProfileTextField(
          controller: model.mobileController,
          title: 'Phone',
          textInputType: TextInputType.phone,
        ),
        VerticalSpacing(10.h),
        ProfileTextField(
          controller: model.dobController,
          title: 'Date of Birth',
          readOnly: true,
          onTap: () {},
          suffixIcon: IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            style: IconButton.styleFrom(
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () async {
              final selectedDate = await DatePicker.showSimpleDatePicker(
                context,
                backgroundColor: AppColors.appDarkBlue.withOpacity(1),
                dateFormat: 'dd-MMM-yyyy',
                confirmText: 'Confirm',
                cancelText: 'Cancel',
                titleText: 'Birth Date',
                itemTextStyle: TextStyling.bold.copyWith(),
                textColor: AppColors.white,
                confirmTextColor: AppColors.appSkyBlue,
                cancelTextColor: AppColors.appFaddedBlue,
                lastDate: DateTime.now(),
                initialDate: model.dob ?? DateTime.now(),
              );

              model.onSelectDob(selectedDate);
            },
            icon: Icon(
              Icons.calendar_month,
              color: AppColors.white,
            ),
          ),
        ),
        VerticalSpacing(10.h),
        ProfileTextField(
          controller: model.ageController,
          title: 'Age',
          readOnly: true,
        ),
        VerticalSpacing(10.h),
        ProfileTextField(
          controller: model.genderController,
          title: 'Gender',
          readOnly: true,
          suffixIcon: IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            style: IconButton.styleFrom(
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () async {
              model.selectedGender = model.gender;
              model.notifyListeners();

              final Gender? gender = await showDialog(
                context: context,
                builder: (context) {
                  return CustomDialog(
                    model: model,
                    title: 'Gender',
                    onCancel: () {
                      Navigator.pop(context);
                    },
                    onConfirm: () {
                      if (model.selectedGender != null) {
                        Navigator.pop(context, model.selectedGender);
                      }
                    },
                  );
                },
              );

              model.onSelectGender(gender);
            },
            icon: Icon(
              Icons.edit,
              color: AppColors.white,
            ),
          ),
        ),
        VerticalSpacing(10.h),
        ProfileTextField(
          controller: model.bloodGroupController,
          title: 'Blood Group',
          readOnly: true,
          suffixIcon: IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            style: IconButton.styleFrom(
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () async {
              model.selectedBloodGroup = model.bloodGroup;
              model.notifyListeners();

              final BloodGroup? bloodGroup = await showDialog(
                context: context,
                builder: (context) {
                  return BloodGroupDialog(
                    model: model,
                    title: 'Blood Group',
                    onCancel: () {
                      Navigator.pop(context);
                    },
                    onConfirm: () {
                      if (model.selectedBloodGroup != null) {
                        Navigator.pop(context, model.selectedBloodGroup);
                      }
                    },
                  );
                },
              );

              model.onSelectBloodGroup(bloodGroup);
            },
            icon: Icon(
              Icons.edit,
              color: AppColors.white,
            ),
          ),
        ),
        VerticalSpacing(10.h),
        Text(
          'Riding Experience (if any)',
          style: TextStyling.medium.copyWith(
            color: AppColors.white.withOpacity(0.7),
            fontSize: 12.sp,
          ),
        ),
        VerticalSpacing(5.h),
        DropdownButton<RidingExperience>(
          style: TextStyling.medium.copyWith(
              // fontSize:
              ),
          hint: Text(
            'Riding Experience',
            style: TextStyling.thin.copyWith(
              fontSize: 12.sp,
              color: AppColors.white.withOpacity(0.6),
            ),
          ),
          dropdownColor: AppColors.appDarkBlue,
          value: model.ridingExperience,
          items: RidingExperience.values
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    getReadableRidingExperience(e),
                  ),
                ),
              )
              .toList(),
          onChanged: (v) {
            model.onSelectRidingExperience(v);
          },
          isExpanded: true,
        ),
        VerticalSpacing(15.h),
        ProfileTextField(
          controller: model.nextOfKin,
          title: 'Next of Kin',
        ),
        VerticalSpacing(10.h),
        ProfileTextField(
          controller: model.nextOfKinMobile,
          title: 'Next of Kin Mobile',
          textInputType: TextInputType.phone,
        ),
      ],
    );
  }
}

class CustomDialog extends StatefulWidget {
  final String title;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  final ProfileViewModel model;

  CustomDialog(
      {required this.title,
      required this.onCancel,
      required this.onConfirm,
      required this.model});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
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
            children: widget.model.genderButtons.map((e) {
              return GestureDetector(
                onTap: () {
                  widget.model.toggleGender(e.gender);
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
                    color: widget.model.selectedGender != null &&
                            widget.model.selectedGender == e.gender
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
                        getReadableGender(e.gender),
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

class BloodGroupDialog extends StatefulWidget {
  final String title;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  final ProfileViewModel model;

  BloodGroupDialog(
      {required this.title,
      required this.onCancel,
      required this.onConfirm,
      required this.model});

  @override
  State<BloodGroupDialog> createState() => _BloodGroupDialogState();
}

class _BloodGroupDialogState extends State<BloodGroupDialog> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background blur effect
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            constraints: BoxConstraints.expand(),
          ),
        ),
        // Dialog content
        AlertDialog(
          backgroundColor: AppColors.grey.withOpacity(0.7),
          title: Text(widget.title),
          titleTextStyle: TextStyling.bold.copyWith(fontSize: 18.sp),
          content: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            spacing: 10.w,
            runSpacing: 10.w,
            children: BloodGroup.values.map((e) {
              return GestureDetector(
                onTap: () {
                  widget.model.toggleBloodGroup(e);
                  setState(() {});
                },
                child: Container(
                  height: 60.w,
                  width: 60.w,
                  decoration: BoxDecoration(
                    color: widget.model.selectedBloodGroup != null &&
                            widget.model.selectedBloodGroup == e
                        ? AppColors.appFaddedBlue
                        : null,
                    border: Border.all(
                      color: AppColors.appFaddedBlue,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        getReadableBloodGroup(e),
                        style: TextStyling.bold.copyWith(
                          fontSize: 18.sp,
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
