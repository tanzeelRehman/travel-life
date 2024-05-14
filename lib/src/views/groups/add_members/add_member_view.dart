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
import 'package:starter_app/src/views/groups/add_members/add_member_view_model.dart';
import 'package:starter_app/src/views/groups/groups_lists/groups_lists_view_model.dart';
import 'package:starter_app/src/views/groups/groups_main/groups_main_view_model.dart';
import 'package:starter_app/src/views/groups/widgets/add_member_searchbar.dart';
import 'package:starter_app/src/views/groups/widgets/add_member_tile.dart';
import 'package:starter_app/src/views/groups/widgets/group_tile_widget.dart';

class AddMemberView extends StackedView<AddMemberViewModel> {
  @override
  Widget builder(
      BuildContext context, AddMemberViewModel model, Widget? child) {
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
                    AddMemberSearchBar(
                      seacrchController: TextEditingController(),
                      onSearch: () {},
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    SizedBox(
                      width: context.width * 0.88,
                      height: 35,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: model.selectedMembersList.length,
                        itemBuilder: (context, index) {
                          return selectedMemberChip(model, index);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    SizedBox(
                      height: context.height * 0.6,
                      width: context.width * 0.88,
                      child: ListView.builder(
                        itemCount: model.allMembersList.length,
                        itemBuilder: (context, index) {
                          return AddMemberTile(
                              name: model.allMembersList[index], model: model);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        model.sendInvite();
                      },
                      child: Container(
                        height: 56.h,
                        alignment: Alignment.center,
                        width: context.width * 0.88,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          gradient: AppColors.mainButtonGradient,
                        ),
                        child: Text(
                          'Send',
                          style: TextStyling.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //! WIDGETS=========================================================

  Widget selectedMemberChip(AddMemberViewModel model, int index) {
    return GestureDetector(
      onTap: () {
        model.removeMemberToList(model.selectedMembersList[index]);
      },
      child: Container(
        height: 25.h,
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            gradient: AppColors.mainButtonGradient),
        child: Row(
          children: [
            Text(
              model.selectedMembersList[index],
              style: TextStyling.medium,
            ),
            SizedBox(
              width: 15.w,
            ),
            Icon(
              Icons.cancel_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  @override
  AddMemberViewModel viewModelBuilder(BuildContext context) =>
      AddMemberViewModel();

  @override
  void onViewModelReady(AddMemberViewModel model) => model.init();
}
