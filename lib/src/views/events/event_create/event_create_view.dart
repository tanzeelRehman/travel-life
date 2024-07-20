import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/event_action.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/event.dart';
import 'package:starter_app/src/models/ors_models/get_geocode_response_model.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/custom_datepicker_dialog.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/shared/vehicle_registration_field.dart';
import 'package:starter_app/src/shared/vehicle_registration_select_widget.dart';
import 'package:starter_app/src/shared/vehicle_registration_textfield.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/bottomsheets/places_bottomsheet/places_bottomsheet_view.dart';
import 'package:starter_app/src/views/events/event_create/event_create_view_model.dart';

class EventCreateView extends StackedView<EventCreateViewModel> {
  final EventAction action;
  final Event? event;
  EventCreateView({
    required this.action,
    required this.event,
  });

  @override
  Widget builder(
    BuildContext context,
    EventCreateViewModel model,
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
            buttonText: action == EventAction.add ? 'Create Trip' : 'Save',
            onPressed: model.updateOrInsertEvent,
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
              // Positioned(
              //   top: 0,
              //   child: Container(
              //     height: context.screenSize().height * 0.30,
              //     width: context.screenSize().width,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.only(
              //         bottomLeft: Radius.circular(20.r),
              //         bottomRight: Radius.circular(20.r),
              //       ),
              //       color: AppColors.white.withOpacity(0.1),
              //       image: action == EventAction.edit
              //           ? event?.coverImage != null &&
              //                   model.selectedImage == null
              //               ? DecorationImage(
              //                   image: NetworkImage(
              //                     event!.coverImage!,
              //                   ),
              //                   fit: BoxFit.cover,
              //                   opacity: 0.5,
              //                 )
              //               : model.selectedImage != null
              //                   ? DecorationImage(
              //                       image:
              //                           Image.file(model.selectedImage!).image,
              //                       fit: BoxFit.cover,
              //                       opacity: 0.5,
              //                     )
              //                   : null
              //           : model.selectedImage != null
              //               ? DecorationImage(
              //                   image: Image.file(model.selectedImage!).image,
              //                   fit: BoxFit.cover,
              //                   opacity: 0.5,
              //                 )
              //               : null,
              //     ),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         VerticalSpacing(40.h), //TODO: for extra space
              //         GestureDetector(
              //           onTap: () {
              //             //TODO add image or whatever
              //             model.onClickAddImage();
              //           },
              //           child: Container(
              //             height: 60.sp,
              //             width: 60.sp,
              //             decoration: BoxDecoration(
              //               gradient: AppColors.mainButtonGradient,
              //               borderRadius: BorderRadius.circular(10.r),
              //             ),
              //             child: Icon(
              //               Icons.add,
              //               color: AppColors.white,
              //               size: 40.sp,
              //             ),
              //           ),
              //         ),
              //         VerticalSpacing(10.h),
              //         Text(
              //           'Add Image',
              //           style: TextStyling.regular.copyWith(
              //             fontSize: 12.sp,
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomAppBar(
                    titleText:
                        action == EventAction.add ? 'Create Trip' : 'Edit Trip',
                  ),
                  // VerticalSpacing(context.screenSize().height * 0.23),
                  VerticalSpacing(20.h),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 27.w,
                        vertical: 10.h,
                      ),
                      child: Column(
                        children: [
                          VehicleRegistrationTextField(
                            svgIconPath: AssetIcons.groupNameIcon,
                            labelText: 'Name',
                            controller: model.nameController,
                          ),
                          VerticalSpacing(20.h),
                          Row(
                            children: [
                              Expanded(
                                child:
                                    // VehicleRegistrationField(
                                    //   svgIconPath: AssetIcons.tfDate,
                                    //   labelText: 'Start Date',

                                    //   child:

                                    Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 10.h,
                                  ),
                                  // decoration: BoxDecoration(
                                  //   border: Border.all(
                                  //     color:
                                  //         AppColors.lightGrey.withOpacity(0.5),
                                  //   ),
                                  //   borderRadius: BorderRadius.circular(10.r),
                                  // ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            AssetIcons.tfDate,
                                            height: 20.h,
                                          ),
                                          HorizontalSpacing(10.w),
                                          Text(
                                            'Start Date',
                                            style: TextStyling.regular.copyWith(
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      VerticalSpacing(10.h),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.lightGrey
                                                .withOpacity(0.5),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: VehicleRegistrationSelectWidget(
                                          hintText: 'Start Date',
                                          isLoading: false,
                                          showIcon: false,
                                          onTap: () async {
                                            final v = await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return CustomDatePickerDialog(
                                                  minDate: DateTime.now(),
                                                );
                                              },
                                            );
                                            model.onChangeStartDate(v);
                                          },
                                          value: model.startDateController.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // ),
                              ),
                              HorizontalSpacing(20.w),
                              Expanded(
                                child:
                                    // VehicleRegistrationField(
                                    //   svgIconPath: AssetIcons.tfDate,
                                    //   labelText: 'End Date',

                                    //   child:

                                    Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 10.h,
                                  ),
                                  // decoration: BoxDecoration(
                                  //   border: Border.all(
                                  //     color:
                                  //         AppColors.lightGrey.withOpacity(0.5),
                                  //   ),
                                  //   borderRadius: BorderRadius.circular(10.r),
                                  // ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            AssetIcons.tfDate,
                                            height: 20.h,
                                          ),
                                          HorizontalSpacing(10.w),
                                          Text(
                                            'End Date',
                                            style: TextStyling.regular.copyWith(
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      VerticalSpacing(10.h),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.lightGrey
                                                .withOpacity(0.5),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: VehicleRegistrationSelectWidget(
                                          hintText: 'End Date',
                                          isLoading: false,
                                          showIcon: false,
                                          onTap: () async {
                                            if (model.startDate == null) {
                                              return;
                                            }
                                            final v = await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return CustomDatePickerDialog(
                                                  minDate: model.startDate,
                                                );
                                              },
                                            );
                                            model.onChangeEndDate(v);
                                          },
                                          value: model.endDateController.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // ),
                              ),
                            ],
                          ),
                          VerticalSpacing(20.h),
                          // VehicleRegistrationTextField(
                          //   svgIconPath: AssetIcons.locationIcon,
                          //   labelText: 'Destination',
                          //   multiline: false,
                          //   controller: model.destinationController,
                          // ),
                          VehicleRegistrationField(
                            svgIconPath: AssetIcons.locationIcon,
                            labelText: 'Destination',
                            child: VehicleRegistrationSelectWidget(
                              hintText: 'Destination',
                              isLoading: false,
                              showIcon: true,
                              onTap: () async {
                                final Features? v = await showModalBottomSheet(
                                  constraints: BoxConstraints(
                                    minHeight:
                                        context.screenSize().height * 0.8,
                                  ),
                                  context: context,
                                  builder: (context) => PlacesBottomSheetView(),
                                );
                                print(v?.properties?.label);
                                model.onChangeDestination(v);
                              },
                              value: model.destinationController.text,
                            ),
                          ),
                          VerticalSpacing(20.h),
                          VehicleRegistrationTextField(
                            height: 200.h,
                            svgIconPath: AssetIcons.tfDescription,
                            labelText: 'Description',
                            multiline: true,
                            controller: model.descriptionController,
                          ),
                          VerticalSpacing(20.h),
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
  EventCreateViewModel viewModelBuilder(BuildContext context) =>
      EventCreateViewModel();

  @override
  void onViewModelReady(EventCreateViewModel model) =>
      model.init(action, event);
}
