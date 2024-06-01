import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/see_all_members_user.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/profile_textfield.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/views/dialogs/groups_dialog/remove_person_dialog.dart';
import 'package:starter_app/src/views/groups/group_member_profile/group_member_profile_view_model.dart';

class GroupMemberProfileView extends StackedView<GroupMemberProfileViewModel> {
  final SeeAllMembersUser member;
  final bool isGroupAdmin;

  const GroupMemberProfileView({
    Key? key,
    required this.member,
    required this.isGroupAdmin,
  }) : super(key: key);

  @override
  Widget builder(
      BuildContext context, GroupMemberProfileViewModel model, Widget? child) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          width: context.screenSize().width,
          height: context.screenSize().height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset(
                AssetImages.mainBg,
                height: context.screenSize().height,
                width: context.screenSize().width,
              ).image,
              fit: BoxFit.cover,
              opacity: 0.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomAppBar(
                titleText: 'Profile Info',
              ),
              VerticalSpacing(20.h),
              // CircleAvatar(
              //   radius: 75.r,
              //   backgroundImage: AssetImage(AssetImages.sampleUser),
              // ),
              Container(
                height: 150.h,
                width: 150.h,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: member.user?.avatar != null
                    ? CachedNetworkImage(
                        imageUrl: member.user!.avatar!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        AssetImages.defaultUser,
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  children: [
                    ProfileTextField(
                      controller: model.nameController,
                      title: 'Name',
                      suffixIcon: Icon(
                        Icons.person_2_outlined,
                        color: Colors.white.withOpacity(.5),
                      ),
                      readOnly: true,
                    ),
                    VerticalSpacing(15.h),
                    ProfileTextField(
                      controller: model.emailController,
                      title: 'Email',
                      suffixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.white.withOpacity(.5),
                      ),
                      readOnly: true,
                    ),
                    VerticalSpacing(15.h),
                    ProfileTextField(
                      controller: model.dateOfJoinController,
                      title: 'Date of Join',
                      suffixIcon: Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.white.withOpacity(.5),
                      ),
                      readOnly: true,
                    ),
                    // TODO: only for group admin
                    if (isGroupAdmin) ...[
                      SizedBox(
                        height: 50.h,
                      ),
                      MainButton(
                        buttonText: 'Remove',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                child: RemovePersonDialog(
                                  name: member.user?.firstname ?? '',
                                  no: () {
                                    Navigator.pop(context);
                                  },
                                  yes: () {
                                    model.onRemoveGroupMember();
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            },
                          );
                        },
                        isLoading: model.isBusy,
                        btnColor: Colors.red,
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     showDialog(
                      //       context: context,
                      //       builder: (context) {
                      //         return Dialog(
                      //           backgroundColor: Colors.transparent,
                      //           child: RemovePersonDialog(
                      //             name: member.user?.firstname ?? '',
                      //             no: () {
                      //               Navigator.pop(context);
                      //             },
                      //             yes: () {
                      //               model.onRemoveGroupMember();
                      //             },
                      //           ),
                      //         );
                      //       },
                      //     );
                      //   },
                      //   child: Container(
                      //     height: 55.h,
                      //     alignment: Alignment.center,
                      //     width: MediaQuery.of(context).size.width,
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(12.r),
                      //         color: Colors.red,
                      //         border: AppColors.gradientBordersDecoration),
                      //     child: Text(
                      //       'Remove',
                      //       style: TextStyling.semiBold,
                      //     ),
                      //   ),
                      // ),
                    ],
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
  GroupMemberProfileViewModel viewModelBuilder(BuildContext context) =>
      GroupMemberProfileViewModel();

  @override
  void onViewModelReady(GroupMemberProfileViewModel model) =>
      model.init(member);
}
