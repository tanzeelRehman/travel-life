import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/group_join.dart';
import 'package:starter_app/src/base/enums/group_type.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/empty_state_widget.dart';
import 'package:starter_app/src/shared/loading_indicator.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/groups/groups_main/groups_main_view_model.dart';
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
            image: Image.asset(AssetImages.vehicleRegistrationBg).image,
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              titleText: 'Groups',
            ),
            VerticalSpacing(20.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 27.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: groupCard(
                            () {
                              model.navigateToMyGroups();
                            },
                            'My Groups',
                            AssetImages.myGroups,
                          ),
                        ),
                        HorizontalSpacing(10.w),
                        Expanded(
                          child: groupCard(
                            () {
                              model.navigateToGroupLists(GroupType.private);
                            },
                            'Private',
                            AssetImages.privateGroups,
                          ),
                        ),
                        HorizontalSpacing(10.w),
                        Expanded(
                          child: groupCard(
                            () {
                              model.navigateToGroupLists(GroupType.public);
                            },
                            'Public',
                            AssetImages.publicGroups,
                          ),
                        ),
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
                    Expanded(
                      child: model.isBusy
                          ? Center(
                              child: LoadingIndicator(
                                color: AppColors.appSkyBlue,
                              ),
                            )
                          : model.dataService.forYouGroups.isNotEmpty
                              ? ListView.builder(
                                  itemCount:
                                      model.dataService.forYouGroups.length,
                                  itemBuilder: (context, index) {
                                    final grp =
                                        model.dataService.forYouGroups[index];
                                    print('grp: ${grp.toString()}');
                                    return GroupsTile(
                                      group: grp,
                                      onAddIconTap: () {},
                                      onArrowIconTap: () {
                                        model.navigateToGroupJoin(
                                          (grp.isPublic ?? true)
                                              ? GroupJoin.join
                                              : GroupJoin.requestJoin,
                                          grp,
                                        );
                                      },
                                      onMoreIconTap: () {},
                                    );
                                  },
                                )
                              : Center(
                                  child: EmptyStateWidget(
                                    text: 'No suggested groups',
                                  ),
                                ),
                    )
                  ],
                ),
              ),
            )
          ],
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
          textAlign: TextAlign.center,
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
