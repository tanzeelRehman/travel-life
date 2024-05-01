import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class QuickNavigationButton extends StatelessWidget {
  const QuickNavigationButton({
    Key? key,
    this.openCloseDial,
  }) : super(key: key);

  final ValueNotifier<bool>? openCloseDial;

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
          onTap: () => debugPrint('SECOND CHILD'),
        ),
      ],
    );
  }
}
