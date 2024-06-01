import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/groups/invite_middle_screen/invite_middle_screen_view_model.dart';

class InviteMiddleScreenView extends StackedView<InviteMiddleScreenViewModel> {
  final Group group;
  InviteMiddleScreenView({required this.group});
  @override
  Widget builder(
      BuildContext context, InviteMiddleScreenViewModel model, Widget? child) {
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
                titleText: 'Share Group',
              ),
              SizedBox(
                height: Get.height * 0.8,
                width: Get.width,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 27.w, vertical: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // height: Get.height * 0.6,
                        width: Get.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          border: AppColors.gradientBordersDecoration,
                          color: AppColors.appDarkBlue,
                        ),
                        padding: EdgeInsets.all(15.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Invite Friends',
                              style: TextStyling.bold.copyWith(fontSize: 25.sp),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.sp),
                              child: Image.asset(AssetImages.share),
                            ),
                            Text(
                              'Want to invite others to join this group',
                              style: TextStyling.thin.copyWith(fontSize: 15.sp),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                model.navigateToAddMembersScrren();
                              },
                              child: Container(
                                height: 55.h,
                                width: Get.width * 0.65,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    gradient: AppColors.mainButtonGradient,
                                    borderRadius: BorderRadius.circular(15.r)),
                                child: Text(
                                  'Search by name',
                                  style: TextStyling.semiBold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  InviteMiddleScreenViewModel viewModelBuilder(BuildContext context) =>
      InviteMiddleScreenViewModel();

  @override
  void onViewModelReady(InviteMiddleScreenViewModel model) => model.init(group);
}
