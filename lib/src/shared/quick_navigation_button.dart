import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class QuickNavigationButton extends StatelessWidget {
  const QuickNavigationButton({
    Key? key,
    this.openCloseDial,
    this.otherOptions,
  }) : super(key: key);

  final ValueNotifier<bool>? openCloseDial;
  final List<SpeedDialChild>? otherOptions;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      // icon: Icons.add,
      // activeIcon: Icons.close,
      spacing: 3,
      openCloseDial: openCloseDial,
      // childPadding: const EdgeInsets.all(5),
      child: Container(
        height: 65.w,
        width: 65.w,
        decoration: BoxDecoration(
          gradient: AppColors.mainButtonGradient,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.add,
          size: 36.w,
        ),
      ),
      activeChild: Container(
        height: 65.w,
        width: 65.w,
        decoration: BoxDecoration(
          gradient: AppColors.fabCloseButtonGradient,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.close,
          size: 36.w,
        ),
      ),
      spaceBetweenChildren: 4,
      visible: true,

      direction: SpeedDialDirection.up,
      switchLabelPosition: false,
      closeManually: false,
      renderOverlay: true,
      overlayColor: AppColors.black,
      overlayOpacity: 0.6,
      onOpen: () => debugPrint('OPENING DIAL'),
      onClose: () => debugPrint('DIAL CLOSED'),
      elevation: 8.0,
      animationCurve: Curves.elasticInOut,
      isOpenOnStart: false,
      animationDuration: const Duration(milliseconds: 200),
      children: [
        ...otherOptions ?? [],
        SpeedDialChild(
          child: Container(
            height: 41.w,
            width: 41.w,
            decoration: BoxDecoration(
              gradient: AppColors.mainButtonGradient,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              AssetIcons.quickNavigationIcon,
              height: 20.h,
              fit: BoxFit.scaleDown,
            ),
          ),
          foregroundColor: AppColors.white,
          backgroundColor: Colors.transparent,
          shape: CircleBorder(),
          labelWidget: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              'Quick Navigation',
              style: TextStyling.semiBold.copyWith(
                color: AppColors.appDarkBlue,
                fontSize: 12.sp,
              ),
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.fabCloseButtonGradient,
                    color: null,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      width: 0.5,
                      color: AppColors.grey.withOpacity(0.3),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Quick Navigate', style: TextStyling.semiBold),
                      VerticalSpacing(20.h),
                      QuickNavigateTile(
                        name: 'Trip Planner',
                        onTap: () {
                          Navigator.pop(context);
                        },
                        svgIconPath: AssetIcons.tripPlannerButtonIcon,
                      ),
                      Divider(
                        height: 0,
                        color: AppColors.grey.withOpacity(0.5),
                      ),
                      QuickNavigateTile(
                        name: 'Groups',
                        onTap: () {
                          Navigator.pop(context);
                        },
                        svgIconPath: AssetIcons.groupsButtonIcon,
                      ),
                      Divider(
                        height: 0,
                        color: AppColors.grey.withOpacity(0.5),
                      ),
                      QuickNavigateTile(
                        name: 'Money Manager',
                        onTap: () {
                          Navigator.pop(context);
                        },
                        svgIconPath: AssetIcons.moneyManagerButtonIcon,
                      ),
                      Divider(
                        height: 0,
                        color: AppColors.grey.withOpacity(0.5),
                      ),
                      QuickNavigateTile(
                        name: 'Profile',
                        onTap: () {
                          Navigator.pop(context);
                        },
                        svgIconPath: AssetIcons.profileButtonIcon,
                      ),
                      Divider(
                        height: 0,
                        color: AppColors.grey.withOpacity(0.5),
                      ),
                      QuickNavigateTile(
                        name: 'Chats',
                        onTap: () {
                          Navigator.pop(context);
                        },
                        svgIconPath: AssetIcons.chatsButtonIcon,
                      ),
                      Divider(
                        height: 0,
                        color: AppColors.grey.withOpacity(0.5),
                      ),
                      QuickNavigateTile(
                        name: 'Event Money Manager',
                        onTap: () {
                          Navigator.pop(context);
                        },
                        svgIconPath: AssetIcons.eventMoneyMngButtonIcon,
                      ),
                      Divider(
                        height: 0,
                        color: AppColors.grey.withOpacity(0.5),
                      ),
                      QuickNavigateTile(
                        name: 'Settings',
                        onTap: () {
                          Navigator.pop(context);
                        },
                        svgIconPath: AssetIcons.settingsButtonIcon,
                      ),
                      Divider(
                        height: 0,
                        color: AppColors.grey.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class QuickNavigateTile extends StatelessWidget {
  const QuickNavigateTile({
    Key? key,
    required this.name,
    required this.svgIconPath,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final String svgIconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  svgIconPath,
                  height: 24.h,
                ),
                HorizontalSpacing(20.w),
                Text(
                  name,
                  style: TextStyling.regular.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: AppColors.white,
              size: 20.h,
            )
          ],
        ),
      ),
    );
  }
}
