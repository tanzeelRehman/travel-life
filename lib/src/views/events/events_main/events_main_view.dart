import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/group_join.dart';
import 'package:starter_app/src/base/enums/group_type.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/empty_state_widget.dart';
import 'package:starter_app/src/shared/loading_indicator.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/events/events_main/events_main_view_model.dart';
import 'package:starter_app/src/views/groups/widgets/group_tile_widget.dart';

class EventsMainView extends StackedView<EventsMainViewModel> {
  @override
  Widget builder(
      BuildContext context, EventsMainViewModel model, Widget? child) {
    return Scaffold(
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
            VerticalSpacing(20.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 27.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Expanded(
                    //   child: model.isBusy
                    //       ? Center(
                    //           child: LoadingIndicator(
                    //             color: AppColors.appSkyBlue,
                    //           ),
                    //         )
                    //       : model.dataService.allEvents.isNotEmpty
                    //           ? ListView.builder(
                    //               itemCount: model.dataService.allEvents.length,
                    //               itemBuilder: (context, index) {
                    //                 final grp =
                    //                     model.dataService.allEvents[index];
                    //                 print('grp: ${grp.toString()}');
                    //                 // return GroupsTile(
                    //                 //   group: grp,
                    //                 //   onAddIconTap: () {},
                    //                 //   onArrowIconTap: () {},
                    //                 //   onMoreIconTap: () {},
                    //                 // );
                    //               },
                    //             )
                    //           : Center(
                    //               child: EmptyStateWidget(
                    //                 text: 'No events currently',
                    //               ),
                    //             ),
                    // )
                    Center(
                      child: MainButton(
                          buttonText: 'test',
                          onPressed: () {
                            model.searchAutocomplete('test');
                          },
                          isLoading: false),
                    ),
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
