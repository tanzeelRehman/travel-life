import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/event_action.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/event.dart';
import 'package:starter_app/src/models/ors_models/get_geocode_response_model.dart';
import 'package:starter_app/src/models/waypoint.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/custom_datepicker_dialog.dart';
import 'package:starter_app/src/shared/loading_indicator.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/shared/vehicle_registration_field.dart';
import 'package:starter_app/src/shared/vehicle_registration_select_widget.dart';
import 'package:starter_app/src/shared/vehicle_registration_textfield.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/events/event_detail/event_detail_view_model.dart';

class EventDetailView extends StackedView<EventDetailViewModel> {
  final Event event;
  EventDetailView({
    required this.event,
  });

  final String dummyText = '----';

  @override
  Widget builder(
    BuildContext context,
    EventDetailViewModel model,
    Widget? child,
  ) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        // bottomNavigationBar: Padding(
        //   padding: EdgeInsets.symmetric(
        //     horizontal: 27.w,
        //     vertical: 10.h,
        //   ),
        //   child: MainButton(
        //     buttonText: action == EventAction.add ? 'Create Trip' : 'Save',
        //     onPressed: model.updateOrInsertEvent,
        //     isLoading: model.isBusy,
        //   ),
        // ),
        backgroundColor: Colors.transparent,
        body: Container(
          width: context.screenSize().width,
          height: context.screenSize().height,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: Image.asset(
          //       AssetImages.vehicleRegistrationBg,
          //       height: context.screenSize().height,
          //       width: context.screenSize().width,
          //     ).image,
          //     fit: BoxFit.cover,
          //     opacity: 0.7,
          //   ),
          // ),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Stack(
            children: [
              SizedBox(
                height: context.screenSize().height * 0.4,
                child: FlutterMap(
                  mapController: model.mapController,
                  options: MapOptions(
                    zoom: 12,
                    center: model.destination,
                    onTap: (tapPosition, latLng) {
                      model.onTapMap(latLng);
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AddWaypointDialog(model: model);
                        },
                      );
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    MarkerLayer(
                      markers: model.markers,
                    ),
                    PolylineLayer(
                      polylineCulling: false,
                      polylines: [
                        Polyline(
                          points: [
                            model.destination,
                            ...model.waypoints
                                .map((e) => LatLng(e.lat, e.long))
                                .toList(),
                          ],
                          color: AppColors.appSkyBlue,
                          strokeWidth: 2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: context.screenSize().height * 0.65,
                  width: context.screenSize().width,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.appFaddedBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: context.screenSize().height * 0.3,
                        width: context.screenSize().width,
                        child: Positioned.fill(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              VerticalSpacing(
                                context.screenSize().height * 0.1,
                              ),
                              Expanded(
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    final wp = model.waypoints[index];
                                    return WaypointInfoCard(
                                      waypoint: wp,
                                      dummyText: dummyText,
                                    );
                                  },
                                  shrinkWrap: true,
                                  itemCount: model.waypoints.length,
                                  separatorBuilder: (context, index) {
                                    return VerticalSpacing(10.h);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -context.screenSize().height * 0.05,
                        // height: 100.h,
                        width: context.screenSize().width,
                        child:
                            EventInfoCard(event: event, dummyText: dummyText),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                width: context.screenSize().width,
                child: Container(
                  child: CustomAppBar(
                    padding: EdgeInsets.only(
                      top: 50.h,
                      left: 27.w,
                      right: 27.w,
                      bottom: 0.h,
                    ),
                    titleText: 'Event Detail',
                    titleTextStyle: TextStyling.semiBold.copyWith(
                      color: AppColors.appFaddedBlue,
                      fontSize: 17.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  EventDetailViewModel viewModelBuilder(BuildContext context) =>
      EventDetailViewModel();

  @override
  void onViewModelReady(EventDetailViewModel model) => model.init(event);
}

class EventInfoCard extends StatelessWidget {
  const EventInfoCard({
    Key? key,
    required this.event,
    required this.dummyText,
  }) : super(key: key);

  final Event event;
  final String dummyText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 27.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: AppColors.eventDetailCardGradient,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.name ?? '',
            style: TextStyling.bold.copyWith(
              fontSize: 16.sp,
            ),
          ),
          VerticalSpacing(10.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  event.destination ?? '',
                  style: TextStyling.thin.copyWith(
                    fontSize: 13.sp,
                  ),
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
              HorizontalSpacing(10.w),
              Text(
                '${event.startTime != null ? DateFormat('dd MMM').format(event.startTime!) : dummyText} - ${event.endTime != null ? DateFormat('dd MMM').format(event.endTime!) : dummyText} (${event.noOfDays ?? dummyText} days)',
                style: TextStyling.bold.copyWith(fontSize: 13.sp),
              ),
            ],
          ),
          VerticalSpacing(5.h),
          Divider(
            // height: 1,
            color: AppColors.black,
            thickness: 0.5,
          ),
          VerticalSpacing(5.h),
          Text(
            'Total Days Planned:',
            style: TextStyling.bold.copyWith(
              fontSize: 13.sp,
            ),
          ),
          VerticalSpacing(10.h),
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(30.r),
            value: 0.5,
            minHeight: 10.h,
            backgroundColor: AppColors.appTextfieldBorderColor,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.appSkyBlue,
            ),
          ),
          VerticalSpacing(0.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0',
                style: TextStyling.thin.copyWith(
                  fontSize: 13.sp,
                ),
              ),
              Text(
                '${event.noOfDays ?? 0}',
                style: TextStyling.thin.copyWith(
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WaypointInfoCard extends StatelessWidget {
  const WaypointInfoCard({
    Key? key,
    required this.waypoint,
    required this.dummyText,
  }) : super(key: key);

  final Waypoint waypoint;
  final String dummyText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 27.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: AppColors.eventDetailCardGradient,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 5.h,
            ),
            decoration: BoxDecoration(
              gradient: AppColors.mainButtonGradient,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              waypoint.label ?? '',
              style: TextStyling.bold.copyWith(
                fontSize: 16.sp,
              ),
            ),
          ),
          VerticalSpacing(10.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expanded(
              //   child: Text(
              //     waypoint.label ?? '',
              //     style: TextStyling.thin.copyWith(
              //       fontSize: 13.sp,
              //     ),
              //     // overflow: TextOverflow.ellipsis,
              //   ),
              // ),
              // HorizontalSpacing(10.w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    '${waypoint.startTime != null ? DateFormat('dd MMM').format(waypoint.startTime!) : dummyText} - ${waypoint.endTime != null ? DateFormat('dd MMM').format(waypoint.endTime!) : dummyText} (${waypoint.noOfDays ?? dummyText} days)',
                    style: TextStyling.thin.copyWith(fontSize: 13.sp),
                  ),
                ),
              ),
            ],
          ),
          // VerticalSpacing(5.h),
          // Divider(
          //   // height: 1,
          //   color: AppColors.black,
          //   thickness: 0.5,
          // ),
          // VerticalSpacing(5.h),
          // Text(
          //   'Total Days Planned:',
          //   style: TextStyling.bold.copyWith(
          //     fontSize: 13.sp,
          //   ),
          // ),
          // VerticalSpacing(10.h),
          // LinearProgressIndicator(
          //   borderRadius: BorderRadius.circular(30.r),
          //   value: 0.5,
          //   minHeight: 10.h,
          //   backgroundColor: AppColors.appTextfieldBorderColor,
          //   valueColor: AlwaysStoppedAnimation<Color>(
          //     AppColors.appSkyBlue,
          //   ),
          // ),
          // VerticalSpacing(0.h),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       '0',
          //       style: TextStyling.thin.copyWith(
          //         fontSize: 13.sp,
          //       ),
          //     ),
          //     Text(
          //       '${waypoint.noOfDays ?? 0}',
          //       style: TextStyling.thin.copyWith(
          //         fontSize: 13.sp,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class AddWaypointDialog extends StatelessWidget {
  const AddWaypointDialog({
    Key? key,
    required this.model,
  }) : super(key: key);

  final EventDetailViewModel model;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Features?>(
      valueListenable: model.selectedPlace,
      builder: (context, value, _) {
        return AlertDialog(
          backgroundColor: AppColors.appDarkBlue,
          insetPadding: EdgeInsets.only(left: 10.0, right: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0.r),
          ),
          title: Text(
            'Add Waypoint',
            textAlign: TextAlign.center,
            style: TextStyling.medium.copyWith(
              fontSize: 16.sp,
            ),
          ),
          content: Text(
            'Add ${value?.properties?.label ?? '----'} as waypoint?',
            style: TextStyling.thin.copyWith(fontSize: 12.sp),
            textAlign: TextAlign.center,
          ),
          actions: [
            ValueListenableBuilder<bool>(
                valueListenable: model.placeLoading,
                builder: (context, isLoading, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: isLoading
                        ? [
                            Center(
                              child: LoadingIndicator(),
                            ),
                          ]
                        : [
                            Container(
                              height: 40.0.h,
                              width: 70.0.w,
                              child: MainButton(
                                isLoading: model.isBusy,
                                buttonText: 'Yes',
                                onPressed: () async {
                                  if (model.placeLoading.value) {
                                    return;
                                  }
                                  final shouldPop = await model.addWaypoint();
                                  if (shouldPop) {
                                    print(shouldPop);
                                    Navigator.pop(context);
                                  }
                                },
                                padding: EdgeInsets.zero,
                              ),
                            ),
                            HorizontalSpacing(15.w),
                            GestureDetector(
                              onTap: () {
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                height: 40.0.h,
                                width: 70.0.w,
                                decoration: BoxDecoration(
                                  color: AppColors.appFaddedBlue,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Center(
                                  child: Text(
                                    "No",
                                    style: TextStyling.regular.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                  );
                }),
            VerticalSpacing(10),
          ],
        );
      },
    );
  }
}
