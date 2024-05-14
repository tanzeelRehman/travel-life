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
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/groups/group_join_requests/group_join_requests_view_model.dart';
import 'package:starter_app/src/views/groups/groups_lists/groups_lists_view_model.dart';
import 'package:starter_app/src/views/groups/groups_main/groups_main_view_model.dart';
import 'package:starter_app/src/views/groups/widgets/group_tile_widget.dart';

class GroupJoinRequestsView extends StackedView<GroupJoinRequestsViewModel> {
  GroupJoinRequestsView();
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
        child: Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                titleText: 'Join Requests',
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
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
                              '13 Requests',
                              style: TextStyling.bold,
                            ),
                            Row(
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
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return JoinRequestTile(
                                imagepath: AssetImages.sampleUser,
                                days: '3',
                                name: 'Muazzam',
                                onAccept: () {},
                                onreject: () {},
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  GroupJoinRequestsViewModel viewModelBuilder(BuildContext context) =>
      GroupJoinRequestsViewModel();

  @override
  void onViewModelReady(GroupJoinRequestsViewModel model) => model.init();
}

class JoinRequestTile extends StatelessWidget {
  final String imagepath;
  final String name;
  final String days;
  final Function() onreject;
  final Function() onAccept;

  const JoinRequestTile(
      {Key? key,
      required this.imagepath,
      required this.name,
      required this.days,
      required this.onreject,
      required this.onAccept})
      : super(key: key);

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
            CircleAvatar(
              radius: 35.r,
              backgroundImage: AssetImage(imagepath),
            ),
            SizedBox(
              width: 20.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyling.semiBold,
                ),
                Text(
                  '$days days ago',
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
