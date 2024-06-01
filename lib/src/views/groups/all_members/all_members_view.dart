import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/models/see_all_members_user.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/empty_state_widget.dart';
import 'package:starter_app/src/shared/loading_indicator.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/groups/all_members/all_members_view_model.dart';

class AllMembersView extends StackedView<AllMembersViewModel> {
  final Group group;

  AllMembersView({required this.group});
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              titleText: !model.isGroupAdmin() ? 'All Members' : 'Add Members',
            ),
            VerticalSpacing(40.h),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 25.h),
                decoration: AppColors.groupCardsDecoration.copyWith(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                          if (model.isGroupAdmin() && !(group.isPublic ?? true))
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
                    if (model.isGroupAdmin() && !(group.isPublic ?? true))
                      SizedBox(
                        height: 15.h,
                      ),
                    Expanded(
                      // height: context.height * 0.73,
                      child: model.isBusy
                          ? Center(
                              child: LoadingIndicator(
                                color: AppColors.appSkyBlue,
                              ),
                            )
                          : model.members.isEmpty
                              ? EmptyStateWidget(
                                  text: 'No members found',
                                  color: AppColors.appSkyBlue,
                                )
                              : ListView.builder(
                                  itemCount: model.members.length,
                                  itemBuilder: (context, index) {
                                    final member = model.members[index];

                                    return GroupMemberTile(
                                      isAdmin:
                                          member.user?.id == group.admin?.id,
                                      isMe: member.user?.id ==
                                          model.supabaseAuthService.user?.id,
                                      member: member,
                                      onTap: () {
                                        model.navigateToMemberProfile(member);
                                      },
                                    );
                                  },
                                ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  AllMembersViewModel viewModelBuilder(BuildContext context) =>
      AllMembersViewModel();

  @override
  void onViewModelReady(AllMembersViewModel model) => model.init(group);

  // //! WIDGETS=========================================================
  // Widget groupMemberTile(BuildContext context, bool isAdmin, int index,
  //     AllMembersViewModel model) {
  //   return GestureDetector(
  //     onTap: () {
  //       model.navigateToMemberProfile();
  //     },
  //     child: Column(
  //       children: [
  //         Container(
  //           width: MediaQuery.of(context).size.width,
  //           color: Colors.grey.withOpacity(.5),
  //           height: 1,
  //         ),
  //         SizedBox(
  //           height: 25.h,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Row(
  //               children: [
  //                 CircleAvatar(
  //                   radius: 35.r,
  //                   backgroundImage: AssetImage(AssetImages.sampleUser),
  //                 ),
  //                 SizedBox(
  //                   width: 10.w,
  //                 ),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       'Tanzeel',
  //                       style: TextStyling.semiBold,
  //                     ),
  //                     Text(
  //                       'Joining Date: ${DateFormat.yMMMd().format(DateTime.now())} ',
  //                       style: TextStyling.thin,
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             isAdmin
  //                 ? Container(
  //                     padding: EdgeInsets.symmetric(
  //                         horizontal: 12.sp, vertical: 8.h),
  //                     decoration: BoxDecoration(
  //                       gradient: AppColors.mainButtonGradient,
  //                       borderRadius: BorderRadius.circular(25.r),
  //                     ),
  //                     child: Text(
  //                       'Admin',
  //                       style: TextStyling.bold,
  //                     ),
  //                   )
  //                 : Icon(
  //                     Icons.arrow_forward_ios,
  //                     color: Colors.white,
  //                     size: 20.sp,
  //                   )
  //           ],
  //         ),
  //         SizedBox(
  //           height: 25.h,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

class GroupMemberTile extends StatelessWidget {
  const GroupMemberTile({
    Key? key,
    required this.isAdmin,
    required this.isMe,
    required this.member,
    required this.onTap,
  }) : super(key: key);

  final bool isAdmin;
  final bool isMe;
  final SeeAllMembersUser member;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isMe ? null : onTap,
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
                  // CircleAvatar(
                  //   radius: 35.r,
                  //   backgroundImage: member.user?.avatar != null
                  //       ? CachedNetworkImage(url: member.user!.avatar!)
                  //       : AssetImage(AssetImages.sampleUser),
                  // ),
                  Container(
                    height: 55.h,
                    width: 55.h,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: member.user?.avatar != null
                        ? CachedNetworkImage(imageUrl: member.user!.avatar!)
                        : Image.asset(AssetImages.sampleUser),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member.user?.firstname ?? '',
                        style: TextStyling.semiBold,
                      ),
                      Text(
                        'Joining Date: ${member.dateJoined != null ? DateFormat.yMMMd().format(member.dateJoined!) : '----'} ',
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
                  : isMe
                      ? Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.sp, vertical: 8.h),
                          decoration: BoxDecoration(
                            gradient: AppColors.secondaryButtonGradient,
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: Text(
                            'You',
                            style: TextStyling.bold,
                          ),
                        )
                      : Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20.sp,
                        ),
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
