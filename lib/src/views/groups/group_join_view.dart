// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/group_join.dart';
import 'package:starter_app/src/base/enums/group_type.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/vehicle_registration_textfield.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/groups/models/group_join_view_model.dart';
import 'package:starter_app/src/views/groups/models/groups_lists_view_model.dart';
import 'package:starter_app/src/views/groups/models/groups_main_view_model.dart';
import 'package:starter_app/src/views/groups/widgets/group_tile_widget.dart';

class GroupJoinView extends StackedView<GroupJoinViewModel> {
  final GroupJoin groupJoin;
  final String groupName;

  GroupJoinView(this.groupJoin, this.groupName);
  @override
  Widget builder(
      BuildContext context, GroupJoinViewModel model, Widget? child) {
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
          padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 12.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                titleText: groupName,
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
                            child: Image.asset(
                              AssetImages.sampleGroupImage,
                              fit: BoxFit.fitWidth,
                            )),
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
                              groupName,
                              style: TextStyling.bold.copyWith(fontSize: 25.sp),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Admin: ",
                                  style: TextStyling.thin,
                                ),
                                Text(
                                  'Tanzeel',
                                  style: TextStyling.semiBold,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          DateFormat.yMMMd().format(DateTime.now()),
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
                            Text('13', style: TextStyling.thin),
                            Text(' Total Members', style: TextStyling.thin)
                          ],
                        ),
                        Text('See all',
                            style: TextStyling.thin.copyWith(
                                color: AppColors.appSkyBlue,
                                decoration: TextDecoration.underline))
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
                    if (groupJoin == GroupJoin.join ||
                        groupJoin == GroupJoin.requestJoin)
                      Container(
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
  void onViewModelReady(GroupJoinViewModel model) => model.init();
}
