import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/models/operating_cost.dart';
import 'package:starter_app/src/shared/blur_container.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class OperationalCostCard extends StatelessWidget {
  const OperationalCostCard({
    Key? key,
    required this.operatingCost,
    required this.onEdit,
  }) : super(key: key);

  final OperatingCost operatingCost;
  final String dummyText = '---';

  final VoidCallback onEdit;
  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      sigmaX: 11,
      sigmaY: 1,
      child: Padding(
        padding: EdgeInsets.only(
          left: 7.w,
          right: 7.w,
          top: 7.h,
          bottom: 7.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                // child: CachedNetworkImage(
                //   imageUrl:
                //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfhVdI0FxDS2N0sqI8b9Dm_H2vK19hHptpetvbBg33KQ&s',
                //   height: 150.h,
                //   width: double.infinity,
                //   fit: BoxFit.contain,
                // ),
                child: SvgPicture.asset(
                  AssetIcons.chatsButtonIcon,
                  height: 115.h,
                  alignment: Alignment.center,
                ),
              ),
            ),
            VerticalSpacing(20.h),
            Text(
              operatingCost.total != null
                  ? '\$${operatingCost.total?.toStringAsFixed(2)}'
                  : dummyText,
              style: TextStyling.semiBold.copyWith(
                fontSize: 15.sp,
              ),
            ),
            VerticalSpacing(10.h),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 10.sp,
                          color: AppColors.white,
                        ),
                        HorizontalSpacing(3.w),
                        Text(
                          'P - Price',
                          style: TextStyling.regular.copyWith(
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      operatingCost.purchasePrice != null
                          ? '\$${operatingCost.purchasePrice?.toStringAsFixed(2)}'
                          : dummyText,
                      style: TextStyling.medium.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 10.sp,
                          color: AppColors.white,
                        ),
                        HorizontalSpacing(3.w),
                        Text(
                          'P - Date',
                          style: TextStyling.regular.copyWith(
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      operatingCost.purchaseDate != null
                          ? DateFormat('dd/MM/yyyy')
                              .format(operatingCost.purchaseDate!)
                          : dummyText,
                      style: TextStyling.medium.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: TextButton(
                  onPressed: onEdit,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Edit',
                        style: TextStyling.regular.copyWith(
                          fontSize: 12.sp,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.white,
                        ),
                      ),
                      HorizontalSpacing(8.w),
                      Icon(
                        Icons.edit_outlined,
                        color: AppColors.white,
                        size: 15.sp,
                      )
                    ],
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
