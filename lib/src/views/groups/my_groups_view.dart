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
import 'package:starter_app/src/shared/custom_tab.dart';
import 'package:starter_app/src/shared/tab_switcher_widget.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/groups/models/groups_main_view_model.dart';
import 'package:starter_app/src/views/groups/models/my_groups_view_model.dart';
import 'package:starter_app/src/views/groups/widgets/group_tile_widget.dart';
import 'package:starter_app/src/views/groups/widgets/groups_card.dart';
import 'package:starter_app/src/views/groups/widgets/groups_invite_tile_widget.dart';

class MyGroupsView extends StackedView<MyGroupsViewModel> {
  @override
  Widget builder(BuildContext context, MyGroupsViewModel model, Widget? child) {
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
          padding: EdgeInsets.only(top: 15.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                titleText: 'My Groups',
              ),
              SizedBox(
                height: 20.h,
              ),
              TabSwitcherWidget(
                horizontalSpacing: 0,
                outerPadding: EdgeInsets.symmetric(horizontal: 20.w),
                tabs: [
                  CustomTab(
                    count: 2,
                    title: 'My Groups',
                    onTap: () {
                      model.onChangeTab(0);
                    },
                    isSelected: model.selectedTab == 0,
                  ),
                  CustomTab(
                    count: 5,
                    title: 'Joined Groups',
                    onTap: () {
                      model.onChangeTab(1);
                    },
                    isSelected: model.selectedTab == 1,
                  ),
                  CustomTab(
                    count: 20,
                    title: 'Invites',
                    onTap: () {
                      model.onChangeTab(2);
                    },
                    isSelected: model.selectedTab == 2,
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              //! My Groups List
              if (model.selectedTab == 0)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.77,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Groupscard(
                          adminName: 'Tanzeel',
                          dateCreated: DateTime.now(),
                          groupName: 'Scouts',
                          imagepath: AssetImages.sampleGroupImage,
                          onDelete: () {},
                          onEditDetailstap: () {},
                          onMoreIconTap: () {},
                          onSeeAllMembersTap: () {},
                        );
                      },
                    ),
                  ),
                ),
              //! Joined Groups List
              if (model.selectedTab == 1)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.77,
                    child: ListView.builder(
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
                ),
              //! Invites Groups List
              if (model.selectedTab == 2)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.77,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return GroupsInviteTile(
                          adminName: "Tanzeel",
                          createdate: DateTime.now(),
                          groupName: "Scouts",
                          imagepath: AssetImages.sampleGroupImage,
                          onAddIconTap: () {},
                          onArrowIconTap: () {},
                          onMoreIconTap: () {},
                          invitedBy: 'Muazzam',
                          onAccept: () {},
                          onReject: () {},
                        );
                      },
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  //! Widgets ------------------------------------------------

  @override
  MyGroupsViewModel viewModelBuilder(BuildContext context) =>
      MyGroupsViewModel();

  @override
  void onViewModelReady(MyGroupsViewModel model) => model.init();
}
