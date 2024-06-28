import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/ors_models/get_geocode_response_model.dart';
import 'package:starter_app/src/models/waypoint.dart';
import 'package:starter_app/src/shared/custom_datepicker_dialog.dart';
import 'package:starter_app/src/shared/loading_indicator.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/regular_textfield.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/shared/vehicle_registration_select_widget.dart';
import 'package:starter_app/src/shared/vehicle_registration_textfield.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/bottomsheets/add_waypoint_bottomsheet/add_waypoint_bottomsheet_view_model.dart';
import 'package:starter_app/src/views/bottomsheets/places_bottomsheet/places_bottomsheet_view.dart';

class AddWaypointBottomSheetView
    extends StackedView<AddWaypointBottomSheetViewModel> {
  @override
  Widget builder(BuildContext context, AddWaypointBottomSheetViewModel model,
      Widget? child) {
    return Container(
      height: context.screenSize().height * 0.8,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.appFaddedBlue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
      ),
      padding: EdgeInsets.all(16.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Add a waypoint',
                style: TextStyling.bold.copyWith(
                  fontSize: 16.sp,
                ),
              ),
            ),
            VerticalSpacing(20.h),
            Text(
              'Destination',
              style: TextStyling.regular.copyWith(
                fontSize: 12.sp,
              ),
            ),
            VerticalSpacing(5.h),
            VehicleRegistrationSelectWidget(
              hintText: 'Destination',
              isLoading: false,
              showIcon: true,
              border: Border.all(
                color: AppColors.appSkyBlue,
              ),
              borderRadius: BorderRadius.circular(10.r),
              onTap: () async {
                final Features? v = await showModalBottomSheet(
                  constraints: BoxConstraints(
                    minHeight: context.screenSize().height * 0.8,
                  ),
                  context: context,
                  builder: (context) => PlacesBottomSheetView(),
                );
                print(v?.properties?.label);
                model.onChangeDestination(v);
              },
              hintTextColor: AppColors.white,
              hintTextEmptyStateColor: AppColors.white.withOpacity(0.5),
              value: model.destinationController.text,
            ),
            VerticalSpacing(20.h),
            Text(
              'Arrival Time',
              style: TextStyling.regular.copyWith(
                fontSize: 12.sp,
              ),
            ),
            VerticalSpacing(5.h),
            VehicleRegistrationSelectWidget(
              hintText: 'Arival Time',
              isLoading: false,
              border: Border.all(
                color: AppColors.appSkyBlue,
              ),
              icon: Icon(
                Icons.date_range,
                color: AppColors.appSkyBlue,
                size: 20.sp,
              ),
              borderRadius: BorderRadius.circular(10.r),
              onTap: () async {
                final v = await showDialog(
                  context: context,
                  builder: (context) {
                    return CustomDatePickerDialog(
                      minDate: DateTime.now(),
                    );
                  },
                );
                model.onChangeArrivalTime(v);
              },
              value: model.arivalTimeController.text,
              hintTextColor: AppColors.white,
              hintTextEmptyStateColor: AppColors.white.withOpacity(0.5),
            ),
            VerticalSpacing(20.h),
            Text(
              'Description',
              style: TextStyling.regular.copyWith(
                fontSize: 12.sp,
              ),
            ),
            VerticalSpacing(5.h),
            SizedBox(
              height: 100.h,
              child: RegularTextFeild(
                hintText: 'Description',
                controller: model.descriptionController,
                isMultiLine: true,
                fillColor: Colors.transparent,
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 0.1,
                ),
              ),
            ),
            VerticalSpacing(20.h),
            MainButton(
              buttonText: 'Add',
              onPressed: () {
                Navigator.pop(
                  context,
                  (model.destLat != null &&
                          model.destLong != null &&
                          model.destinationController.text.isNotEmpty)
                      ? Waypoint(
                          description: model.descriptionController.text,
                          endTime: model.arrivalTime.add(Duration()),
                          startTime: model.arrivalTime,
                          noOfDays: 1,
                          lat: model.destLat,
                          long: model.destLong,
                          label: model.destinationController.text,
                        )
                      : null,
                );
              },
              isLoading: false,
            ),
          ],
        ),
      ),
    );
  }

  @override
  AddWaypointBottomSheetViewModel viewModelBuilder(BuildContext context) =>
      AddWaypointBottomSheetViewModel();

  @override
  void onViewModelReady(AddWaypointBottomSheetViewModel model) => model.init();
}
