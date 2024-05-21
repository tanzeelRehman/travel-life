import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/group_join.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/vehicle_registration_textfield.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/groups/group_join/group_join_view_model.dart';

//TODO: add total members count here as well like in group main screen.
class GroupJoinView extends StackedView<GroupJoinViewModel> {
  final GroupJoin groupJoin;
  final Group group;

  GroupJoinView(this.groupJoin, this.group);
  @override
  Widget builder(
    BuildContext context,
    GroupJoinViewModel model,
    Widget? child,
  ) {
    print('create at is ${group.createdAt}');
    // print(group.createdAt);
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
          padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                titleText: group.name ?? '',
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.sp),
                            border: AppColors.gradientBordersDecoration),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          child: group.groupImage != null
                              ? CachedNetworkImage(
                                  imageUrl: group.groupImage!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  AssetImages.defaultImage,
                                  fit: BoxFit.fitHeight,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              group.name ?? '',
                              style: TextStyling.bold.copyWith(fontSize: 25.sp),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Admin: ",
                                  style: TextStyling.thin,
                                ),
                                Text(
                                  group.admin?.firstname ?? '',
                                  style: TextStyling.semiBold,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          group.createdAt != null
                              ? DateFormat('yMMMd').format(group.createdAt!)
                              : '----',
                          style: TextStyling.thin,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(model.totalMembers.toString(),
                                style: TextStyling.thin),
                            Text(' Total Members', style: TextStyling.thin)
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    VehicleRegistrationTextField(
                      svgIconPath: AssetIcons.tfDescription,
                      labelText: 'Group Description & Rules',
                      height: 180,
                      multiline: true,
                      readOnly: true,
                      controller: model.groupDescription,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    if (groupJoin == GroupJoin.join ||
                        groupJoin == GroupJoin.requestJoin)
                      GestureDetector(
                        onTap: () {
                          model.onClickJoinOrRequestJoin(groupJoin);
                        },
                        child: Container(
                          height: 55.h,
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              gradient: AppColors.mainButtonGradient),
                          child: Text(
                            getReadableGroupJoinType(groupJoin),
                            style: TextStyling.semiBold,
                          ),
                        ),
                      ),
                    if (groupJoin == GroupJoin.leave)
                      GestureDetector(
                        onTap: () {
                          model.onGroupLeave();
                        },
                        child: Container(
                          height: 55.h,
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: Colors.red,
                              border: AppColors.gradientBordersDecoration),
                          child: Text(
                            getReadableGroupJoinType(groupJoin),
                            style: TextStyling.semiBold,
                          ),
                        ),
                      ),
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
  GroupJoinViewModel viewModelBuilder(BuildContext context) =>
      GroupJoinViewModel();

  @override
  void onViewModelReady(GroupJoinViewModel model) => model.init(group);
}
