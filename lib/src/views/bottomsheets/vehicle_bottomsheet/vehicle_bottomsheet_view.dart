import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/regular_textfield.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/bottomsheets/vehicle_bottomsheet/vehicle_bottomsheet_view_model.dart';

class VehicleBottomSheetView extends StackedView<VehicleBottomSheetViewModel> {
  @override
  Widget builder(
      BuildContext context, VehicleBottomSheetViewModel model, Widget? child) {
    return Container(
      height: context.screenSize().height * 0.6,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.appFaddedBlue,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          RegularTextFeild(
            hintText: 'Search Vehicle Model',
            onChanged: (val) {
              model.onSearch(val);
            },
            fillColor: AppColors.appDarkBlue.withOpacity(0.3),
            controller: model.searchController,
            textStyle: TextStyling.regular.copyWith(
              fontSize: 14.sp,
            ),
          ),
          VerticalSpacing(10.h),
          Expanded(
            child: model.vehicleModels.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, i) {
                      return VerticalSpacing(10.h);
                    },
                    shrinkWrap: true,
                    itemCount: model.vehicleModels.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(context, model.vehicleModels[i]);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          height: 45.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.lightGrey.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                model.vehicleModels[i].model?.model
                                        ?.toString() ??
                                    '',
                                style: TextStyling.medium.copyWith(
                                  fontSize: 14.sp,
                                  // color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'No Vehicles Found',
                      style: TextStyling.medium.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.black,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  VehicleBottomSheetViewModel viewModelBuilder(BuildContext context) =>
      VehicleBottomSheetViewModel();

  @override
  void onViewModelReady(VehicleBottomSheetViewModel model) => model.init();
}
