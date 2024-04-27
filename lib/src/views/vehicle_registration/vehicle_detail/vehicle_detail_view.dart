import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart';
import 'package:starter_app/src/base/enums/vehicle_status.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/manufacturor.dart';
import 'package:starter_app/src/models/ui_models/vehicle_status_button_model.dart';
import 'package:starter_app/src/models/vehicle.dart';
import 'package:starter_app/src/models/vehicle_model.dart';
import 'package:starter_app/src/shared/accessory_card.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/custom_datepicker_dialog.dart';
import 'package:starter_app/src/shared/custom_tab.dart';
import 'package:starter_app/src/shared/empty_state_widget.dart';
import 'package:starter_app/src/shared/loading_indicator.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/operational_cost_card.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/shared/tab_switcher_widget.dart';
import 'package:starter_app/src/shared/vehicle_registration_field.dart';
import 'package:starter_app/src/shared/vehicle_registration_select_widget.dart';
import 'package:starter_app/src/shared/vehicle_registration_textfield.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/bottomsheets/manufacturer_bottomsheet/manufacturer_bottomsheet_view.dart';
import 'package:starter_app/src/views/bottomsheets/vehicle_model_bottomsheet/vehicle_model_bottomsheet_view.dart';
import 'package:starter_app/src/views/vehicle_registration/vehicle_detail/vehicle_detail_view_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class VehicleDetailView extends StackedView<VehicleDetailViewModel> {
  final VehicleRegistrationAction action;
  final Vehicle? vehicle;

  VehicleDetailView({
    required this.action,
    required this.vehicle,
  });

  @override
  Widget builder(
    BuildContext context,
    VehicleDetailViewModel model,
    Widget? child,
  ) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 27.w,
            vertical: 10.h,
          ),
          child: action == VehicleRegistrationAction.add
              ? MainButton(
                  buttonText: 'Add Vehicle',
                  onPressed: model.updateOrInsertVehicle,
                  isLoading: model.isBusy,
                )
              : getActionButton(
                  model.selectedTab,
                  action,
                  vehicle,
                  model,
                ),
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
          child: action == VehicleRegistrationAction.add
              ? AddView(
                  action: action,
                  vehicle: vehicle,
                  model: model,
                )
              : EditView(
                  action: action,
                  vehicle: vehicle,
                  model: model,
                ),
        ),
      ),
    );
  }

  @override
  VehicleDetailViewModel viewModelBuilder(BuildContext context) =>
      VehicleDetailViewModel();

  @override
  void onViewModelReady(VehicleDetailViewModel model) =>
      model.init(action, vehicle);
}

class EditView extends StatelessWidget {
  const EditView({
    Key? key,
    required this.action,
    required this.vehicle,
    required this.model,
  }) : super(key: key);

  final VehicleRegistrationAction action;
  final Vehicle? vehicle;
  final VehicleDetailViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          titleText: 'Vehicle Details',
        ),
        VerticalSpacing(10.h),
        TabSwitcherWidget(
          horizontalSpacing: 0,
          outerPadding: EdgeInsets.symmetric(horizontal: 20.w),
          tabs: [
            CustomTab(
              title: 'Details',
              onTap: () {
                model.onChangeTab(0);
              },
              isSelected: model.selectedTab == 0,
            ),
            CustomTab(
              title: 'Accessories',
              onTap: () {
                model.onChangeTab(1);
              },
              isSelected: model.selectedTab == 1,
            ),
            CustomTab(
              title: 'Operational Cost',
              onTap: () {
                model.onChangeTab(2);
              },
              isSelected: model.selectedTab == 2,
            ),
          ],
        ),
        VerticalSpacing(10.h),
        Expanded(
          child: getTab(model.selectedTab, action, vehicle, model),
        ),
      ],
    );
  }
}

