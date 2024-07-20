import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/group_log.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/empty_state_widget.dart';
import 'package:starter_app/src/shared/loading_indicator.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/groups/group_activities/group_activities_view_model.dart';

class GroupActivitiesView extends StackedView<GroupActivitiesViewModel> {
  GroupActivitiesView();
  @override
  Widget builder(
      BuildContext context, GroupActivitiesViewModel model, Widget? child) {
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
              titleText: 'Group Activities',
            ),
            model.isBusy
                ? Expanded(
                    child: Center(
                      child: LoadingIndicator(
                        color: AppColors.appSkyBlue,
                      ),
                    ),
                  )
                : model.logs.isEmpty
                    ? Expanded(
                        child: Center(
                          child: EmptyStateWidget(
                            text: 'No Group Activities Available',
                          ),
                        ),
                      )
                    : Expanded(
                        //   child: ListView.separated(
                        //     padding: EdgeInsets.symmetric(
                        //       horizontal: 27.w,
                        //       vertical: 20.h,
                        //     ),
                        //     itemCount: model.logs.length,
                        //     itemBuilder: (context, index) {
                        //       final log = model.logs[index];
                        //       return Container(
                        //         decoration: BoxDecoration(
                        //           color: AppColors.appFaddedBlue,
                        //           borderRadius: BorderRadius.circular(10.r),
                        //         ),
                        //         padding: EdgeInsets.symmetric(
                        //           vertical: 6.h,
                        //           horizontal: 12.w,
                        //         ),
                        //         child: Center(
                        //           child: Text(
                        //             GroupLog.getLogMessage(log),
                        //             style: TextStyling.bold.copyWith(
                        //               fontSize: 14.sp,
                        //             ),
                        //             textAlign: TextAlign.center,
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //     separatorBuilder: (context, index) =>
                        //         VerticalSpacing(10.h),
                        //   ),
                        // ),
                        child: GroupedListView<GroupLog, DateTime>(
                          elements: model.logs,
                          groupBy: (log) => DateTime(
                            log.createdAt!.toLocal().year,
                            log.createdAt!.toLocal().month,
                            log.createdAt!.toLocal().day,
                          ),
                          reverse: true,
                          order: GroupedListOrder.DESC,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 10.h),
                          groupHeaderBuilder: (element) => Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10.h),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                color: AppColors.darkGrey,
                                child: Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Text(
                                    element.createdAt!.day == DateTime.now().day
                                        ? DateFormat('HH:mm')
                                            .format(element.createdAt!)
                                        : DateFormat.yMMMMEEEEd()
                                            .format(element.createdAt!),
                                    style: TextStyling.thin
                                        .copyWith(fontSize: 10.sp),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          separator: SizedBox(
                            height: 10.h,
                          ),
                          floatingHeader: true,
                          itemBuilder: (context, element) {
                            return Container(
                              decoration: BoxDecoration(
                                color: AppColors.appFaddedBlue,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 6.h,
                                horizontal: 12.w,
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      GroupLog.getLogMessage(element),
                                      style: TextStyling.bold.copyWith(
                                        fontSize: 14.sp,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      // child: Text(
                                      //   GroupLog.getLogMessage(element),
                                      //   style: TextStyling.bold.copyWith(
                                      //     fontSize: 14.sp,
                                      //   ),
                                      //   textAlign: TextAlign.center,
                                      // ),
                                      child: Text(
                                        // element.createdAt!.day == DateTime.now().day
                                        //     ?
                                        DateFormat('hh:mm a').format(
                                            element.createdAt!.toLocal()),
                                        // : DateFormat.yMMMMEEEEd()
                                        //     .format(element.createdAt!),
                                        style: TextStyling.thin
                                            .copyWith(fontSize: 8.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
          ],
        ),
      ),
    );
  }

  @override
  GroupActivitiesViewModel viewModelBuilder(BuildContext context) =>
      GroupActivitiesViewModel();

  @override
  void onViewModelReady(GroupActivitiesViewModel model) => model.init();
}
