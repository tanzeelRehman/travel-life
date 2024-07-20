import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart';
import 'package:starter_app/src/base/enums/vehicle_status.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/manufacturor.dart';
import 'package:starter_app/src/models/vehicle.dart';
import 'package:starter_app/src/models/vehicle_model.dart';
import 'package:starter_app/src/shared/accessory_card.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/custom_datepicker_dialog.dart';
import 'package:starter_app/src/shared/custom_tab.dart';
import 'package:starter_app/src/shared/empty_state_widget.dart';
import 'package:starter_app/src/shared/loading_indicator.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/main_outlined_button.dart';
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
import 'package:starter_app/src/views/dialogs/vehicle_status_dialog.dart';
import 'package:starter_app/src/views/vehicle_registration/vehicle_detail/vehicle_detail_view_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

//TODO: DIVIDE THIS FILE INTO SUB VIEWS (i.e more files)

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

//////////////////////////////////////////// EDIT VIEW ////////////////////////////////
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
  switch (selectedTab) {
    case 0:
      return MainButton(
        buttonText: 'Save',
        onPressed: model.updateOrInsertVehicle,
        isLoading: model.isBusy,
      );
    case 1:
      return MainOutlinedButton(
        onPressed: () {
          model.onInsertAccessory(vehicle);
        },
        buttonText: 'Add Accessory',
        height: 60.h,
      );
    case 2:
      return MainOutlinedButton(
        onPressed: () {
          model.onInsertOperatingCost(vehicle);
        },
        buttonText: 'Add Cost',
        height: 60.h,
      );
    default:
      return SizedBox.shrink();
  }
}

///////////////// OPERATIONAL COST TAB ////////////////////
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

/////////////// ACCESSORIES TAB ///////////////

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

////////////////////////// DETAILS TAB //////////////////////////

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
                    showIcon: false,
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
                    showIcon: false,
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
                    showIcon: false,
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
                    showIcon: false,
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
                    showIcon: false,
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

////////////////////////// ADD VIEW ////////////////////////
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
                        showIcon: false,
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
                        showIcon: false,
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
                        showIcon: false,
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
                        showIcon: false,
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
                        showIcon: false,
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