Widget getTab(int selectedTab, VehicleRegistrationAction action,
    Vehicle? vehicle, VehicleDetailViewModel model) {
  print('selectedTab in getTab: $selectedTab');
  switch (selectedTab) {
    case 0:
      return DetailsTab(action: action, vehicle: vehicle, model: model);
    case 1:
      return AccessoriesTab(
        model: model,
        v: vehicle,
      );
    case 2:
      return OperationalCostTab(
        model: model,
        v: vehicle,
      );
    default:
      return SizedBox.shrink();
  }
}

Widget getActionButton(int selectedTab, VehicleRegistrationAction action,
    Vehicle? vehicle, VehicleDetailViewModel model) {
  print('selectedTab in getACtionButton: $selectedTab');
  switch (selectedTab) {
    case 0:
      return MainButton(
        buttonText: 'Save',
        onPressed: model.updateOrInsertVehicle,
        isLoading: model.isBusy,
      );
    case 1:
      return SizedBox(
        height: 60.h,
        child: MainOutlinedButton(
          onTap: () {
            model.onInsertAccessory(vehicle);
          },
          buttonText: 'Add Accessory',
        ),
      );
    case 2:
      return SizedBox(
        height: 60.h,
        child: MainOutlinedButton(
          onTap: () {
            model.onInsertOperatingCost(vehicle);
          },
          buttonText: 'Add Cost',
        ),
      );
    default:
      return SizedBox.shrink();
  }
}

class OperationalCostTab extends StatelessWidget {
  const OperationalCostTab({
    Key? key,
    required this.model,
    required this.v,
  }) : super(key: key);

  final VehicleDetailViewModel model;
  final Vehicle? v;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // VerticalSpacing(10.h),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 27.w),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       GestureDetector(
        //         // onTap: model.onInsertOperatingCost,
        //         onTap: () {
        //           model.onInsertOperatingCost(v);
        //         },
        //         child: Container(
        //           height: 35.w,
        //           width: 35.w,
        //           decoration: BoxDecoration(
        //             gradient: AppColors.mainButtonGradient,
        //             shape: BoxShape.circle,
        //           ),
        //           child: Icon(
        //             Icons.add,
        //             size: 26.w,
        //             color: AppColors.white,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // VerticalSpacing(10.h),
        Expanded(
          child: model.operationsCostsLoading
              ? Center(
                  child: LoadingIndicator(
                    color: AppColors.appSkyBlue,
                  ),
                )
              : model.dataService.operatingCosts.isEmpty
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
                        final cost = model.dataService.operatingCosts[index];
                        print(cost.toString());
                        return OperationalCostCard(
                          operatingCost: cost,
                          onEdit: () {
                            model.onEditOperatingCost(cost);
                          },
                        );
                      },
                      itemCount: model.dataService.operatingCosts.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: 27.w,
                        vertical: 16.h,
                      ),
                      scrollDirection: Axis.vertical,
                    ),
        ),
      ],
    );
  }
}

class AccessoriesTab extends StatelessWidget {
  const AccessoriesTab({
    Key? key,
    required this.model,
    required this.v,
  }) : super(key: key);

  final VehicleDetailViewModel model;
  final Vehicle? v;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // VerticalSpacing(10.h),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 27.w),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       GestureDetector(
        //         // onTap: model.onInsertAccessory,
        //         onTap: () {
        //           model.onInsertAccessory(v);
        //         },
        //         child: Container(
        //           height: 35.w,
        //           width: 35.w,
        //           decoration: BoxDecoration(
        //             gradient: AppColors.mainButtonGradient,
        //             shape: BoxShape.circle,
        //           ),
        //           child: Icon(
        //             Icons.add,
        //             size: 26.w,
        //             color: AppColors.white,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // VerticalSpacing(10.h),

