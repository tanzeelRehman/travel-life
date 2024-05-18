import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/groups/add_members/add_member_view_model.dart';
import 'package:starter_app/src/views/groups/widgets/add_member_searchbar.dart';
import 'package:starter_app/src/views/groups/widgets/add_member_tile.dart';

class AddMemberView extends StackedView<AddMemberViewModel> {
  final Group group;

  AddMemberView({required this.group});

  @override
  Widget builder(
      BuildContext context, AddMemberViewModel model, Widget? child) {
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
              titleText: 'Add Members',
            ),
            VerticalSpacing(30.h),
            Expanded(
              child: Container(
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
                  children: [
                    AddMemberSearchBar(
                      seacrchController: model.searchController,
                      onSearch: () {
                        model.filterMembersList(model.searchController.text);
                      },
                      onChanged: (query) {
                        model.filterMembersList(query);
                      },
                    ),
                    if (model.selectedMembersList.isNotEmpty) ...[
                      VerticalSpacing(20.h),
                      SizedBox(
                        height: 35,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: model.selectedMembersList.length,
                          itemBuilder: (context, index) {
                            return selectedMemberChip(model, index);
                          },
                        ),
                      ),
                      VerticalSpacing(10.h),
                    ],
                    if (model.selectedMembersList.isEmpty)
                      VerticalSpacing(10.h),
                    Expanded(
                      child: ListView.builder(
                        itemCount: model.filterdMembersList.length,
                        itemBuilder: (context, index) {
                          return AddMemberTile(
                            user: model.filterdMembersList[index],
                            model: model,
                          );
                        },
                      ),
                    ),
                    if (model.selectedMembersList.isNotEmpty) ...[
                      SizedBox(height: 15.h),
                      GestureDetector(
                        onTap: () {
                          model.sendInvite();
                        },
                        child: Container(
                          height: 56.h,
                          alignment: Alignment.center,
                          width: context.width * 0.88,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            gradient: AppColors.mainButtonGradient,
                          ),
                          child: Text(
                            'Send',
                            style: TextStyling.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  //! WIDGETS=========================================================

  Widget selectedMemberChip(AddMemberViewModel model, int index) {
    return GestureDetector(
      onTap: () {
        model.removeMemberToList(model.selectedMembersList[index]);
      },
      child: Container(
        height: 25.h,
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            gradient: AppColors.mainButtonGradient),
        child: Row(
          children: [
            Text(
              model.selectedMembersList[index].firstname ?? '',
              style: TextStyling.medium,
            ),
            SizedBox(
              width: 15.w,
            ),
            Icon(
              Icons.cancel_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  @override
  AddMemberViewModel viewModelBuilder(BuildContext context) =>
      AddMemberViewModel();

  @override
  void onViewModelReady(AddMemberViewModel model) => model.init(group);
}
