import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/custom_tab.dart';
import 'package:starter_app/src/shared/editable_profile_avatar.dart';
import 'package:starter_app/src/shared/full_screen_loading_indicator.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/shared/tab_switcher_widget.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/views/profile/extended_profile_section.dart';
import 'package:starter_app/src/views/profile/personal_detail_section.dart';
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
                  trailingWidget: GestureDetector(
                    onTap: model.onClickLogout,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: AppColors.logoutButtonGradient,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      height: 25.w,
                      width: 25.w,
                      child: Center(
                        child: SvgPicture.asset(AssetIcons.logoutIcon),
                      ),
                    ),
                  ),
                ),
                VerticalSpacing(20.h),
                EditableProfileAvatar(
                  avatarUrl: model.supabaseAuthService.user?.avatar,
                  onClickCamera: model.onClickAddImage,
                ),
                VerticalSpacing(15.h),
                TabSwitcherWidget(
                  tabs: [
                    CustomTab(
                      title: 'Personal Details',
                      onTap: () {
                        model.toggleSelectedTab(0);
                      },
                      isSelected: model.selectedTab == 0,
                    ),
                    CustomTab(
                      title: 'Extended Profile',
                      onTap: () {
                        model.toggleSelectedTab(1);
                      },
                      isSelected: model.selectedTab == 1,
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 27.w,
                      vertical: 16.h,
                    ),
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
          FullScreenLoadingIndicator(
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
