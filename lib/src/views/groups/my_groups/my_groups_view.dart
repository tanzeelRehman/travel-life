import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:stacked/stacked.dart';

import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/custom_tab.dart';
import 'package:starter_app/src/shared/empty_state_widget.dart';
import 'package:starter_app/src/shared/loading_indicator.dart';
import 'package:starter_app/src/shared/main_floating_action_button.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/shared/tab_switcher_widget.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/groups/my_groups/my_groups_view_model.dart';
import 'package:starter_app/src/views/groups/widgets/group_tile_widget.dart';
import 'package:starter_app/src/views/groups/widgets/groups_card.dart';
import 'package:starter_app/src/views/groups/widgets/groups_invite_tile_widget.dart';

class MyGroupsView extends StackedView<MyGroupsViewModel> {
  @override
  Widget builder(BuildContext context, MyGroupsViewModel model, Widget? child) {
    return Scaffold(
      floatingActionButton: MainFloatingActionButton(
        onTap: model.navigateToGroupAddPage,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                  count: model.dataService.myGroups.length,
                  title: 'My Groups',
                  onTap: () {
                    model.onChangeTab(0);
                  },
                  isSelected: model.selectedTab == 0,
                ),
                CustomTab(
                  count: model.dataService.joinedGroups.length,
                  title: 'Joined Groups',
                  onTap: () {
                    model.onChangeTab(1);
                  },
                  isSelected: model.selectedTab == 1,
                ),
                CustomTab(
                  count: model.dataService.invites.length,
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
            if (model.selectedTab == 0) ...[
              model.myGroupsLoading
                  ? Expanded(
                      child: Center(
                        child: LoadingIndicator(
                          color: AppColors.appSkyBlueLight,
                        ),
                      ),
                    )
                  : model.dataService.myGroups.isEmpty
                      ? Expanded(
                          child: Center(
                            child: EmptyStateWidget(
                              text:
                                  'You have not created any group yet, please tap on (+) button to create one',
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            itemCount: model.dataService.myGroups.length,
                            itemBuilder: (context, index) {
                              final grp = model.dataService.myGroups[index];
                              return Groupscard(
                                group: grp,
                                onTap: () {
                                  model.navigateToGroupsHome(grp);
                                },
                                onDelete: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      // print(grp.isEnabled);
                                      return DisableGroupDialog(
                                        // isVehicleEnabled: grp.isEnabled,
                                        isGroupEnabled: grp.isEnabled,
                                        onClickYes: () {
                                          print(grp.isEnabled);
                                          model.onDisableGroup(
                                            grp.id!,
                                            !(grp.isEnabled!),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                                onEditDetailstap: () {
                                  model.navigateToGroupEditPage(grp);
                                },
                                onMoreIconTap: () {},
                                onSeeAllMembersTap: () {},
                              );
                            },
                          ),
                        ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // //TODO: change this with floating action button
              // SizedBox(
              //   width: Get.width,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       GestureDetector(
              //         onTap: () {
              //           NavService.navigateToGroupCreateScreen(
              //               groupAction: GroupAction.add);
              //         },
              //         child: Container(
              //           alignment: Alignment.center,
              //           height: 55.h,
              //           width: Get.width * 0.9,
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(15.r),
              //               gradient: AppColors.mainButtonGradient),
              //           child: Text(
              //             'Create new group',
              //             style: TextStyling.bold,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
            ],
            //! Joined Groups List
            if (model.selectedTab == 1)
              model.joinedGroupsLoading
                  ? Expanded(
                      child: Center(
                        child: LoadingIndicator(
                          color: AppColors.appSkyBlueLight,
                        ),
                      ),
                    )
                  : model.dataService.joinedGroups.isEmpty
                      ? Expanded(
                          child: Center(
                            child: EmptyStateWidget(
                              text: 'You have not jonined any groups',
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            itemCount: model.dataService.joinedGroups.length,
                            itemBuilder: (context, index) {
                              final grp = model.dataService.joinedGroups[index];
                              return GroupsTile(
                                group: grp,
                                onAddIconTap: () {},
                                onArrowIconTap: () {
                                  print('tapp');
                                  model.navigateToGroupsHome(grp);
                                },
                                onMoreIconTap: () {},
                              );
                            },
                          ),
                        ),

            //! Invites Groups List
            if (model.selectedTab == 2)
              model.invitesLoading
                  ? Expanded(
                      child: Center(
                        child: LoadingIndicator(
                          color: AppColors.appSkyBlueLight,
                        ),
                      ),
                    )
                  : model.dataService.invites.isEmpty
                      ? Expanded(
                          child: Center(
                            child: EmptyStateWidget(
                              text: 'No groups invites',
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            itemCount: model.dataService.invites.length,
                            itemBuilder: (context, index) {
                              final invitedGroup =
                                  model.dataService.invites[index];
                              return GroupsInviteTile(
                                isButtonLoading: model.isBusy,
                                invitedGroup: invitedGroup,
                                onAddIconTap: () {},
                                onArrowIconTap: () {
                                  model.onOpenInviteGroupDetail(invitedGroup);
                                },
                                onMoreIconTap: () {},
                                onAccept: () {
                                  print('id is: ${invitedGroup.groupMemberId}');

                                  model.onClickAcceptInvite(
                                      invitedGroup.groupMemberId!);
                                },
                                onReject: () {
                                  print('id is: ${invitedGroup.groupMemberId}');
                                  model.onClickRejectInvite(
                                    invitedGroup.groupMemberId!,
                                  );
                                },
                              );
                            },
                          ),
                        )
          ],
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

class DisableGroupDialog extends StatelessWidget {
  const DisableGroupDialog({
    Key? key,
    required this.isGroupEnabled,
    required this.onClickYes,
  }) : super(key: key);

  final bool? isGroupEnabled;
  final VoidCallback onClickYes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.appDarkBlue,
      insetPadding: EdgeInsets.only(left: 10.0, right: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      title: Text(
        (isGroupEnabled ?? true) ? 'Disable Group' : 'Enable Group',
        textAlign: TextAlign.center,
        style: TextStyling.medium.copyWith(
          fontSize: 16.sp,
        ),
      ),
      content: Text(
        (isGroupEnabled ?? true)
            ? 'Are you sure you want to disable group?'
            : 'Are you sure you want to enable group?',
        style: TextStyling.thin.copyWith(fontSize: 12.sp),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                onClickYes();
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                height: 40.0.h,
                width: 70.0.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: AppColors.appSkyBlue,
                ),
                child: Center(
                  child: Text(
                    "Yes",
                    style: TextStyling.regular.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
            HorizontalSpacing(15.w),
            GestureDetector(
              onTap: () {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                height: 40.0.h,
                width: 70.0.w,
                decoration: BoxDecoration(
                  color: AppColors.appFaddedBlue,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: Text(
                    "No",
                    style: TextStyling.regular.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        VerticalSpacing(10),
      ],
    );
  }
}
