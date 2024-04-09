import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomDatePickerDialog extends StatelessWidget {
  const CustomDatePickerDialog({
    Key? key,
    this.view = DateRangePickerView.month,
    this.allowViewChange = true,
    this.initialSelectedDate,
    this.minDate,
    this.maxDate,
  }) : super(key: key);

  final DateRangePickerView view;
  final bool allowViewChange;
  final DateTime? initialSelectedDate;
  final DateTime? minDate;
  final DateTime? maxDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              color: AppColors.appDarkBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(10),
            child: SfDateRangePicker(
              rangeTextStyle: TextStyling.bold.copyWith(fontSize: 16.sp),
              headerStyle: DateRangePickerHeaderStyle(
                textAlign: TextAlign.center,
                textStyle: TextStyling.bold.copyWith(
                  fontSize: 10.sp,
                  color: AppColors.white,
                ),
              ),
              showActionButtons: false,
              allowViewNavigation: allowViewChange,
              monthCellStyle: DateRangePickerMonthCellStyle(
                textStyle: TextStyling.medium.copyWith(
                  color: AppColors.white,
                  fontSize: 10.sp,
                ),
                todayTextStyle: TextStyling.medium.copyWith(
                  color: AppColors.white,
                  fontSize: 10.sp,
                ),
              ),
              maxDate: maxDate,
              minDate: minDate,
              initialSelectedDate: initialSelectedDate,
              monthViewSettings: DateRangePickerMonthViewSettings(),
              yearCellStyle: DateRangePickerYearCellStyle(
                textStyle: TextStyling.medium.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.white,
                ),
                todayTextStyle: TextStyling.bold.copyWith(
                  fontSize: 10.sp,
                ),
              ),
              // showTodayButton: false,
              // todayHighlightColor: AppColors.white,
              view: view,
              selectionMode: DateRangePickerSelectionMode.single,
              backgroundColor: AppColors.appDarkBlue,
              selectionColor: AppColors.appSkyBlue,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs v) {
                // model.onChangeSelectedYear(v.value);
                Navigator.pop(context, v.value);
              },
              onSubmit: (v) {
                Navigator.pop(context, v);
              },
            ),
          ),
        ],
      ),
    );
  }
}
