import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:starter_app/src/models/accessory.dart';
import 'package:starter_app/src/services/local/flavor_service.dart';
import 'package:starter_app/src/shared/blur_container.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class AccessoryCard extends StatelessWidget {
  const AccessoryCard({
    Key? key,
    required this.accessory,
    required this.onClickEdit,
  }) : super(key: key);

  final Accessory accessory;
  final VoidCallback onClickEdit;
  final String dummyText = '---';

  @override
  Widget build(BuildContext context) {
    // print(accessory.total);
    // print(accessory.total != null ? '\$${accessory.total}' : dummyText);
    return BlurContainer(
      height: 360.h,
      width: 200.w,
      sigmaX: 1,
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
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                imageUrl: accessory.accessoryImageAttachment ??
                    FlavorService.dummyImageUrl,
                height: 150.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            VerticalSpacing(10.h),
            Text(
              accessory.total != null ? '\$${accessory.total}' : dummyText,
              style: TextStyling.semiBold.copyWith(
                fontSize: 15.sp,
              ),
            ),
            VerticalSpacing(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Purchasing Date',
                      style: TextStyling.regular.copyWith(
                        fontSize: 10.sp,
                        color: AppColors.grey,
                      ),
                    ),
                    HorizontalSpacing(8.w),
                    Text(
                      accessory.purchaseDate != null
                          ? DateFormat('dd-MMM-yyyy')
                              .format(accessory.purchaseDate!)
                          : dummyText,
                      style: TextStyling.medium.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Purchasing Price',
                      style: TextStyling.regular.copyWith(
                        fontSize: 10.sp,
                        color: AppColors.grey,
                      ),
                    ),
                    HorizontalSpacing(8.w),
                    Text(
                      accessory.purchasePrice != null
                          ? '\$${accessory.purchasePrice}'
                          : dummyText,
                      style: TextStyling.medium.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            VerticalSpacing(10.h),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.appFaddedBlue,
                ),
                child: Text(
                  accessory.description ?? dummyText,
                  style: TextStyling.regular.copyWith(fontSize: 10.sp),
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: onClickEdit,
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
          ],
        ),
      ),
    );
  }
}
