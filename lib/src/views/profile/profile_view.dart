import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/custom_tab.dart';
import 'package:starter_app/src/shared/full_loading_indicator.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/profile/profile_view_model.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  @override
  Widget builder(BuildContext context, ProfileViewModel model, Widget? child) {
    return Stack(
      children: [
        Scaffold(
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 27.w,
              vertical: 10.h,
            ),
            child: MainButton(
              buttonText: 'Save Changes',
              onPressed: model.onClickSave,
              isLoading: model.isBusy,
            ),
          ),
          body: Container(
            width: context.screenSize().width,
            height: context.screenSize().height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.asset(
                  AssetImages.mainBg,
                  height: context.screenSize().height,
                  width: context.screenSize().width,
                ).image,
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomAppBar(
                  titleText: 'Edit Profile Info',
                ),
                VerticalSpacing(20.h),
                Stack(
                  children: [
                    SizedBox(
                      height: 160.w,
                      width: 160.w,
                      child: CircleAvatar(
                        backgroundColor: AppColors.appFaddedBlue,
                        backgroundImage:
                            model.supabaseAuthService.user?.avatar != null
                                ? CachedNetworkImageProvider(
                                    model.supabaseAuthService.user!.avatar!,
                                  )
                                : null,
                        child: model.supabaseAuthService.user?.avatar != null
                            ? null
                            : Text(
                                'select a image',
                                style: TextStyling.thin
                                    .copyWith(color: AppColors.black),
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: model.onClickAddImage,
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.appDarkBlue,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.appDarkBlue,
                              shape: BoxShape.circle,
                            ),
                            height: 50.w,
                            width: 50.w,
                            padding: EdgeInsets.all(8),
                            child: SvgPicture.asset(AssetIcons.cameraIcon),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                VerticalSpacing(15.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 27.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.r),
                      ),
                    ),
                    padding: EdgeInsets.all(2.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTab(
                            title: 'Personal Details',
                            onTap: () {
                              model.toggleSelectedTab(0);
                            },
                            isSelected: model.selectedTab == 0,
                          ),
                        ),
                        HorizontalSpacing(5.w),
                        Expanded(
                          child: CustomTab(
                            title: 'Extended Profile',
                            onTap: () {
                              model.toggleSelectedTab(1);
                            },
                            isSelected: model.selectedTab == 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 27.w, vertical: 16.h),
                    child: model.selectedTab == 0
                        ? PersonalDetailSection(
                            model: model,
                          )
                        : ExtendedProfileSection(model: model),
                  ),
                )
              ],
            ),
          ),
        ),
        if (model.isUploading)
          FullLoadingIndicator(
            color: AppColors.primary,
            size: 50.r,
          ),
      ],
    );
  }

  @override
  ProfileViewModel viewModelBuilder(BuildContext context) => ProfileViewModel();

  @override
  void onViewModelReady(ProfileViewModel model) => model.init();
}

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
        ProfileTextField(
          controller: model.ridingExperienceController,
          title: 'Riding Experience (if any)',
        ),
        VerticalSpacing(10.h),
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
        VerticalSpacing(10.h),
        ProfileTextField(
          controller: model.aliasController,
          title: 'Alias',
        ),
      ],
    );
  }
}

class ExtendedProfileSection extends StatelessWidget {
  const ExtendedProfileSection({
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
          'Residential Information',
          style: TextStyling.medium.copyWith(
            color: AppColors.white.withOpacity(0.7),
            fontSize: 18.sp,
          ),
        ),
        VerticalSpacing(24.h),
        ProfileTextField(
          controller: model.addressController,
          title: 'Address',
        ),
        VerticalSpacing(10.h),
        ProfileTextField(
          controller: model.cityController,
          title: 'City',
          // readOnly: true,
        ),
        VerticalSpacing(10.h),
        ProfileTextField(
          controller: model.stateController,
          title: 'State',
          // readOnly: true,
        ),
        VerticalSpacing(10.h),
        ProfileTextField(
          controller: model.countryController,
          title: 'Country',
          // readOnly: true,
        ),
        VerticalSpacing(10.h),
        ProfileTextField(
          controller: model.zipCodeController,
          title: 'Zip',
        ),
        VerticalSpacing(24.h),
        Text(
          'More',
          style: TextStyling.regular.copyWith(
            color: AppColors.white.withOpacity(0.7),
            fontSize: 18.sp,
          ),
        ),
        VerticalSpacing(24.h),
        ProfileTextField(
          controller: model.websiteController,
          title: 'Website',
        ),
        VerticalSpacing(10.h),
        ProfileTextField(
          controller: model.currencyController,
          title: 'Currency',
          readOnly: true,
          suffixIcon: IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            style: IconButton.styleFrom(
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () async {
              showCurrencyPicker(
                theme: CurrencyPickerThemeData(
                  backgroundColor: AppColors.appDarkBlue.withOpacity(1),
                  titleTextStyle: TextStyling.bold.copyWith(
                    fontSize: 14.sp,
                  ),
                  currencySignTextStyle: TextStyling.bold.copyWith(
                    fontSize: 18.sp,
                  ),
                  subtitleTextStyle: TextStyling.medium.copyWith(
                    fontSize: 12.sp,
                  ),
                  bottomSheetHeight: context.height * 0.7,
                  inputDecoration: InputDecoration(
                    fillColor: AppColors.lightGrey,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 27.w,
                    ),
                    hintStyle: TextStyling.thin.copyWith(),
                    labelStyle: TextStyling.thin,
                  ),
                ),
                showFlag: true,
                showCurrencyName: true,
                showCurrencyCode: true,
                context: context,
                onSelect: (v) {
                  model.currencyController.text = v.code;
                },
              );
            },
            icon: Icon(
              Icons.search,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}

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
  final VoidCallback? onTap; // for fields such as dob, gender etc.
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
                fontSize: 10.sp,
                // color: AppColors.darkGrey.withOpacity(1),
                color: AppColors.appTextfieldBorderColor,
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
