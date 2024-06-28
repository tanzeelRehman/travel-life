import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChange;
  final bool vehicleRegistrationNav;
  const CustomBottomNavbar(
      {Key? key,
      required this.selectedIndex,
      required this.onChange,
      required this.vehicleRegistrationNav})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      width: context.screenSize().width,
      decoration: BoxDecoration(
        // color: AppColors.appFaddedBlue.withOpacity(0.5),
        color: AppColors.bottomNavBarColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12.r),
          topLeft: Radius.circular(12.r),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 10.h,
        top: 10.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: vehicleRegistrationNav
            ? [
                _item(
                  "Home",
                  AssetIcons.navHome,
                  selectedIndex == 0,
                  () {
                    onChange(0);
                  },
                ),
                _item(
                  "Downloads",
                  AssetIcons.navDownloads,
                  (selectedIndex == 1) ? true : false,
                  () {
                    onChange(1);
                  },
                ),
                //just dummy
                _item(
                  "",
                  AssetIcons.navDownloads,
                  false,
                  () {
                    // onChange(1);
                  },
                  iconHeight: 0,
                ),
                _item(
                  "Search",
                  AssetIcons.navSearch,
                  (selectedIndex == 2) ? true : false,
                  () {
                    onChange(2);
                  },
                ),
                _item(
                  "Contact Us",
                  AssetIcons.navContactUs,
                  (selectedIndex == 3) ? true : false,
                  () {
                    onChange(3);
                  },
                ),
              ]
            : [
                _item(
                  "Itinerary",
                  AssetIcons.eventNavItnerary,
                  selectedIndex == 0,
                  () {
                    onChange(0);
                  },
                ),
                _item(
                  "Stats",
                  AssetIcons.eventNavStats,
                  (selectedIndex == 1) ? true : false,
                  () {
                    onChange(1);
                  },
                ),
                //just dummy
                // _item(
                //   "",
                //   AssetIcons.eventNavMap,
                //   false,
                //   () {
                //     // onChange(1);
                //   },
                //   iconHeight: 0,
                // ),
                _item(
                  "Map",
                  AssetIcons.eventNavMap,
                  (selectedIndex == 2) ? true : false,
                  () {
                    onChange(2);
                  },
                ),
                _item(
                  "Settings",
                  AssetIcons.eventNavSettings,
                  (selectedIndex == 3) ? true : false,
                  () {
                    onChange(3);
                  },
                ),
              ],
      ),
    );
  }

  _item(String title, String svgIconPath, bool isSelected, Function onTap,
      {double? iconHeight}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            (isSelected)
                ? Container(
                    // decoration: BoxDecoration(
                    //     color: AppColors.white, shape: BoxShape.circle),
                    // padding: EdgeInsets.fromLTRB(12, 12, 15, 12),
                    child: Center(
                      child: SvgPicture.asset(
                        svgIconPath,
                        // size: 20.w,
                        height: iconHeight ?? 20.h,
                        color: AppColors.appSkyBlue,
                      ),
                    ),
                  )
                : SvgPicture.asset(
                    svgIconPath,
                    height: iconHeight ?? 20.h,
                    color: AppColors.grey,
                  ),
            VerticalSpacing(10.h),
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyling.bold.copyWith(
                  color: isSelected ? AppColors.appSkyBlue : AppColors.grey,
                  fontSize: 10.sp,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
