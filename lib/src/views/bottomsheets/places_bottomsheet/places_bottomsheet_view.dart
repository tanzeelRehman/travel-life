import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/shared/loading_indicator.dart';
import 'package:starter_app/src/shared/regular_textfield.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/bottomsheets/places_bottomsheet/places_bottomsheet_view_model.dart';

class PlacesBottomSheetView extends StackedView<PlacesBottomSheetViewModel> {
  @override
  Widget builder(
      BuildContext context, PlacesBottomSheetViewModel model, Widget? child) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.appFaddedBlue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          RegularTextFeild(
            hintText: 'Search Places',
            onChanged: (val) {
              model.onChanged();
            },
            fillColor: AppColors.appDarkBlue.withOpacity(0.3),
            controller: model.searchController,
            textStyle: TextStyling.regular.copyWith(
              fontSize: 14.sp,
            ),
          ),
          VerticalSpacing(10.h),
          Expanded(
            child: model.isBusy
                ? Center(child: LoadingIndicator())
                : model.places.isNotEmpty
                    ? ListView.separated(
                        separatorBuilder: (context, i) {
                          return VerticalSpacing(10.h);
                        },
                        shrinkWrap: true,
                        itemCount: model.places.length,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(context, model.places[i]);
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      model.places[i].properties?.label ?? '',
                                      style: TextStyling.medium.copyWith(
                                        fontSize: 14.sp,
                                        // color: AppColors.black,
                                      ),
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
                          'No Results Found',
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
  PlacesBottomSheetViewModel viewModelBuilder(BuildContext context) =>
      PlacesBottomSheetViewModel();

  @override
  void onViewModelReady(PlacesBottomSheetViewModel model) => model.init();
}
