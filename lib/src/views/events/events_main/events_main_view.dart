import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/event.dart';
import 'package:starter_app/src/services/local/flavor_service.dart';
import 'package:starter_app/src/shared/blur_container.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/empty_state_widget.dart';
import 'package:starter_app/src/shared/loading_indicator.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/main_floating_action_button.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/events/events_main/events_main_view_model.dart';

class EventsMainView extends StackedView<EventsMainViewModel> {
  @override
  Widget builder(
      BuildContext context, EventsMainViewModel model, Widget? child) {
    return Scaffold(
      floatingActionButton:
          MainFloatingActionButton(onTap: model.navigateToAddEvent),
      body: Container(
        width: context.screenSize().width,
        height: context.completeHeight(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset(AssetImages.vehicleRegistrationBg).image,
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              titleText: "Trips",
            ),
            VerticalSpacing(10.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 27.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: model.isBusy
                          ? Center(
                              child: LoadingIndicator(
                                color: AppColors.appSkyBlue,
                              ),
                            )
                          : model.dataService.allEvents.isNotEmpty
                              ? ListView.separated(
                                  itemCount: model.dataService.allEvents.length,
                                  padding:
                                      EdgeInsets.only(top: 10.h, bottom: 50.h),
                                  itemBuilder: (context, index) {
                                    final event =
                                        model.dataService.allEvents[index];
                                    return EventTile(
                                      event: event,
                                      onClickOpen: () {
                                        model.onClickOpen(event);
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return VerticalSpacing(20.h);
                                  },
                                )
                              : Center(
                                  child: EmptyStateWidget(
                                    text: 'No events currently',
                                  ),
                                ),
                    ),
                    // Center(
                    //   child: MainButton(
                    //       buttonText: 'test',
                    //       onPressed: () {
                    //         model.searchAutocomplete('test');
                    //       },
                    //       isLoading: false),
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  EventsMainViewModel viewModelBuilder(BuildContext context) =>
      EventsMainViewModel();

  @override
  void onViewModelReady(EventsMainViewModel model) => model.init();
}

class EventTile extends StatelessWidget {
  const EventTile({
    Key? key,
    required this.event,
    required this.onClickOpen,
  }) : super(key: key);

  final Event event;
  final VoidCallback onClickOpen;

  @override
  Widget build(BuildContext context) {
    final String dummyText = '----';
    return GestureDetector(
      onTap: () {},
      child: BlurContainer(
        // height: MediaQuery.of(context).size.height * 0.41,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
                top: 10.w,
                bottom: 10.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.network(
                      event.coverImage ?? FlavorService.dummyImageUrl,
                      height: 150.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  VerticalSpacing(10.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          event.name ?? dummyText,
                          style: TextStyling.bold.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                        VerticalSpacing(5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Trip Duration: ',
                                style: TextStyling.bold.copyWith(
                                  fontSize: 10.sp,
                                ),
                                children: [
                                  // TextSpan(
                                  //   text:
                                  //       '${event.startTime != null ? DateFormat('dd, MMM').format(event.startTime!) : dummyText} To ${event.endTime != null ? DateFormat('dd, MMM').format(event.endTime!) : dummyText}',
                                  //   style: TextStyling.regular.copyWith(
                                  //     fontSize: 10.sp,
                                  //   ),
                                  // ),
                                  TextSpan(
                                    text: '${event.noOfDays ?? 0} days',
                                    style: TextStyling.regular.copyWith(
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Starts on: ${event.startTime != null ? DateFormat('dd, MMM').format(event.startTime!) : dummyText}',
                              style: TextStyling.regular.copyWith(
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                        VerticalSpacing(20.h),
                        Row(
                          children: [
                            Expanded(
                              child: MainButton(
                                buttonText: 'Open',
                                onPressed: onClickOpen,
                                isLoading: false,
                              ),
                            ),
                            HorizontalSpacing(15.w),
                            MainFloatingActionButton(
                              onTap: () {},
                              icon: Icons.send,
                              heightAndWidth: 50.w,
                              iconColor: AppColors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Positioned(
            //   top: 5,
            //   right: 5,
            //   child: IconButton(
            //     onPressed: (){},
            //     icon: Container(
            //       height: 30.w,
            //       width: 30.w,
            //       decoration: BoxDecoration(
            //         color: (vehicle.isEnabled ??
            //                 true)
            //             ? AppColors.red
            //             : Colors.green,
            //         shape: BoxShape.circle,
            //       ),
            //       child: (vehicle.isEnabled ??
            //               true)
            //           ? SvgPicture.asset(
            //               AssetIcons.deleteIcon,
            //               fit: BoxFit.scaleDown,
            //             )
            //           : Icon(
            //               Icons.check,
            //               color:
            //                   AppColors.white,
            //               size: 20.sp,
            //             ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
