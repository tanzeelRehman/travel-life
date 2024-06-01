import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/custom_bottom_navbar.dart';
import 'package:starter_app/src/shared/empty_state_widget.dart';
import 'package:starter_app/src/shared/loading_indicator.dart';
import 'package:starter_app/src/shared/quick_navigation_button.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/shared/vehicle_card.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

import 'package:starter_app/src/views/vehicle_registration/vehicle_registration_view_model.dart';

class VehicleRegistrationView
    extends StackedView<VehicleRegistrationViewModel> {
  @override
  Widget builder(
    BuildContext context,
    VehicleRegistrationViewModel model,
    Widget? child,
  ) {
    return Scaffold(
      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.symmetric(
      //     horizontal: 27.w,
      //     vertical: 10.h,
      //   ),
      //   child: MainOutlinedButton(
      //     buttonText: 'Add Vehicle',
      //     onPressed: model.onInsertVehicle,
      //   ),
      // ),
      bottomNavigationBar: CustomBottomNavbar(
        onChange: (value) {
          model.onChangeBottomNavIndex(value);
        },
        selectedIndex: model.selectedBottomNavIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: QuickNavigationButton(
        openCloseDial: model.isFabOpen,
        otherOptions: [
          SpeedDialChild(
            child: Container(
              height: 41.w,
              width: 41.w,
              decoration: BoxDecoration(
                gradient: AppColors.vehicleRegistrationGradient,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(10.w),
              child: SvgPicture.asset(
                AssetIcons.vehicleRegistrationButtonIcon,
                fit: BoxFit.scaleDown,
              ),
            ),
            foregroundColor: AppColors.white,
            backgroundColor: Colors.transparent,
            shape: CircleBorder(),
            labelWidget: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
              decoration: BoxDecoration(
                color: AppColors.appSkyBlue,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                'Add Vehicle',
                style: TextStyling.semiBold.copyWith(
                  color: AppColors.white,
                  fontSize: 12.sp,
                ),
              ),
            ),
            onTap: () {
              Future.delayed(Duration(milliseconds: 150), () {
                model.onInsertVehicle();
              });
            },
          ),
        ],
      ),
      // floatingActionButton: MainFloatingActionButton(
      //   onTap: () {
      //     model.onInsertVehicle();
      //   },
      //   heightAndWidth: 65.w,
      // ),
      body: Container(
        width: context.screenSize().width,
        height: context.screenSize().height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset(
              AssetImages.vehicleRegistrationBg,
              height: context.screenSize().height,
              width: context.screenSize().width,
            ).image,
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -context.screenSize().width * 0.4,
              top: 0,
              child: SizedBox(
                height: context.screenSize().height * 0.25,
                width: context.screenSize().width,
                child: Image.asset(
                  AssetImages.vehicleRegistrationCarPNG,
                  alignment: Alignment.centerRight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomAppBar(
                  titleText: 'Vehicle Registration',
                ),
                VerticalSpacing(context.screenSize().height * 0.125),
                VehiclesView(model: model),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  VehicleRegistrationViewModel viewModelBuilder(BuildContext context) =>
      VehicleRegistrationViewModel();

  @override
  void onViewModelReady(VehicleRegistrationViewModel model) => model.init();
}

class VehiclesView extends StatelessWidget {
  const VehiclesView({
    Key? key,
    required this.model,
  }) : super(key: key);

  final VehicleRegistrationViewModel model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: model.vehiclesLoading
          ? Center(
              child: LoadingIndicator(
                color: AppColors.appSkyBlue,
              ),
            )
          : model.dataService.vehicles.isEmpty
              ? EmptyStateWidget(
                  text: 'No vehicles added yet',
                  color: AppColors.appSkyBlue,
                )
              : ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 27.w,
                    vertical: 16.h,
                  ),
                  separatorBuilder: (context, index) => VerticalSpacing(20.h),
                  itemBuilder: (context, index) {
                    final vehicle = model.dataService.vehicles[index];
                    return VehicleCard(
                      vehicle: vehicle,
                      onEdit: () {
                        model.onEditVehicle(vehicle);
                      },
                      onDelete: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DisableVehicleDialog(
                              isVehicleEnabled: vehicle.isEnabled,
                              onClickYes: () {
                                model.onDisableVehicle(
                                  vehicle.id!,
                                  !(vehicle.isEnabled!),
                                );
                              },
                            );
                          },
                        );
                      },
                      defaultImageUrl: model
                          .getVehicleDefaultImageUrl(vehicle.manufacturer!.id!),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: model.dataService.vehicles.length,
                ),
    );
  }
}

class DisableVehicleDialog extends StatelessWidget {
  const DisableVehicleDialog({
    Key? key,
    required this.isVehicleEnabled,
    required this.onClickYes,
  }) : super(key: key);

  final bool? isVehicleEnabled;
  final VoidCallback onClickYes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.appDarkBlue,
      insetPadding: EdgeInsets.only(left: 10.0, right: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      title: Text(
        (isVehicleEnabled ?? true) ? 'Disable Vehicle' : 'Enable Vehicle',
        textAlign: TextAlign.center,
        style: TextStyling.medium.copyWith(
          fontSize: 16.sp,
        ),
      ),
      content: Text(
        (isVehicleEnabled ?? true)
            ? 'Are you sure you want to disable vehicle?'
            : 'Are you sure you want to enable vehicle?',
        style: TextStyling.thin.copyWith(fontSize: 12.sp),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                onClickYes();
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                height: 40.0.h,
                width: 70.0.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: AppColors.appSkyBlue,
                ),
                child: Center(
                  child: Text(
                    "Yes",
                    style: TextStyling.regular.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
            HorizontalSpacing(15.w),
            GestureDetector(
              onTap: () {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                height: 40.0.h,
                width: 70.0.w,
                decoration: BoxDecoration(
                  color: AppColors.appFaddedBlue,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: Text(
                    "No",
                    style: TextStyling.regular.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        VerticalSpacing(10),
      ],
    );
  }
}
