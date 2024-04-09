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
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/custom_datepicker_dialog.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/spacing.dart';
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
          child: MainButton(
            buttonText: action == VehicleRegistrationAction.add
                ? 'Add Vehicle'
                : 'Save',
            onPressed: model.updateOrInsertVehicle,
            isLoading: model.isBusy,
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
          child: Stack(
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
                        ? vehicle?.photoURL != null &&
                                model.selectedImage == null
                            ? DecorationImage(
                                image: NetworkImage(
                                  vehicle!.photoURL!,
                                ),
                                fit: BoxFit.cover,
                                opacity: 0.5,
                              )
                            : model.selectedImage != null
                                ? DecorationImage(
                                    image:
                                        Image.file(model.selectedImage!).image,
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
                  VerticalSpacing(context.screenSize().height * 0.23),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 27.w,
                        vertical: 10.h,
                      ),
                      child: Column(
                        children: [
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.tfDescription,
                            labelText: 'Description',
                            multiline: true,
                            controller: model.descriptionController,
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
                          VehicleRegistrationField(
                            svgIconPath: AssetIcons.tfManufacturor,
                            labelText: 'Manufacturer',
                            child: VehicleRegistrationSelectWidget(
                              hintText: 'Manufacturer',
                              isLoading: model.isManufacturersLoading,
                              onTap: () async {
                                final Manufacturor? v =
                                    await showModalBottomSheet(
                                  constraints: BoxConstraints(
                                    minHeight:
                                        context.screenSize().height * 0.8,
                                  ),
                                  context: context,
                                  builder: (context) =>
                                      ManufacturerBottomSheetView(),
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
                                  final VehicleModel? v =
                                      await showModalBottomSheet(
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
                            // labelText: 'Model',
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          boxShadow: AppColors
                                              .vehicleRegTextFieldBoxShadows,
                                        ),
                                        height: 50.h,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Primary Vehicle',
                                              style:
                                                  TextStyling.medium.copyWith(
                                                fontSize: 15.sp,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          boxShadow: AppColors
                                              .vehicleRegTextFieldBoxShadows,
                                        ),
                                        height: 50.h,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              'In Use',
                                              style:
                                                  TextStyling.medium.copyWith(
                                                fontSize: 15.sp,
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
                            svgIconPath: AssetIcons.tfDailyDistance,
                            labelText: 'Daily Distance (Average) in KM',
                            controller: model.dailyDistanceController,
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
                            svgIconPath: AssetIcons.tfHorsePower,
                            labelText: 'Horsepower',
                            controller: model.horsePowerController,
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
                          VehicleRegistrationField(
                            svgIconPath: AssetIcons.tfWarrentyPeriod,
                            labelText: 'Warrenty Period (in months)',
                            child: VehicleRegistrationSelectWidget(
                              hintText: '----',
                              isLoading: false,
                              showDropdownIcon: false,
                              onTap: () {},
                              value:
                                  model.warentyPeriodController.text.isNotEmpty
                                      ? model.warentyPeriodController.text
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
