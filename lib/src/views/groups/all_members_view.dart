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
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/vehicle_registration_textfield.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/groups/models/add_member_view_model.dart';
import 'package:starter_app/src/views/groups/models/all_members_view_model.dart';
import 'package:starter_app/src/views/groups/models/groups_lists_view_model.dart';
import 'package:starter_app/src/views/groups/models/groups_main_view_model.dart';
import 'package:starter_app/src/views/groups/widgets/add_member_searchbar.dart';
import 'package:starter_app/src/views/groups/widgets/add_member_tile.dart';
import 'package:starter_app/src/views/groups/widgets/group_tile_widget.dart';

class AllMembersView extends StackedView<AllMembersViewModel> {
  @override
  Widget builder(
      BuildContext context, AllMembersViewModel model, Widget? child) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          padding: EdgeInsets.only(top: 12.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                titleText: 'Add Members',
              ),
              Spacer(),
              Container(
                height: context.height * 0.85,
                width: context.width,
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 25.h),
                decoration: AppColors.groupCardsDecoration.copyWith(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Members',
                            style: TextStyling.bold,
                          ),
                          GestureDetector(
                            onTap: () {
                              model.navigateToInviteMiddleScreen();
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 25.h,
                                  width: 25.h,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: AppColors.mainButtonGradient),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 17.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  'Invite',
                                  style: TextStyling.thin,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    SizedBox(
                      height: context.height * 0.73,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return groupMemberTile(context, false, 0, model);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  AllMembersViewModel viewModelBuilder(BuildContext context) =>
      AllMembersViewModel();

  @override
  void onViewModelReady(AllMembersViewModel model) => model.init();

  //! WIDGETS=========================================================
  Widget groupMemberTile(BuildContext context, bool isAdmin, int index,
      AllMembersViewModel model) {
    return GestureDetector(
      onTap: () {
        model.navigateToMemberProfile();
      },
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.withOpacity(.5),
            height: 1,
          ),
          SizedBox(
            height: 25.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 35.r,
                    backgroundImage: AssetImage(AssetImages.sampleUser),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tanzeel',
                        style: TextStyling.semiBold,
                      ),
                      Text(
                        'Joining Date: ${DateFormat.yMMMd().format(DateTime.now())} ',
                        style: TextStyling.thin,
                      ),
                    ],
                  ),
                ],
              ),
              isAdmin
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.sp, vertical: 8.h),
                      decoration: BoxDecoration(
                        gradient: AppColors.mainButtonGradient,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Text(
                        'Admin',
                        style: TextStyling.bold,
                      ),
                    )
                  : Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20.sp,
                    )
            ],
          ),
          SizedBox(
            height: 25.h,
          ),
        ],
      ),
    );
  }
}