        model.accessoriesLoading
            ? Expanded(
                child: Center(
                  child: LoadingIndicator(
                    color: AppColors.appSkyBlue,
                  ),
                ),
              )
            : model.dataService.accessories.isEmpty
                ? Expanded(
                    child: EmptyStateWidget(
                      text: 'No Accessories Found',
                      color: AppColors.appSkyBlue,
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...model.dataService.accessoryCategories.map(
                            (e) {
                              final accessories = model.dataService.accessories
                                  .where(
                                      (element) => element.category?.id == e.id)
                                  .toList();

                              if (accessories.isEmpty) return SizedBox.shrink();
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AccessoryCategoryHeader(
                                      categoryName: e.name ?? ''),
                                  SizedBox(
                                    height: 32.h + 360.h,
                                    child: !model.accessoriesLoading
                                        ? ListView.separated(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 27.w,
                                              vertical: 16.h,
                                            ),
                                            separatorBuilder:
                                                (context, index) =>
                                                    HorizontalSpacing(20.h),
                                            itemBuilder: (context, index) {
                                              final accessory =
                                                  accessories[index];
                                              return AccessoryCard(
                                                  accessory: accessory,
                                                  onClickEdit: () {
                                                    model.onEditAccessory(
                                                        accessory);
                                                  });
                                            },
                                            shrinkWrap: false,
                                            itemCount: accessories.length,
                                            scrollDirection: Axis.horizontal,
                                          )
                                        : Center(
                                            child: LoadingIndicator(
                                              color: AppColors.appSkyBlue,
                                            ),
                                          ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
      ],
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
      padding: EdgeInsets.only(
        left: 27.w,
        top: 5.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            categoryName,
            style: TextStyling.bold,
          ),
        ],
      ),
    );
  }
}

class DetailsTab extends StatelessWidget {
  const DetailsTab({
    Key? key,
    required this.action,
    required this.vehicle,
    required this.model,
  }) : super(key: key);

