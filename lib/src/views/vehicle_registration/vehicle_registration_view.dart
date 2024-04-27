import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/accessory_card.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/custom_tab.dart';
import 'package:starter_app/src/shared/empty_state_widget.dart';
import 'package:starter_app/src/shared/loading_indicator.dart';
import 'package:starter_app/src/shared/operational_cost_card.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/shared/tab_switcher_widget.dart';
import 'package:starter_app/src/shared/vehicle_card.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/email_confirmation/email_confirmation_view.dart';
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 27.w,
          vertical: 10.h,
        ),
        child: SizedBox(
          height: 55.h,
          child: OutlinedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 10.h, horizontal: 24.w),
              ),
              side: MaterialStateProperty.all(
                BorderSide(
                  color: AppColors.appSkyBlue,
                ),
              ),
            ),
            onPressed: model.onClickAddActionButton,
            child: Text(
              getActionButtonText(model.selectedTab),
              style: TextStyling.medium.copyWith(
                fontSize: 18.sp,
                // color: AppColors.appSkyBlue,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SpeedDial(
        // icon: Icons.add,
        // activeIcon: Icons.close,
        spacing: 3,
        openCloseDial: model.isFabOpen,
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
      ),
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
                  // AssetImages.vehicleRegistrationFinancePNG,
                  model.getBgHeroImage(),
                  alignment: Alignment.centerRight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomAppBar(
                  titleText: model.getAppBarTitle(),
                ),
                VerticalSpacing(context.screenSize().height * 0.125),
                // TabSwitcherWidget(
                //   horizontalSpacing: 0,
                //   outerPadding: EdgeInsets.symmetric(horizontal: 20.w),
                //   tabs: [
                //     CustomTab(
                //       title: 'Vehicles',
                //       onTap: () {
                //         model.onChangeTab(0);
                //       },
                //       isSelected: model.selectedTab == 0,
                //     ),
                //     CustomTab(
                //       title: 'Accessories',
                //       onTap: () {
                //         model.onChangeTab(1);
                //       },
                //       isSelected: model.selectedTab == 1,
                //     ),
                //     CustomTab(
                //       title: 'Operational Cost',
                //       onTap: () {
                //         model.onChangeTab(2);
                //       },
                //       isSelected: model.selectedTab == 2,
                //     ),
                //   ],
                // ),
                VehiclesView(model: model),
                // if (model.selectedTab == 0) VehiclesView(model: model),
                // if (model.selectedTab == 1) AccessoriesView(model: model),
                // if (model.selectedTab == 2) OperationalCostView(model: model),
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
                              return AlertDialog(
                                backgroundColor: AppColors.appDarkBlue,
                                insetPadding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0.r),
                                ),
                                title: Text(
                                  (vehicle.isEnabled ?? true)
                                      ? 'Disable Vehicle'
                                      : 'Enable Vehicle',
                                  textAlign: TextAlign.center,
                                  style: TextStyling.medium.copyWith(
                                    fontSize: 16.sp,
                                  ),
                                ),
                                content: Text(
                                  (vehicle.isEnabled ?? true)
                                      ? 'Are you sure you want to disable vehicle?'
                                      : 'Are you sure you want to enable vehicle?',
                                  style: TextStyling.thin
                                      .copyWith(fontSize: 12.sp),
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          model.onDisableVehicle(
                                            vehicle.id!,
                                            !(vehicle.isEnabled!),
                                          );
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: Container(
                                          height: 40.0.h,
                                          width: 70.0.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            color: AppColors.appSkyBlue,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Yes",
                                              style:
                                                  TextStyling.regular.copyWith(
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
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "No",
                                              style:
                                                  TextStyling.regular.copyWith(
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
                            });
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

class AccessoriesView extends StatelessWidget {
  const AccessoriesView({
    Key? key,
    required this.model,
  }) : super(key: key);

  final VehicleRegistrationViewModel model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (!model.vehiclesLoading)
              SizedBox(
                height: 45.h + 40.h,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 27.w,
                    vertical: 16.h,
                  ),
                  separatorBuilder: (context, index) => HorizontalSpacing(20.w),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // Display the "All" option
                      return GestureDetector(
                        onTap: () {
                          model.onChangeSelectedVehicleForFilterInAccessories(
                              null); // Set selectedVehicleForFilter to null
                        },
                        child: Container(
                          height: 45.h,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color:
                                model.selectedVehicleForFilterInAccessories ==
                                        null
                                    ? AppColors.appDarkBlue
                                    : AppColors.white,
                            border: Border.all(
                              color:
                                  model.selectedVehicleForFilterInAccessories ==
                                          null
                                      ? AppColors.lightGrey.withOpacity(0.2)
                                      : AppColors.grey.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'All', // Display "All" as the first option
                              style: TextStyling.semiBold.copyWith(
                                fontSize: 12.sp,
                                color:
                                    model.selectedVehicleForFilterInAccessories ==
                                            null
                                        ? AppColors.white
                                        : AppColors.appDarkBlue,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      // Display individual vehicles
                      final vehicle = model.dataService.vehicles[index -
                          1]; // Subtract 1 to account for the "All" option
                      return GestureDetector(
                        onTap: () {
                          model.onChangeSelectedVehicleForFilterInAccessories(
                              vehicle);
                        },
                        child: Container(
                          height: 45.h,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color:
                                model.selectedVehicleForFilterInAccessories ==
                                        vehicle
                                    ? AppColors.appDarkBlue
                                    : AppColors.white,
                            border: Border.all(
                              color:
                                  model.selectedVehicleForFilterInAccessories ==
                                          vehicle
                                      ? AppColors.lightGrey.withOpacity(0.2)
                                      : AppColors.grey.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              vehicle.model?.model ?? '',
                              style: TextStyling.semiBold.copyWith(
                                fontSize: 12.sp,
                                color:
                                    model.selectedVehicleForFilterInAccessories ==
                                            vehicle
                                        ? AppColors.white
                                        : AppColors.appDarkBlue,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  itemCount: model.dataService.vehicles.length +
                      1, // Add 1 for the "All" option
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                ),
              ),
            // AccessoryCategoryHeader(
            //   categoryName: 'front',
            // ),
            SizedBox(
              height: 32.h + 360.h,
              child: model.allAccessories.isNotEmpty
                  ? ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: 27.w,
                        vertical: 16.h,
                      ),
                      separatorBuilder: (context, index) =>
                          HorizontalSpacing(20.h),
                      itemBuilder: (context, index) {
                        final accessory = model.allAccessories[index];
                        return AccessoryCard(
                            accessory: accessory,
                            onClickEdit: () {
                              model.onEditAccessory(accessory);
                            });
                      },
                      shrinkWrap: false,
                      itemCount: model.allAccessories.length,
                      scrollDirection: Axis.horizontal,
                    )
                  : EmptyStateWidget(
                      text: 'No Accessories Found',
                      color: AppColors.appSkyBlue,
                    ),
            ),
            // AccessoryCategoryHeader(categoryName: ''),
            // SizedBox(
            //   height: 32.h + 360.h,
            //   child: ListView.separated(
            //     padding: EdgeInsets.symmetric(
            //       horizontal: 27.w,
            //       vertical: 16.h,
            //     ),
            //     separatorBuilder: (context, index) => HorizontalSpacing(20.h),
            //     itemBuilder: (context, index) {
            //       final accessory = model.allAccessories[index];
            //       return AccessoryCard(
            //           accessory: accessory,
            //           onClickEdit: () {
            //             model.onEditAccessory(accessory);
            //           });
            //     },
            //     shrinkWrap: false,
            //     itemCount: model.allAccessories.length,
            //     scrollDirection: Axis.horizontal,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class AccessoryCategoryHeader extends StatelessWidget {
  const AccessoryCategoryHeader({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 27.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Safety Gear',
            style: TextStyling.regular,
          ),
          // MainButton(
          //   width: 25.w,
          //   height: 25.w,
          //   padding: EdgeInsets.zero,
          //   fullWidth: false,
          //   buttonText: '',
          //   onPressed: () {},
          //   isLoading: false,
          //   child: Icon(
          //     Icons.add,
          //     color: AppColors.white,
          //     size: 20.sp,
          //   ),
          //   borderRadius: BorderRadius.circular(5.r),
          // ),
        ],
      ),
    );
  }
}

class OperationalCostView extends StatelessWidget {
  const OperationalCostView({
    Key? key,
    required this.model,
  }) : super(key: key);

  final VehicleRegistrationViewModel model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          if (!model.vehiclesLoading)
            SizedBox(
              height: 45.h + 40.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: 27.w,
                  vertical: 16.h,
                ),
                separatorBuilder: (context, index) => HorizontalSpacing(20.w),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // Display the "All" option
                    return GestureDetector(
                      onTap: () {
                        model.onChangeSelectedVehicleForFilterInOperatingCosts(
                            null); // Set selectedVehicleForFilter to null
                      },
                      child: Container(
                        height: 45.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color:
                              model.selectedVehicleForFilterInOperatingCosts ==
                                      null
                                  ? AppColors.appDarkBlue
                                  : AppColors.white,
                          border: Border.all(
                            color:
                                model.selectedVehicleForFilterInOperatingCosts ==
                                        null
                                    ? AppColors.lightGrey.withOpacity(0.2)
                                    : AppColors.grey.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'All', // Display "All" as the first option
                            style: TextStyling.semiBold.copyWith(
                              fontSize: 12.sp,
                              color:
                                  model.selectedVehicleForFilterInOperatingCosts ==
                                          null
                                      ? AppColors.white
                                      : AppColors.appDarkBlue,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    // Display individual vehicles
                    final vehicle = model.dataService.vehicles[index -
                        1]; // Subtract 1 to account for the "All" option
                    return GestureDetector(
                      onTap: () {
                        model.onChangeSelectedVehicleForFilterInOperatingCosts(
                            vehicle);
                      },
                      child: Container(
                        height: 45.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color:
                              model.selectedVehicleForFilterInOperatingCosts ==
                                      vehicle
                                  ? AppColors.appDarkBlue
                                  : AppColors.white,
                          border: Border.all(
                            color:
                                model.selectedVehicleForFilterInOperatingCosts ==
                                        vehicle
                                    ? AppColors.lightGrey.withOpacity(0.2)
                                    : AppColors.grey.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            vehicle.model?.model ?? '',
                            style: TextStyling.semiBold.copyWith(
                              fontSize: 12.sp,
                              color:
                                  model.selectedVehicleForFilterInOperatingCosts ==
                                          vehicle
                                      ? AppColors.white
                                      : AppColors.appDarkBlue,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
                itemCount: model.dataService.vehicles.length +
                    1, // Add 1 for the "All" option
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
              ),
            ),
          Expanded(
            child: model.operationsCostsLoading
                ? Center(
                    child: LoadingIndicator(
                      color: AppColors.appSkyBlue,
                    ),
                  )
                : model.allOperationalCosts.isEmpty
                    ? EmptyStateWidget(
                        text: 'No operational costs',
                        color: AppColors.appSkyBlue,
                      )
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20.sp,
                          mainAxisSpacing: 20.sp,
                          mainAxisExtent: 260.h,
                        ),
                        itemBuilder: (context, index) {
                          final cost = model.allOperationalCosts[index];
                          print(cost.toString());
                          return OperationalCostCard(
                            operatingCost: cost,
                            onEdit: () {
                              model.onEditOperatingCost(cost);
                            },
                          );
                        },
                        itemCount: model.allOperationalCosts.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                          horizontal: 27.w,
                        ),
                        scrollDirection: Axis.vertical,
                      ),
          ),
        ],
      ),
    );
  }
}

String getActionButtonText(int index) {
  switch (index) {
    case 0:
      return 'Add Vehicle';
    case 1:
      return 'Add Accessory';
    case 2:
      return 'Add Cost';
    default:
      return '';
  }
}
