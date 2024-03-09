import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/home/home_view_model.dart';

class HomeView extends StackedView<HomeViewModel> {
  @override
  Widget builder(BuildContext context, HomeViewModel model, Widget? child) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset(AssetImages.homeBikeBg).image,
            alignment: Alignment.topLeft,
            fit: BoxFit.none,
          ),
        ),
        child: Container(
          width: context.screenSize().width,
          height: context.screenSize().height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset(AssetImages.mainBg).image,
              fit: BoxFit.cover,
              opacity: 0.5,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 16.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpacing(40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello,',
                            style: TextStyling.medium.copyWith(
                              fontSize: 18.sp,
                            ),
                          ),
                          Text(
                            model.supabaseAuthService.user?.firstname != null
                                ? "${model.supabaseAuthService.user?.firstname}" +
                                    (model.supabaseAuthService.user?.lastname !=
                                            null
                                        ? "\n${model.supabaseAuthService.user?.lastname}"
                                        : "")
                                : '',
                            style: TextStyling.semiBold.copyWith(
                              fontSize: 35.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ProfileAvatar(
                      onClickProfile: model.onClickProfile,
                      avatarUrl: model.supabaseAuthService.user?.avatar,
                    ),
                  ],
                ),
                VerticalSpacing(50.h), //80.
                Row(
                  children: [
                    Expanded(
                      child: HomeButton(
                        buttonText: 'Trip Planner',
                        buttonTextColor: AppColors.tripPlannerColor,
                        iconGradeint: AppColors.tripPlannerGradient,
                        iconPath: AssetIcons.tripPlannerButtonIcon,
                        onTap: () {
                          // model.navigateToTripPlanner();
                        },
                      ),
                    ),
                    HorizontalSpacing(24.w),
                    Expanded(
                      child: HomeButton(
                        buttonText: 'Vehicle Registration',
                        buttonTextColor: AppColors.vehicleRegistrationColor,
                        iconPath: AssetIcons.vehicleRegistrationButtonIcon,
                        iconGradeint: AppColors.vehicleRegistrationGradient,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                VerticalSpacing(24.h),
                Row(
                  children: [
                    Expanded(
                      child: HomeButton(
                        buttonText: 'Groups',
                        buttonTextColor: AppColors.groupsColor,
                        iconGradeint: AppColors.groupsGradient,
                        iconPath: AssetIcons.groupsButtonIcon,
                        onTap: () {},
                      ),
                    ),
                    HorizontalSpacing(24.w),
                    Expanded(
                      child: HomeButton(
                        buttonText: 'Money Manager',
                        buttonTextColor: AppColors.moneyManagerColor,
                        iconPath: AssetIcons.moneyManagerButtonIcon,
                        iconGradeint: AppColors.moneyManagerGradient,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                VerticalSpacing(24.h),
                Row(
                  children: [
                    Expanded(
                      child: HomeButton(
                        buttonText: 'Chats',
                        buttonTextColor: AppColors.chatsColor,
                        iconGradeint: AppColors.chatsGradient,
                        iconPath: AssetIcons.chatsButtonIcon,
                        onTap: () {},
                      ),
                    ),
                    HorizontalSpacing(24.w),
                    Expanded(
                      child: HomeButton(
                        buttonText: 'Event Money Manager',
                        buttonTextColor: AppColors.eventMoneyManagerColor,
                        iconPath: AssetIcons.eventMoneyMngButtonIcon,
                        iconGradeint: AppColors.eventMoneyManagerGradient,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel model) => model.init();
}

class HomeButton extends StatelessWidget {
  const HomeButton({
    Key? key,
    required this.buttonText,
    required this.buttonTextColor,
    required this.iconPath,
    required this.iconGradeint,
    required this.onTap,
  }) : super(key: key);

  final String buttonText;
  final Color buttonTextColor;
  final String iconPath;
  final Gradient iconGradeint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.grey.withOpacity(0.1),
            width: 2,
          ),
          gradient: AppColors.homeButtonGradient,
          borderRadius: BorderRadius.circular(
            20.r,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 3,
              sigmaY: 3,
            ),
            child: Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    buttonText,
                    style: TextStyling.bold.copyWith(
                      color: buttonTextColor,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 70.h,
                      width: 70.h,
                      padding: EdgeInsets.all(18.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: AppColors.homeScreenButtonIconsBoxShadows,
                        gradient: iconGradeint,
                      ),
                      child: SvgPicture.asset(
                        iconPath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    Key? key,
    required this.onClickProfile,
    this.avatarUrl,
  }) : super(key: key);

  final VoidCallback onClickProfile;

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClickProfile,
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.appSkyBlue,
            width: 1,
          ),
          shape: BoxShape.circle,
        ),
        child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.appSkyBlue,
              width: 1,
            ),
            shape: BoxShape.circle,
          ),
          child: SizedBox(
            height: 70.w,
            width: 70.w,
            child: CircleAvatar(
              backgroundImage: avatarUrl != null
                  ? CachedNetworkImageProvider(avatarUrl!)
                  : Image.asset(AssetImages.imagesPlaceholder250).image,
            ),
          ),
        ),
      ),
    );
  }
}

class CircleBlurPainter extends CustomPainter {
  CircleBlurPainter({required this.circleWidth, required this.blurSigma});

  double circleWidth;
  double blurSigma;

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = Colors.lightBlue
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
