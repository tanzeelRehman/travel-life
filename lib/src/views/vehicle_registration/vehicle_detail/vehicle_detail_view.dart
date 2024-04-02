import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/vehicle.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/shared/vehicle_registration_textfield.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/vehicle_registration/vehicle_detail/vehicle_detail_view_model.dart';

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
            buttonText: 'Save & Next',
            onPressed: () {},
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
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        'https://imgd.aeplcdn.com/370x208/n/cw/ec/130591/fronx-exterior-right-front-three-quarter-109.jpeg?isig=0&q=80',
                      ),
                      fit: BoxFit.cover,
                      opacity: 0.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //TODO add image or whatever
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
                          ),
                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.tfManufacturor,
                            labelText: 'Manufacturer',
                          ),
                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.tfDate,
                            labelText: 'Purchase Date',
                          ),

                          //TODO: VehicleRegistrationField with checkboxes for primaryVehicle and inuse

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
                          ),

                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.tfDate,
                            labelText: 'Last Service Date',
                          ),

                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.tfDailyDistance,
                            labelText: 'Daily Distance (Average)',
                            controller: model.dailyDistanceController,
                          ),

                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.tfOdometer,
                            labelText: 'Odometer Reading',
                            controller: model.odometerReadingController,
                          ),

                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.tfStatus,
                            labelText: 'Status',
                          ),

                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.tfDate,
                            labelText: 'Manufacture Year',
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
                            labelText: 'Fuel Consumption',
                            controller: model.fuelConsumptionController,
                          ),

                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.tfWarrentyPeriod,
                            labelText: 'Warranty Period(in months)',
                            controller: model.warentyPeriodController,
                          ),

                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.tfDate,
                            labelText: 'Warranty Expiry Date',
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
