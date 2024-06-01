import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/group_join.dart';
import 'package:starter_app/src/base/enums/group_type.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/empty_state_widget.dart';
import 'package:starter_app/src/shared/loading_indicator.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/views/groups/groups_lists/groups_lists_view_model.dart';
import 'package:starter_app/src/views/groups/widgets/group_tile_widget.dart';

class GroupsListsView extends StackedView<GroupsListsViewModel> {
  final GroupType groupType;

  GroupsListsView(this.groupType);
  @override
  Widget builder(
      BuildContext context, GroupsListsViewModel model, Widget? child) {
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
              titleText: '${getReadableGroupType(groupType)} Groups',
            ),
            if (groupType == GroupType.private)
              model.isBusy
                  ? Expanded(
                      child: Center(
                        child: LoadingIndicator(
                          color: AppColors.appSkyBlue,
                        ),
                      ),
                    )
                  : model.dataService.privateGroups.isEmpty
                      ? Expanded(
                          child: Center(
                            child: EmptyStateWidget(
                              text:
                                  'No ${getReadableGroupType(groupType)} Groups Available',
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: 27.w,
                              vertical: 20.h,
                            ),
                            itemCount: model.dataService.privateGroups.length,
                            itemBuilder: (context, index) {
                              final grp =
                                  model.dataService.privateGroups[index];
                              return GroupsTile(
                                group: grp,
                                onAddIconTap: () {},
                                onArrowIconTap: () {
                                  NavService.navigateToGroupJoinScreen(
                                    groupJoin: groupType == GroupType.public
                                        ? GroupJoin.join
                                        : GroupJoin.requestJoin,
                                    group: grp,
                                  );
                                },
                                onMoreIconTap: () {},
                              );
                            },
                          ),
                        ),
            if (groupType == GroupType.public)
              model.isBusy
                  ? Expanded(
                      child: Center(
                        child: LoadingIndicator(
                          color: AppColors.appSkyBlue,
                        ),
                      ),
                    )
                  : model.dataService.publicGroups.isEmpty
                      ? Expanded(
                          child: Center(
                            child: EmptyStateWidget(
                              text:
                                  'No ${getReadableGroupType(groupType)} Groups Available',
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: 27.w,
                              vertical: 20.h,
                            ),
                            itemCount: model.dataService.publicGroups.length,
                            itemBuilder: (context, index) {
                              final grp = model.dataService.publicGroups[index];
                              return GroupsTile(
                                group: grp,
                                onAddIconTap: () {},
                                onArrowIconTap: () {
                                  NavService.navigateToGroupJoinScreen(
                                    groupJoin: groupType == GroupType.public
                                        ? GroupJoin.join
                                        : GroupJoin.requestJoin,
                                    group: grp,
                                  );
                                },
                                onMoreIconTap: () {},
                              );
                            },
                          ),
                        ),
          ],
        ),
      ),
    );
  }

  @override
  GroupsListsViewModel viewModelBuilder(BuildContext context) =>
      GroupsListsViewModel();

  @override
  void onViewModelReady(GroupsListsViewModel model) => model.init(groupType);
}
