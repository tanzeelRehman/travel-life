import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/shared/vehicle_registration_textfield.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/views/vehicle_registration/accessory_detail/accessory_detail_view_model.dart';

class AccessoryDetailView extends StackedView<AccessoryDetailViewModel> {
  final VehicleRegistrationAction action;

  AccessoryDetailView({required this.action});

  @override
  Widget builder(
    BuildContext context,
    AccessoryDetailViewModel model,
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
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomAppBar(
                    titleText: 'Accessorry Details',
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
                            svgIconPath: AssetIcons.tfCategory,
                            labelText: 'Category',
                            multiline: true,
                          ),
                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.tfDescription,
                            labelText: 'Description',
                            multiline: true,
                            controller: model.descriptionController,
                          ),
                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.tfDate,
                            labelText: 'Purchase Date',
                          ),
                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.tfVat,
                            labelText: 'VAT',
                            controller: model.vatController,
                          ),
                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.tfPriceHand,
                            labelText: 'Price',
                            controller: model.priceController,
                          ),
                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.tfAttachment,
                            labelText: 'Add Attachment',
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
  AccessoryDetailViewModel viewModelBuilder(BuildContext context) =>
      AccessoryDetailViewModel();

  @override
  void onViewModelReady(AccessoryDetailViewModel model) => model.init();
}
