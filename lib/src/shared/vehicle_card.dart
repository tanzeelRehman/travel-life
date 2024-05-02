import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/models/vehicle.dart';
import 'package:starter_app/src/shared/blur_container.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({
    Key? key,
    required this.vehicle,
    required this.onEdit,
    required this.onDelete,
    required this.defaultImageUrl,
  }) : super(key: key);

  final Vehicle vehicle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final String dummyText = '---';
  final String defaultImageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEdit,
      child: BlurContainer(
        // height: MediaQuery.of(context).size.height * 0.41,
        child: Stack(
          children: [
            Opacity(
              opacity: (vehicle.isEnabled ?? true) ? 1 : 0.4,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                  top: 10.h,
                  bottom: 20.w,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        vehicle.photoURL ?? defaultImageUrl,
                        height: 173.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    VerticalSpacing(10.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            vehicle.model?.model ?? dummyText,
                            style: TextStyling.semiBold.copyWith(
                              fontSize: 20.sp,
                            ),
                          ),
                          VerticalSpacing(10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AssetImages.vehicleCardFuelAverage,
                                    height: 15.h,
                                  ),
                                  HorizontalSpacing(8.w),
                                  Text(
                                    vehicle.consumption != null
                                        ? '${vehicle.consumption} Km/L'
                                        : dummyText,
                                    style: TextStyling.regular.copyWith(
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AssetImages.vehicleCardBuildyear,
                                    height: 15.h,
                                  ),
                                  HorizontalSpacing(8.w),
                                  Text(
                                    vehicle.manufactureYear != null
                                        ? '${vehicle.manufactureYear}'
                                        : dummyText,
                                    style: TextStyling.regular.copyWith(
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          VerticalSpacing(10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AssetImages.vehicleCardPurchasePrice,
                                    height: 15.h,
                                  ),
                                  HorizontalSpacing(8.w),
                                  Text(
                                    vehicle.price != null
                                        ? '\$${vehicle.price!.toStringAsFixed(2)}'
                                        : dummyText,
                                    style: TextStyling.regular.copyWith(
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AssetImages.vehicleCardRunningKM,
                                    height: 15.h,
                                  ),
                                  HorizontalSpacing(8.w),
                                  Text(
                                    vehicle.odometer != null
                                        ? '${vehicle.odometer} Km'
                                        : dummyText,
                                    style: TextStyling.regular.copyWith(
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: IconButton(
                onPressed: onDelete,
                icon: Container(
                  height: 30.w,
                  width: 30.w,
                  decoration: BoxDecoration(
                    color: (vehicle.isEnabled ?? true)
                        ? AppColors.red
                        : Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: (vehicle.isEnabled ?? true)
                      ? SvgPicture.asset(
                          AssetIcons.deleteIcon,
                          fit: BoxFit.scaleDown,
                        )
                      : Icon(
                          Icons.check,
                          color: AppColors.white,
                          size: 20.sp,
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
