import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/src/shared/custom_tab.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';

class TabSwitcherWidget extends StatelessWidget {
  const TabSwitcherWidget({
    Key? key,
    required this.tabs,
    this.outerPadding,
    this.horizontalSpacing,
  }) : super(key: key);

  final List<CustomTab> tabs;
  final EdgeInsets? outerPadding;
  final double? horizontalSpacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outerPadding ?? EdgeInsets.symmetric(horizontal: 27.w),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15.r),
          ),
        ),
        padding: EdgeInsets.all(2.w),
        child: Row(
          children: List.generate(tabs.length, (index) {
            return Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: tabs[index],
                  ),
                  if (index != tabs.length - 1)
                    HorizontalSpacing(horizontalSpacing ?? 5.w),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
