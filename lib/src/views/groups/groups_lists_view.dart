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

class GroupsListsView extends StackedView<GroupsMainViewModel> {
  final String groupType;

  GroupsListsView(this.groupType);
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
                titleText: '$groupType Groups',
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    if (groupType == 'Public')
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
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
                      ),
                    if (groupType == 'Private')
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
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

  @override
  GroupsMainViewModel viewModelBuilder(BuildContext context) =>
      GroupsMainViewModel();

  @override
  void onViewModelReady(GroupsMainViewModel model) =>
      model.initGroupsList(groupType);
}
