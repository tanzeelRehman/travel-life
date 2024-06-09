import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/home_action_button.dart';
import 'package:starter_app/src/shared/home_drawer.dart';
import 'package:starter_app/src/shared/profile_avatar.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/home/home_view_model.dart';

class HomeView extends StackedView<HomeViewModel> {
  @override
  Widget builder(BuildContext context, HomeViewModel model, Widget? child) {
    return Scaffold(
      key: model.scaffoldKey,
      drawer: HomeDrawer(model),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset(AssetImages.homeBikeBg).image,
            alignment: Alignment.topLeft,
            fit: BoxFit.none,
          ),
        ),
        child: Container(
          width: context.screenSize().width,
          height: context.completeHeight(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset(AssetImages.mainBg).image,
              fit: BoxFit.cover,
              opacity: 0.5,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 24.w,
              right: 24.w,
              top: 16.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpacing(40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello,',
                            style: TextStyling.medium.copyWith(
                              fontSize: 18.sp,
                            ),
                          ),
                          Text(
                            model.supabaseAuthService.user?.firstname != null
                                ? "${model.supabaseAuthService.user?.firstname}" +
                                    (model.supabaseAuthService.user?.lastname !=
                                            null
                                        ? "\n${model.supabaseAuthService.user?.lastname}"
                                        : "")
                                : '',
                            style: TextStyling.semiBold.copyWith(
                              fontSize: 35.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ProfileAvatar(
                    //   onClickProfile: model.onClickProfile,
                    //   avatarUrl: model.supabaseAuthService.user?.avatar,
                    // ),
                    Stack(
                      children: [
                        ProfileAvatar(
                          onClickProfile: model.onClickProfile,
                          avatarUrl: model.supabaseAuthService.user?.avatar,
                        ),
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: GestureDetector(
                            onTap: () {
                              // Scaffold.maybeOf(context)?.openDrawer();
                              model.scaffoldKey.currentState!.openDrawer();
                            },
                            child: Container(
                              height: 26.h,
                              width: 26.h,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                // borderRadius: BorderRadius.circular(10.r),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(Icons.menu, size: 16.sp),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // VerticalSpacing(30.h), //80.

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 30.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: HomeActionButton(
                                buttonText: 'Trip Planner',
                                buttonTextColor: AppColors.tripPlannerColor,
                                iconGradeint: AppColors.tripPlannerGradient,
                                iconPath: AssetIcons.tripPlannerButtonIcon,
                                bgPath: AssetIcons.tripPlannerButtonBg,
                                onTap: model.onClickTripPlanner,
                              ),
                            ),
                            HorizontalSpacing(24.w),
                            Expanded(
                              child: HomeActionButton(
                                buttonText: 'Vehicle Registration',
                                buttonTextColor:
                                    AppColors.vehicleRegistrationColor,
                                iconPath:
                                    AssetIcons.vehicleRegistrationButtonIcon,
                                iconGradeint:
                                    AppColors.vehicleRegistrationGradient,
                                bgPath: AssetIcons.vehicleRegistrationButtonBg,
                                onTap: model.onClickVehicleRegistration,
                              ),
                            ),
                          ],
                        ),
                        VerticalSpacing(24.h),
                        Row(
                          children: [
                            Expanded(
                              child: HomeActionButton(
                                buttonText: 'Groups',
                                buttonTextColor: AppColors.groupsColor,
                                iconGradeint: AppColors.groupsGradient,
                                iconPath: AssetIcons.groupsButtonIcon,
                                bgPath: AssetIcons.groupsButtonBg,
                                onTap: model.onClickGroups,
                              ),
                            ),
                            HorizontalSpacing(24.w),
                            Expanded(
                              child: HomeActionButton(
                                buttonText: 'Money Manager',
                                buttonTextColor: AppColors.moneyManagerColor,
                                iconPath: AssetIcons.moneyManagerButtonIcon,
                                iconGradeint: AppColors.moneyManagerGradient,
                                bgPath: AssetIcons.moneyManagerButtonBg,
                                onTap: model.onClickMoneyManager,
                              ),
                            ),
                          ],
                        ),
                        VerticalSpacing(24.h),
                        Row(
                          children: [
                            Expanded(
                              child: HomeActionButton(
                                buttonText: 'Chats',
                                buttonTextColor: AppColors.chatsColor,
                                iconGradeint: AppColors.chatsGradient,
                                iconPath: AssetIcons.chatsButtonIcon,
                                bgPath: AssetIcons.chatsButtonBg,
                                onTap: model.onClickChats,
                              ),
                            ),
                            HorizontalSpacing(24.w),
                            Expanded(
                              child: HomeActionButton(
                                buttonText: 'Event Money Manager',
                                buttonTextColor:
                                    AppColors.eventMoneyManagerColor,
                                iconPath: AssetIcons.eventMoneyMngButtonIcon,
                                iconGradeint:
                                    AppColors.eventMoneyManagerGradient,
                                bgPath: AssetIcons.eventMoneyMngButtonBg,
                                onTap: model.onClickEventMoneyManager,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel model) => model.init();
}
