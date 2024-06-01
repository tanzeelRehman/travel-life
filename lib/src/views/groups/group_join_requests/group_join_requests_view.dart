import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/models/group_member.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/empty_state_widget.dart';
import 'package:starter_app/src/shared/loading_indicator.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/groups/group_join_requests/group_join_requests_view_model.dart';

class GroupJoinRequestsView extends StackedView<GroupJoinRequestsViewModel> {
  final Group group;
  GroupJoinRequestsView({required this.group});
  @override
  Widget builder(
      BuildContext context, GroupJoinRequestsViewModel model, Widget? child) {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              titleText: 'Join Requests',
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 40.h),
                  Expanded(
                    child: Container(
                      decoration: AppColors.groupCardsDecoration.copyWith(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.r),
                              topRight: Radius.circular(25.r))),
                      height: MediaQuery.of(context).size.height * 0.85,
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.only(left: 25.w, right: 15.w, top: 15.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${model.joinRequests.length} Requests',
                                style: TextStyling.bold,
                              ),
                              // Row(
                              //   children: [
                              //     Container(
                              //       height: 25.h,
                              //       width: 25.h,
                              //       decoration: BoxDecoration(
                              //           shape: BoxShape.circle,
                              //           gradient: AppColors.mainButtonGradient),
                              //       child: Icon(
                              //         Icons.add,
                              //         color: Colors.white,
                              //         size: 17.sp,
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 8.w,
                              //     ),
                              //     Text(
                              //       'Invite',
                              //       style: TextStyling.thin,
                              //     )
                              //   ],
                              // )
                            ],
                          ),
                          SizedBox(height: 15.h),
                          Expanded(
                            child: model.isBusy || model.joinRequestLoading
                                ? Center(
                                    child: LoadingIndicator(
                                      color: AppColors.appSkyBlue,
                                    ),
                                  )
                                : model.joinRequests.isEmpty
                                    ? Center(
                                        child: EmptyStateWidget(
                                          text: 'No Requests',
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: model.joinRequests.length,
                                        itemBuilder: (context, index) {
                                          final request =
                                              model.joinRequests[index];
                                          return JoinRequestTile(
                                            groupMember: request,
                                            onAccept: () {
                                              model.acceptJoinRequest(request);
                                            },
                                            onreject: () {
                                              model.rejectJoinRequest(request);
                                            },
                                          );
                                        },
                                      ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  GroupJoinRequestsViewModel viewModelBuilder(BuildContext context) =>
      GroupJoinRequestsViewModel();

  @override
  void onViewModelReady(GroupJoinRequestsViewModel model) => model.init(group);
}

class JoinRequestTile extends StatelessWidget {
  final GroupMember groupMember;
  final VoidCallback onreject;
  final VoidCallback onAccept;

  const JoinRequestTile({
    Key? key,
    required this.groupMember,
    required this.onreject,
    required this.onAccept,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
          children: [
            // CircleAvatar(
            //   radius: 35.r,
            //   backgroundImage: AssetImage(imagepath),
            // ),
            Container(
              height: 55.h,
              width: 55.h,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: groupMember.user?.avatar != null
                      ? CachedNetworkImageProvider(groupMember.user!.avatar!)
                      : Image.asset(AssetImages.defaultImage).image,
                ),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  groupMember.user?.firstname ?? '',
                  style: TextStyling.semiBold,
                ),
                Text(
                  groupMember.joinRequestTime != null
                      ? 'Requested on ${DateFormat('yMMMd').format(groupMember.joinRequestTime!)}'
                      : '----',
                  style: TextStyling.thin,
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 25.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onreject,
              child: Container(
                height: 50.h,
                width: MediaQuery.of(context).size.width * 0.4,
                alignment: Alignment.center,
                child: Text(
                  'Reject',
                  style: TextStyling.medium,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    gradient: AppColors.secondaryButtonGradient),
              ),
            ),
            GestureDetector(
              onTap: onAccept,
              child: Container(
                height: 50.h,
                width: MediaQuery.of(context).size.width * 0.4,
                alignment: Alignment.center,
                child: Text(
                  'Accept',
                  style: TextStyling.medium,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    gradient: AppColors.mainButtonGradient),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25.h,
        ),
      ],
    );
  }
}
