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
import 'package:starter_app/src/shared/vehicle_registration_textfield.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/groups/models/add_member_view_model.dart';
import 'package:starter_app/src/views/groups/models/all_members_view_model.dart';
import 'package:starter_app/src/views/groups/models/groups_lists_view_model.dart';
import 'package:starter_app/src/views/groups/models/groups_main_view_model.dart';
import 'package:starter_app/src/views/groups/widgets/add_member_searchbar.dart';
import 'package:starter_app/src/views/groups/widgets/add_member_tile.dart';
import 'package:starter_app/src/views/groups/widgets/group_tile_widget.dart';

class AllMembersView extends StackedView<AllMembersViewModel> {
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
        child: Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                titleText: 'Add Members',
              ),
              Spacer(),
              Container(
                height: context.height * 0.85,
                width: context.width,
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 25.h),
                decoration: AppColors.groupCardsDecoration.copyWith(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //! WIDGETS=========================================================

  @override
  AllMembersViewModel viewModelBuilder(BuildContext context) =>
      AllMembersViewModel();

  @override
  void onViewModelReady(AllMembersViewModel model) => model.init();
}
