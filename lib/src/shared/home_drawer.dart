import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/profile_avatar.dart';
import 'package:starter_app/src/shared/profile_textfield.dart';
import 'package:starter_app/src/shared/regular_textfield.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/home/home_view_model.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer(this.model);
  final HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    List<DrawerModel> drawerList = [
      DrawerModel(
        title: "Feedback",
        images: AssetIcons.drawerFeedbackIcon,
      ),
    ];
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.70 + 30.w,
      child: Stack(
        children: [
          Drawer(
            width: MediaQuery.of(context).size.width * 0.70,
            backgroundColor: AppColors.appFaddedBlue,
            child: ListView(
              children: [
                SizedBox(height: 30.h),
                InkWell(
                  onTap: model.onClickProfile,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, bottom: 10.h, top: 10.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfileAvatar(
                          onClickProfile: () {
                            model.onClickProfile();
                          },
                          avatarUrl: model.supabaseAuthService.user?.avatar,
                          heightAndWidth: 50.w,
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.supabaseAuthService.user?.firstname != null
                                  ? "${model.supabaseAuthService.user?.firstname}" +
                                      (model.supabaseAuthService.user
                                                  ?.lastname !=
                                              null
                                          ? " ${model.supabaseAuthService.user?.lastname}"
                                          : "")
                                  : '',
                              style: TextStyling.regular.copyWith(
                                color: AppColors.white,
                                fontSize: 16.sp,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              model.supabaseAuthService.user?.alias ?? "",
                              style: TextStyling.regular.copyWith(
                                color: AppColors.appSkyBlue,
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Divider(
                  color: AppColors.white,
                  indent: 30.w,
                  endIndent: 30.w,
                ),
                SizedBox(height: 20.h),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: drawerList.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      final drawerItem = drawerList[index];
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DrawerTile(
                              drawerItem: drawerItem,
                              // isSelected: model.selectedDrawerIndex == index,
                              isSelected: true,
                              onTap: () {
                                model.selectedDrawerIndex = index;
                                model.selectedMenu = index;
                                model.notifyListeners();
                                // model.selectedDrawerIndex = -1;
                                // model.selectedMenu = -1;
                                switch (model.selectedMenu) {
                                  case 0:
                                    // model.scaffoldKey.currentState!
                                    //     .closeDrawer();
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => FeedbackDialog(
                                        model: model,
                                      ),
                                    );

                                    break;
                                  // case 1:
                                  //   //Navigating to Sales Order
                                  //   Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               PlaceOrderView()));
                                  //   break;
                                  // case 2:
                                  //   Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               PaymentRecoveryView()));
                                  //   break;
                                  // case 3:
                                  //   //Navigating to Shop List
                                  //   Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               ShopListView()));
                                  //   break;
                                  // case 4:
                                  //   //Navigating to Product List
                                  //   Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               ProductListView()));
                                  //   break;
                                  // case 5:
                                  //   //Navigating to Shop Visit
                                  //   Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               VisitShopView()));
                                  //   break;
                                  // case 6:
                                  //   //Navigating to Dashboard (Because No Screen for Reports)
                                  //   Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //           builder: (context) => HomeView()));
                                  //   break;
                                  // case 7:
                                  //   //Navigating to Attendance List
                                  //   Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               TimeSheetView()));
                                  //   break;
                                }
                              }),
                        ],
                      );
                    }),
                SizedBox(height: 20.h),
                // Divider(
                //   color: AppColors.white,
                //   indent: 30.w,
                //   endIndent: 30.w,
                // ),
                // SizedBox(height: 20.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DrawerTile(
                      isSelected: true,
                      drawerItem: DrawerModel(
                        title: "Logout",
                        // images: Assets.imagesAttendance,
                        images: AssetIcons.logoutIcon,
                      ),
                      onTap: model.onClickLogout,
                      selectedColor: Colors.redAccent,
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: context.screenSize().height * 0.45,
            // bottom: 0,
            right: 0.w,
            child: GestureDetector(
              onTap: model.scaffoldKey.currentState!.closeDrawer,
              child: Container(
                height: 30.w,
                width: 30.w,
                decoration: BoxDecoration(
                    color: AppColors.appSkyBlue,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(6.r),
                        bottomRight: Radius.circular(6.r))),
                child: Icon(
                  Icons.close,
                  color: AppColors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key? key,
    required this.drawerItem,
    required this.onTap,
    required this.isSelected,
    this.selectedColor,
    this.iconColor,
  }) : super(key: key);

  final DrawerModel drawerItem;
  final VoidCallback onTap;
  final bool isSelected;
  final Color? selectedColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        // width: 180.w,
        decoration: BoxDecoration(
          borderRadius: isSelected
              ? BorderRadius.only(
                  topRight: Radius.circular(25.r),
                  bottomRight: Radius.circular(25.r))
              : null,
          color: isSelected ? (selectedColor ?? AppColors.appSkyBlue) : null,
        ),
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 7.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              drawerItem.images,
              height: 24.w,
              width: 24.w,
              color: iconColor ?? Colors.white,
            ),
            SizedBox(width: 20.w),
            Text(
              drawerItem.title,
              style: TextStyling.regular.copyWith(
                color: AppColors.white,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerModel {
  final String title;
  final String images;

  DrawerModel({required this.title, required this.images});
}

class FeedbackDialog extends StatelessWidget {
  const FeedbackDialog({
    Key? key,
    required this.model,
  }) : super(key: key);

  final HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Dialog(
          // backgroundColor: AppColors.appFaddedBlue,
          backgroundColor: AppColors.appDarkBlue,

          elevation: 0,
          child: Container(
            width: context.screenSize().width * 0.8,
            constraints: BoxConstraints(
              maxHeight: context.screenSize().height * 0.6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              // color: AppColors.appFaddedBlue,
              color: AppColors.appDarkBlue,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 24.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Feedback Form',
                    style: TextStyling.bold.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                VerticalSpacing(20.h),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    'Subject',
                    style: TextStyling.regular.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                VerticalSpacing(5.h),
                RegularTextFeild(
                  hintText: 'subject',
                  controller: model.subjectController,
                ),
                VerticalSpacing(16.h),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    'Message',
                    style: TextStyling.regular.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                VerticalSpacing(5.h),
                SizedBox(
                  height: 120.h,
                  child: RegularTextFeild(
                    hintText: 'write your feedback',
                    controller: model.messageController,
                    isMultiLine: true,
                  ),
                ),
                VerticalSpacing(20.h),
                Row(
                  children: [
                    Expanded(
                      child: MainButton(
                        height: 40,
                        onPressed: () {
                          model.onClickSendFeedback();
                          Navigator.pop(context);
                        },
                        buttonText: 'Send',
                        fontSize: 12.sp,
                        isLoading: false,
                      ),
                    ),
                    HorizontalSpacing(16.w),
                    Expanded(
                      child: MainButton(
                        height: 40,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        buttonText: 'Cancel',
                        fontSize: 12.sp,
                        gradient: AppColors.logoutButtonGradient,
                        isLoading: false,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
