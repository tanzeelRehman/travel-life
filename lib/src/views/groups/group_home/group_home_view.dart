import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/shared/custom_app_bar_with_transparent_bg.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/groups/group_home/group_home_view_model.dart';

class GroupHomeView extends StackedView<GroupHomeViewModel> {
  final Group group;
  GroupHomeView({
    required this.group,
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
                            bottomRight: Radius.circular(25.r),
                          ),
                          child: group.groupImage != null
                              ? CachedNetworkImage(
                                  imageUrl: group.groupImage!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  AssetImages.defaultImage,
                                  fit: BoxFit.contain,
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 35.h,
                      child: CustomAppBarWithTransparentBG(
                          groupName: group.name ?? ''),
                    ),
                    Positioned(
                      bottom: 20.h,
                      child: seeMembersTile(
                        context,
                        model.totalMembers,
                        (() {
                          model.navigateToSeeAllMembers();
                        }),
                      ),
                    )
                  ],
                ),
              ),
              //! START OF THE BODY --------------------------------------------
              //?================================================================>
              //WHEN im admin and the group is a private group
              if (model.isGroupAdmin() && !(group.isPublic ?? true))
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 27.w, vertical: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          subMenuCard(
                              AssetImages.groupChatIcon, 'Chats', () {}),
                          subMenuCard(AssetImages.groupJoinRequestsIcon,
                              'Join Requests', () {
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Spacer(),
                          subMenuCard(
                              AssetImages.groupJoinRequestsIcon, 'Invites', () {
                            model.navigateToInviteScreen();
                          }),
                          Spacer(),
                          subMenuCard(AssetImages.groupSettingsIcon, 'Settings',
                              () {
                            model.navigateToEditGroupDetails();
                          }),
                          Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              //WHEN im admin and the group is a public group
              if (model.isGroupAdmin() && (group.isPublic ?? true))
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 27.w, vertical: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          subMenuCard(
                            AssetImages.groupChatIcon,
                            'Chats',
                            () {},
                          ),
                          subMenuCard(
                            AssetImages.groupExpensesIcon,
                            'Expenses',
                            () {},
                          ),
                          subMenuCard(
                            AssetImages.groupSettingsIcon,
                            'Settings',
                            () {
                              model.navigateToEditGroupDetails();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              //WHEN im not an admin
              if (!model.isGroupAdmin())
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 27.w, vertical: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          subMenuCard(
                            AssetImages.groupChatIcon,
                            'Chats',
                            () {},
                          ),
                          subMenuCard(
                            AssetImages.groupExpensesIcon,
                            'Expenses',
                            () {},
                          ),
                          Opacity(
                            opacity: 0,
                            child: subMenuCard(
                              AssetImages.groupExpensesIcon,
                              'Expenses',
                              () {},
                            ),
                          ),
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
    BuildContext context,
    int memberCount,
    VoidCallback onSeeAllMembers,
  ) {
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
  void onViewModelReady(GroupHomeViewModel model) => model.init(group);
}