  final VehicleRegistrationAction action;
  final Vehicle? vehicle;
  final VehicleDetailViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: context.screenSize().height * 0.25,
          width: context.screenSize().width,
          margin: EdgeInsets.symmetric(horizontal: 27.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColors.white.withOpacity(0.1),
            image: action == VehicleRegistrationAction.edit
                ? vehicle?.photoURL != null && model.selectedImage == null
                    ? DecorationImage(
                        image: NetworkImage(
                          vehicle!.photoURL!,
                        ),
                        fit: BoxFit.cover,
                        opacity: 0.5,
                      )
                    : model.selectedImage != null
                        ? DecorationImage(
                            image: Image.file(model.selectedImage!).image,
                            fit: BoxFit.cover,
                            opacity: 0.5,
                          )
                        : null
                : model.selectedImage != null
                    ? DecorationImage(
                        image: Image.file(model.selectedImage!).image,
                        fit: BoxFit.cover,
                        opacity: 0.5,
                      )
                    : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  //TODO add image or whatever
                  model.onClickAddImage();
                },
                child: Container(
                  height: 60.sp,
                  width: 60.sp,
                  decoration: BoxDecoration(
                    gradient: AppColors.mainButtonGradient,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.add,
                    color: AppColors.white,
                    size: 40.sp,
                  ),
                ),
              ),
              VerticalSpacing(10.h),
              Text(
                'Add Image',
                style: TextStyling.regular.copyWith(
                  fontSize: 12.sp,
                ),
              )
            ],
          ),
        ),
        VerticalSpacing(10.h),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 27.w,
              vertical: 10.h,
            ),
            child: Column(
              children: [
                VehicleRegistrationField(
                  svgIconPath: AssetIcons.tfManufacturor,
                  labelText: 'Manufacturer',
                  child: VehicleRegistrationSelectWidget(
                    hintText: 'Manufacturer',
                    isLoading: model.isManufacturersLoading,
                    onTap: () async {
                      final Manufacturor? v = await showModalBottomSheet(
                        constraints: BoxConstraints(
                          minHeight: context.screenSize().height * 0.8,
                        ),
                        context: context,
                        builder: (context) => ManufacturerBottomSheetView(),
                      );
                      print(v?.name);
                      model.onChangeManufacturer(v);
                    },
                    value: model.selectedManufacturer?.name,
                  ),
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationField(
                  svgIconPath: AssetIcons.tfModel,
                  labelText: 'Model',
                  child: VehicleRegistrationSelectWidget(
                    hintText: 'Model',
                    isLoading: model.isVehicleModelsLoading,
                    onTap: () async {
                      if (model.selectedManufacturer != null) {
                        final VehicleModel? v = await showModalBottomSheet(
                          context: context,
                          builder: (context) => VehicleModelBottomSheetView(),
                        );

                        model.onChangeVehicleModel(v);
                      } else {
                        Constants.customWarningSnack(
                            'Please select manufacturer first');
                      }
                    },
                    value: model.selectedVehicleModel?.model,
                  ),
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationField(
                  svgIconPath: AssetIcons.tfDate,
                  labelText: 'Manufacture Year',
                  child: VehicleRegistrationSelectWidget(
                    hintText: 'Select Manufacture Year',
                    isLoading: false,
                    showDropdownIcon: false,
                    onTap: () async {
                      final v = await showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDatePickerDialog(
                            allowViewChange: false,
                            view: DateRangePickerView.decade,
                          );
                        },
                      );
                      model.onChangeManufactureYear(v);
                    },
                    value: model.manufactureYear != null
                        ? '${model.manufactureYear!.year}'
                        : null,
                  ),
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationTextField(
                  svgIconPath: AssetIcons.tfPrice,
                  labelText: 'Price',
                  controller: model.priceController,
                  inputType: TextInputType.number,
                  textInputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,5}'),
                    )
                  ],
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationTextField(
                  svgIconPath: AssetIcons.tfDescription,
                  labelText: 'Description',
                  multiline: true,
                  controller: model.descriptionController,
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationField(
                  // labelText: 'Model',
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                boxShadow:
                                    AppColors.vehicleRegTextFieldBoxShadows,
                              ),
                              height: 50.h,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Primary Vehicle',
                                    style: TextStyling.medium.copyWith(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          HorizontalSpacing(10.w),
                          Checkbox(
                            value: model.isPrimaryVehicle,
                            onChanged: (v) {
                              model.toggleIsPrimaryVehicle(v);
                            },
                            activeColor: AppColors.appSkyBlue,
                            side: BorderSide(
                              color: AppColors.appSkyBlue,
                            ),
                          ),
                        ],
                      ),
                      VerticalSpacing(10.h),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                boxShadow:
                                    AppColors.vehicleRegTextFieldBoxShadows,
                              ),
                              height: 50.h,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'In Use',
                                    style: TextStyling.medium.copyWith(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          HorizontalSpacing(10.w),
                          Checkbox(
                            value: model.isInUse,
                            onChanged: (v) {
                              model.toggleIsInUse(v);
                            },
                            activeColor: AppColors.appSkyBlue,
                            side: BorderSide(
                              color: AppColors.appSkyBlue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationField(
                  svgIconPath: AssetIcons.tfDate,
                  labelText: 'Purchase Date',
                  child: VehicleRegistrationSelectWidget(
                    hintText: 'Purchase Date',
                    isLoading: false,
                    showDropdownIcon: false,
                    onTap: () async {
                      final v = await showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDatePickerDialog();
                        },
                      );
                      model.onChangePurchaseDate(v);
                    },
                    value: model.purchaseDate != null
                        ? DateFormat('dd/MM/yyyy').format(model.purchaseDate!)
                        : null,
                  ),
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationField(
                  svgIconPath: AssetIcons.tfDate,
                  labelText: 'Warranty Expiry Date',
                  child: VehicleRegistrationSelectWidget(
                    hintText: 'Add Warranty Expiry Date',
                    isLoading: false,
                    showDropdownIcon: false,
                    onTap: () async {
                      final v = await showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDatePickerDialog();
                        },
                      );
                      model.onChangeWarrentyExpiryDate(v);
                    },
                    value: model.warrentyExpiryDate != null
                        ? DateFormat('dd/MM/yyyy')
                            .format(model.warrentyExpiryDate!)
                        : null,
                  ),
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationField(
                  svgIconPath: AssetIcons.tfWarrentyPeriod,
                  labelText: 'Warrenty Period (in months)',
                  child: VehicleRegistrationSelectWidget(
                    hintText: '----',
                    isLoading: false,
                    showDropdownIcon: false,
                    onTap: () {},
                    value: model.warentyPeriodController.text.isNotEmpty
                        ? model.warentyPeriodController.text
                        : null,
                  ),
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationField(
                  svgIconPath: AssetIcons.tfStatus,
                  labelText: 'Status',
                  child: VehicleRegistrationSelectWidget(
                    hintText: 'Status',
                    isLoading: false,
                    onTap: () async {
                      final v = await showDialog(
                        context: context,
                        builder: (context) => VehicleStatusDialog(
                          title: 'Status',
                          onCancel: () {
                            Navigator.pop(context);
                          },
                          onConfirm: () {
                            Navigator.pop(
                              context,
                              model.selectedStatus,
                            );
                          },
                          model: model,
                        ),
                      );

                      model.onSelectStatus(v);
                    },
                    value: model.status != null
                        ? getReadableVehicleStatus(model.status!)
                        : null,
                  ),
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationTextField(
                  svgIconPath: AssetIcons.tfRegistrationNumber,
                  labelText: 'Registration Number',
                  controller: model.registrationNumberController,
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationTextField(
                  svgIconPath: AssetIcons.tfVin,
                  labelText: 'VIN',
                  controller: model.vinController,
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationTextField(
                  svgIconPath: AssetIcons.tfTankCapacity,
                  labelText: 'Tank Capacity',
                  controller: model.tankCapacityController,
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationTextField(
                  svgIconPath: AssetIcons.tfTankCapacity,
                  labelText: 'Tire Front',
                  controller: model.tireFrontController,
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationTextField(
                  svgIconPath: AssetIcons.tfTankCapacity,
                  labelText: 'Tire Rear',
                  controller: model.tireRearController,
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationTextField(
                  svgIconPath: AssetIcons.tfHorsePower,
                  labelText: 'Horsepower',
                  controller: model.horsePowerController,
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationField(
                  svgIconPath: AssetIcons.tfDate,
                  labelText: 'Last Service Date',
                  child: VehicleRegistrationSelectWidget(
                    hintText: 'Last Service Date',
                    isLoading: false,
                    showDropdownIcon: false,
                    onTap: () async {
                      final v = await showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDatePickerDialog();
                        },
                      );
                      model.onChangeLastServiceDate(v);
                    },
                    value: model.lastServiceDate != null
                        ? DateFormat('dd/MM/yyyy')
                            .format(model.lastServiceDate!)
                        : null,
                  ),
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationTextField(
                  svgIconPath: AssetIcons.tfServiceInterval,
                  labelText: 'Service Interval (in months)',
                  controller: model.serviceController,
                  hintText: 'Service Interval in months',
                  inputType: TextInputType.number,
                  textInputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationTextField(
                  svgIconPath: AssetIcons.tfOdometer,
                  labelText: 'Odometer Reading in KM',
                  controller: model.odometerReadingController,
                  inputType: TextInputType.number,
                  textInputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationTextField(
                  svgIconPath: AssetIcons.tfFuelConsumption,
                  labelText: 'Fuel Consumption (Km/L)',
                  controller: model.fuelConsumptionController,
                  inputType: TextInputType.number,
                  textInputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                VerticalSpacing(20.h),
                VehicleRegistrationTextField(
                  svgIconPath: AssetIcons.tfDailyDistance,
                  labelText: 'Daily Distance (Average) in KM',
                  controller: model.dailyDistanceController,
                  inputType: TextInputType.number,
                  textInputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AddView extends StatelessWidget {
  const AddView({
    Key? key,
    required this.action,
    required this.vehicle,
    required this.model,
  }) : super(key: key);

  final VehicleRegistrationAction action;
  final Vehicle? vehicle;
  final VehicleDetailViewModel model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: Container(
            height: context.screenSize().height * 0.30,
            width: context.screenSize().width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
              color: AppColors.white.withOpacity(0.1),
              image: action == VehicleRegistrationAction.edit
                  ? vehicle?.photoURL != null && model.selectedImage == null
                      ? DecorationImage(
                          image: NetworkImage(
                            vehicle!.photoURL!,
                          ),
                          fit: BoxFit.cover,
                          opacity: 0.5,
                        )
                      : model.selectedImage != null
                          ? DecorationImage(
                              image: Image.file(model.selectedImage!).image,
                              fit: BoxFit.cover,
                              opacity: 0.5,
                            )
                          : null
                  : model.selectedImage != null
                      ? DecorationImage(
                          image: Image.file(model.selectedImage!).image,
                          fit: BoxFit.cover,
                          opacity: 0.5,
                        )
                      : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    //TODO add image or whatever
                    model.onClickAddImage();
                  },
                  child: Container(
                    height: 60.sp,
                    width: 60.sp,
                    decoration: BoxDecoration(
                      gradient: AppColors.mainButtonGradient,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.add,
                      color: AppColors.white,
                      size: 40.sp,
                    ),
                  ),
                ),
                VerticalSpacing(10.h),
                Text(
                  'Add Image',
                  style: TextStyling.regular.copyWith(
                    fontSize: 12.sp,
                  ),
                )
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomAppBar(
              titleText: 'Vehicle Details',
            ),
            VerticalSpacing(context.screenSize().height * 0.225),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 27.w,
                  vertical: 10.h,
                ),
                child: Column(
                  children: [
                    VehicleRegistrationField(
                      svgIconPath: AssetIcons.tfManufacturor,
                      labelText: 'Manufacturer',
                      child: VehicleRegistrationSelectWidget(
                        hintText: 'Manufacturer',
                        isLoading: model.isManufacturersLoading,
                        onTap: () async {
                          final Manufacturor? v = await showModalBottomSheet(
                            constraints: BoxConstraints(
                              minHeight: context.screenSize().height * 0.8,
                            ),
                            context: context,
                            builder: (context) => ManufacturerBottomSheetView(),
                          );
                          print(v?.name);
                          model.onChangeManufacturer(v);
                        },
                        value: model.selectedManufacturer?.name,
                      ),
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationField(
                      svgIconPath: AssetIcons.tfModel,
                      labelText: 'Model',
                      child: VehicleRegistrationSelectWidget(
                        hintText: 'Model',
                        isLoading: model.isVehicleModelsLoading,
                        onTap: () async {
                          if (model.selectedManufacturer != null) {
                            final VehicleModel? v = await showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  VehicleModelBottomSheetView(),
                            );

                            model.onChangeVehicleModel(v);
                          } else {
                            Constants.customWarningSnack(
                                'Please select manufacturer first');
                          }
                        },
                        value: model.selectedVehicleModel?.model,
                      ),
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationField(
                      svgIconPath: AssetIcons.tfDate,
                      labelText: 'Manufacture Year',
                      child: VehicleRegistrationSelectWidget(
                        hintText: 'Select Manufacture Year',
                        isLoading: false,
                        showDropdownIcon: false,
                        onTap: () async {
                          final v = await showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDatePickerDialog(
                                allowViewChange: false,
                                view: DateRangePickerView.decade,
                              );
                            },
                          );
                          model.onChangeManufactureYear(v);
                        },
                        value: model.manufactureYear != null
                            ? '${model.manufactureYear!.year}'
                            : null,
                      ),
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationTextField(
                      svgIconPath: AssetIcons.tfPrice,
                      labelText: 'Price',
                      controller: model.priceController,
                      inputType: TextInputType.number,
                      textInputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,5}'),
                        )
                      ],
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationTextField(
                      svgIconPath: AssetIcons.tfDescription,
                      labelText: 'Description',
                      multiline: true,
                      controller: model.descriptionController,
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationField(
                      // labelText: 'Model',
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow:
                                        AppColors.vehicleRegTextFieldBoxShadows,
                                  ),
                                  height: 50.h,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Primary Vehicle',
                                        style: TextStyling.medium.copyWith(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              HorizontalSpacing(10.w),
                              Checkbox(
                                value: model.isPrimaryVehicle,
                                onChanged: (v) {
                                  model.toggleIsPrimaryVehicle(v);
                                },
                                activeColor: AppColors.appSkyBlue,
                                side: BorderSide(
                                  color: AppColors.appSkyBlue,
                                ),
                              ),
                            ],
                          ),
                          VerticalSpacing(10.h),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow:
                                        AppColors.vehicleRegTextFieldBoxShadows,
                                  ),
                                  height: 50.h,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'In Use',
                                        style: TextStyling.medium.copyWith(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              HorizontalSpacing(10.w),
                              Checkbox(
                                value: model.isInUse,
                                onChanged: (v) {
                                  model.toggleIsInUse(v);
                                },
                                activeColor: AppColors.appSkyBlue,
                                side: BorderSide(
                                  color: AppColors.appSkyBlue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationField(
                      svgIconPath: AssetIcons.tfDate,
                      labelText: 'Purchase Date',
                      child: VehicleRegistrationSelectWidget(
                        hintText: 'Purchase Date',
                        isLoading: false,
                        showDropdownIcon: false,
                        onTap: () async {
                          final v = await showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDatePickerDialog();
                            },
                          );
                          model.onChangePurchaseDate(v);
                        },
                        value: model.purchaseDate != null
                            ? DateFormat('dd/MM/yyyy')
                                .format(model.purchaseDate!)
                            : null,
                      ),
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationField(
                      svgIconPath: AssetIcons.tfDate,
                      labelText: 'Warranty Expiry Date',
                      child: VehicleRegistrationSelectWidget(
                        hintText: 'Add Warranty Expiry Date',
                        isLoading: false,
                        showDropdownIcon: false,
                        onTap: () async {
                          final v = await showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDatePickerDialog();
                            },
                          );
                          model.onChangeWarrentyExpiryDate(v);
                        },
                        value: model.warrentyExpiryDate != null
                            ? DateFormat('dd/MM/yyyy')
                                .format(model.warrentyExpiryDate!)
                            : null,
                      ),
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationField(
                      svgIconPath: AssetIcons.tfWarrentyPeriod,
                      labelText: 'Warrenty Period (in months)',
                      child: VehicleRegistrationSelectWidget(
                        hintText: '----',
                        isLoading: false,
                        showDropdownIcon: false,
                        onTap: () {},
                        value: model.warentyPeriodController.text.isNotEmpty
                            ? model.warentyPeriodController.text
                            : null,
                      ),
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationField(
                      svgIconPath: AssetIcons.tfStatus,
                      labelText: 'Status',
                      child: VehicleRegistrationSelectWidget(
                        hintText: 'Status',
                        isLoading: false,
                        onTap: () async {
                          final v = await showDialog(
                            context: context,
                            builder: (context) => VehicleStatusDialog(
                              title: 'Status',
                              onCancel: () {
                                Navigator.pop(context);
                              },
                              onConfirm: () {
                                Navigator.pop(
                                  context,
                                  model.selectedStatus,
                                );
                              },
                              model: model,
                            ),
                          );

                          model.onSelectStatus(v);
                        },
                        value: model.status != null
                            ? getReadableVehicleStatus(model.status!)
                            : null,
                      ),
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationTextField(
                      svgIconPath: AssetIcons.tfRegistrationNumber,
                      labelText: 'Registration Number',
                      controller: model.registrationNumberController,
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationTextField(
                      svgIconPath: AssetIcons.tfVin,
                      labelText: 'VIN',
                      controller: model.vinController,
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationTextField(
                      svgIconPath: AssetIcons.tfTankCapacity,
                      labelText: 'Tank Capacity',
                      controller: model.tankCapacityController,
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationTextField(
                      svgIconPath: AssetIcons.tfTankCapacity,
                      labelText: 'Tire Front',
                      controller: model.tireFrontController,
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationTextField(
                      svgIconPath: AssetIcons.tfTankCapacity,
                      labelText: 'Tire Rear',
                      controller: model.tireRearController,
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationTextField(
                      svgIconPath: AssetIcons.tfHorsePower,
                      labelText: 'Horsepower',
                      controller: model.horsePowerController,
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationField(
                      svgIconPath: AssetIcons.tfDate,
                      labelText: 'Last Service Date',
                      child: VehicleRegistrationSelectWidget(
                        hintText: 'Last Service Date',
                        isLoading: false,
                        showDropdownIcon: false,
                        onTap: () async {
                          final v = await showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDatePickerDialog();
                            },
                          );
                          model.onChangeLastServiceDate(v);
                        },
                        value: model.lastServiceDate != null
                            ? DateFormat('dd/MM/yyyy')
                                .format(model.lastServiceDate!)
                            : null,
                      ),
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationTextField(
                      svgIconPath: AssetIcons.tfServiceInterval,
                      labelText: 'Service Interval (in months)',
                      controller: model.serviceController,
                      hintText: 'Service Interval in months',
                      inputType: TextInputType.number,
                      textInputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationTextField(
                      svgIconPath: AssetIcons.tfOdometer,
                      labelText: 'Odometer Reading in KM',
                      controller: model.odometerReadingController,
                      inputType: TextInputType.number,
                      textInputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationTextField(
                      svgIconPath: AssetIcons.tfFuelConsumption,
                      labelText: 'Fuel Consumption (Km/L)',
                      controller: model.fuelConsumptionController,
                      inputType: TextInputType.number,
                      textInputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationTextField(
                      svgIconPath: AssetIcons.tfDailyDistance,
                      labelText: 'Daily Distance (Average) in KM',
                      controller: model.dailyDistanceController,
                      inputType: TextInputType.number,
                      textInputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class VehicleStatusDialog extends StatefulWidget {
  final String title;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  final VehicleDetailViewModel model;

  VehicleStatusDialog(
      {required this.title,
      required this.onCancel,
      required this.onConfirm,
      required this.model});

  @override
  State<VehicleStatusDialog> createState() => _VehicleStatusDialogState();
}

class _VehicleStatusDialogState extends State<VehicleStatusDialog> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background blur effect
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            decoration: BoxDecoration(
                // gradient: AppColors.homeButtonGradient,
                // color: Colors.black.withOpacity(0.5),
                ),
            constraints: BoxConstraints.expand(),
          ),
        ),
        // Dialog content
        AlertDialog(
          backgroundColor: AppColors.grey.withOpacity(0.7),
          title: Text(widget.title),
          titleTextStyle: TextStyling.bold.copyWith(fontSize: 18.sp),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: vehicleStatusButtons.map((e) {
              return GestureDetector(
                onTap: () {
                  widget.model.toggleStatus(e.status);
                  setState(() {});
                },
                child: Container(
                  height: 100,
                  // width: 90.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                    vertical: 15.w,
                  ),

                  decoration: BoxDecoration(
                    color: widget.model.selectedStatus != null &&
                            widget.model.selectedStatus == e.status
                        ? AppColors.appFaddedBlue
                        : null,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        e.iconPath,
                        height: 30.h,
                      ),
                      Text(
                        getReadableVehicleStatus(e.status),
                        style: TextStyling.regular.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: widget.onCancel,
              child: Text(
                'Cancel',
                style: TextStyling.semiBold.copyWith(
                  color: AppColors.appDarkBlue,
                  fontSize: 14.sp,
                ),
              ),
            ),
            TextButton(
              onPressed: widget.onConfirm,
              child: Text(
                'Confirm',
                style: TextStyling.semiBold.copyWith(
                  color: AppColors.appSkyBlue,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MainOutlinedButton extends StatelessWidget {
  const MainOutlinedButton({
    Key? key,
    required this.onTap,
    required this.buttonText,
  }) : super(key: key);

  final VoidCallback onTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
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
      onPressed: onTap,
      child: Text(
        buttonText,
        style: TextStyling.medium.copyWith(
          fontSize: 18.sp,
        ),
      ),
    );
  }
}
