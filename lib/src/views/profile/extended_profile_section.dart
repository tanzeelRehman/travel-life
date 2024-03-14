import 'package:csc_picker/csc_picker.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:starter_app/src/shared/profile_textfield.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/profile/profile_view_model.dart';

class ExtendedProfileSection extends StatelessWidget {
  const ExtendedProfileSection({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ProfileViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalSpacing(10.h),
        Text(
          'Residential Information',
          style: TextStyling.medium.copyWith(
            color: AppColors.white.withOpacity(0.7),
            fontSize: 18.sp,
          ),
        ),
        VerticalSpacing(24.h),
        ProfileTextField(
          controller: model.addressController,
          title: 'Address',
        ),
        VerticalSpacing(16.h),
        Text(
          'Country, City and State',
          style: TextStyling.medium.copyWith(
            color: AppColors.white.withOpacity(0.7),
            fontSize: 12.sp,
          ),
        ),
        VerticalSpacing(10.h),
        Theme(
          data: context.theme.copyWith(
            dialogBackgroundColor: Colors.lightBlue.shade100,
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.appSkyBlue.withOpacity(0.5),
                ),
              ),
            ),
          ),
          child: CSCPicker(
            showStates: true,

            showCities: true,

            flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,

            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.r),
              ),
              border: Border.all(
                color: AppColors.appSkyBlue.withOpacity(0.5),
              ),
            ),

            disabledDropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
                width: 1,
              ),
            ),

            ///placeholders for dropdown search field
            countrySearchPlaceholder: "Country",
            stateSearchPlaceholder: "State",
            citySearchPlaceholder: "City",

            ///labels for dropdown
            countryDropdownLabel: "Country",
            stateDropdownLabel: "State",
            cityDropdownLabel: "City",
            selectedItemStyle: TextStyling.bold.copyWith(
              fontSize: 15.sp,
            ),

            dropdownHeadingStyle: TextStyling.bold.copyWith(
              fontSize: 18.sp,
              color: AppColors.appDarkBlue,
            ),

            dropdownItemStyle: TextStyling.medium.copyWith(
              color: AppColors.appDarkBlue,
              fontSize: 14,
            ),

            ///Dialog box radius [OPTIONAL PARAMETER]
            dropdownDialogRadius: 10.0,
            layout: Layout.vertical,

            ///Search bar radius [OPTIONAL PARAMETER]
            searchBarRadius: 10.0,

            onCountryChanged: (value) {
              model.countryController.text = value;
            },

            onStateChanged: (value) {
              if (value != null) {
                model.stateController.text = value;
              }
            },

            onCityChanged: (value) {
              if (value != null) {
                model.cityController.text = value;
              }
            },
            currentCountry: model.countryController.text.isNotEmpty
                ? model.countryController.text
                : null,
            currentCity: model.cityController.text.isNotEmpty
                ? model.cityController.text
                : null,
            currentState: model.stateController.text.isNotEmpty
                ? model.stateController.text
                : null,
          ),
        ),
        VerticalSpacing(16.h),
        ProfileTextField(
          controller: model.zipCodeController,
          title: 'Zip',
          textInputType: TextInputType.number,
        ),
        VerticalSpacing(24.h),
        Text(
          'More',
          style: TextStyling.regular.copyWith(
            color: AppColors.white.withOpacity(0.7),
            fontSize: 18.sp,
          ),
        ),
        VerticalSpacing(24.h),
        ProfileTextField(
          controller: model.websiteController,
          title: 'Website',
        ),
        VerticalSpacing(10.h),
        ProfileTextField(
          controller: model.currencyController,
          title: 'Currency',
          readOnly: true,
          suffixIcon: IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            style: IconButton.styleFrom(
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () async {
              showCurrencyPicker(
                theme: CurrencyPickerThemeData(
                  backgroundColor: AppColors.appDarkBlue.withOpacity(1),
                  titleTextStyle: TextStyling.bold.copyWith(
                    fontSize: 14.sp,
                  ),
                  currencySignTextStyle: TextStyling.bold.copyWith(
                    fontSize: 18.sp,
                  ),
                  subtitleTextStyle: TextStyling.medium.copyWith(
                    fontSize: 12.sp,
                  ),
                  bottomSheetHeight: context.height * 0.7,
                  inputDecoration: InputDecoration(
                    fillColor: AppColors.lightGrey,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 27.w,
                    ),
                    hintStyle: TextStyling.thin.copyWith(),
                    labelStyle: TextStyling.thin,
                  ),
                ),
                showFlag: true,
                showCurrencyName: true,
                showCurrencyCode: true,
                context: context,
                onSelect: (v) {
                  model.currencyController.text = v.code;
                },
              );
            },
            icon: Icon(
              Icons.search,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
