// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/groups/models/groups_main_view_model.dart';
import 'package:starter_app/src/views/groups/widgets/group_tile_widget.dart';

class GroupsMainView extends StackedView<GroupsMainViewModel> {
  @override
  Widget builder(
      BuildContext context, GroupsMainViewModel model, Widget? child) {
    return Scaffold(
      body: Container(
        width: context.screenSize().width,
        height: context.completeHeight(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset(AssetImages.squaresBg).image,
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
              CustomAppBar(
                titleText: 'Groups',
              ),
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
                        groupCard(
                            () {}, 'Public Groups', AssetImages.publicGroups),
                        groupCard(
                            () {}, 'Private Groups', AssetImages.privateGroups),
                        groupCard(() {}, 'My Groups', AssetImages.myGroups),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      "Groups for you",
                      style: TextStyling.bold.copyWith(fontSize: 18.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.55,
                      child: ListView.builder(
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return GroupsTile(
                            adminName: "Tanzeel",
                            createdate: DateTime.now(),
                            groupName: "Scouts",
                            imagepath: AssetImages.sampleGroupImage,
                            onAddIconTap: () {},
                            onArrowIconTap: () {},
                            onMoreIconTap: () {},
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //! Widgets ------------------------------------------------

  Column groupCard(Function() ontap, String title, String imagePath) {
    return Column(
      children: [
        GestureDetector(
          onTap: ontap,
          child: Container(
            height: 115.h,
            width: 110.w,
            padding: EdgeInsets.all(15.sp),
            decoration: AppColors.groupCardsDecoration,
            child: Image(image: Image.asset(imagePath).image),
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Text(
          title,
          style: TextStyling.semiBold.copyWith(fontSize: 15.sp),
        )
      ],
    );
  }

  @override
  GroupsMainViewModel viewModelBuilder(BuildContext context) =>
      GroupsMainViewModel();

  @override
  void onViewModelReady(GroupsMainViewModel model) => model.init();
}
