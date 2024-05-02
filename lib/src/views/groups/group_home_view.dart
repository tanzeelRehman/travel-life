// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/group_type.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/custom_app_bar_with_transparent_bg.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/groups/models/group_home_view_model.dart';
import 'package:starter_app/src/views/groups/models/groups_lists_view_model.dart';
import 'package:starter_app/src/views/groups/models/groups_main_view_model.dart';
import 'package:starter_app/src/views/groups/widgets/group_tile_widget.dart';

class GroupHomeView extends StackedView<GroupHomeViewModel> {
  final String groupName;
  GroupHomeView({
    required this.groupName,
  });

  @override
  Widget builder(
      BuildContext context, GroupHomeViewModel model, Widget? child) {
    return Scaffold(
      body: Container(
        width: context.screenSize().width,
        height: context.completeHeight(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset(AssetImages.vehicleRegistrationBg).image,
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 12.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Stack(
                  children: [
                    Positioned(
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25.r),
                                bottomRight: Radius.circular(25.r)),
                            child: Image.asset(
                              AssetImages.sampleGroupImage,
                              fit: BoxFit.fitWidth,
                            ),
                          )),
                    ),
                    Positioned(
                      top: 35.h,
                      child:
                          CustomAppBarWithTransparentBG(groupName: groupName),
                    ),
                    Positioned(
                      bottom: 20.h,
                      child: seeMembersTile(context, 45, (() {
                        model.navigateToSeeAllMembers();
                      })),
                    )
                  ],
                ),
              ),
              //! START OF THE BODY --------------------------------------------
              //?================================================================>
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        subMenuCard(AssetImages.groupChatIcon, 'Chats', () {}),
                        subMenuCard(
                            AssetImages.groupJoinRequestsIcon, 'Join Requests',
                            () {
                          model.navigateToJoinRequestsScreen();
                        }),
                        subMenuCard(
                            AssetImages.groupExpensesIcon, 'Expenses', () {}),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        subMenuCard(AssetImages.groupSettingsIcon, 'Settings',
                            () {
                          model.navigateToEditGroupDetails();
                        }),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column subMenuCard(String imagePath, String name, Function() ontap) {
    return Column(
      children: [
        GestureDetector(
          onTap: ontap,
          child: Container(
            height: 110.h,
            width: 110.w,
            decoration: AppColors.groupCardsDecoration2MoreTransparent,
            padding: EdgeInsets.all(25.sp),
            child: Image.asset(imagePath),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          name,
          style: TextStyling.bold,
        )
      ],
    );
  }

// ! Widgets -----------------------------------------------------------
//?======================================================================
  SizedBox seeMembersTile(
      BuildContext context, int memberCount, Function() onSeeAllMembers) {
    return SizedBox(
      width: context.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 55.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
                color: AppColors.blueGrayShade,
                borderRadius: BorderRadius.circular(12.r)),
            width: context.width * 0.85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Members ($memberCount)',
                  style: TextStyling.thin.copyWith(fontSize: 13.sp),
                ),
                GestureDetector(
                  onTap: onSeeAllMembers,
                  child: Text(
                    'See all members',
                    style: TextStyling.bold.copyWith(
                        color: AppColors.appSkyBlueLight, fontSize: 13.sp),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  GroupHomeViewModel viewModelBuilder(BuildContext context) =>
      GroupHomeViewModel();

  @override
  void onViewModelReady(GroupHomeViewModel model) => model.init();
}
