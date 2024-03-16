import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:stacked/stacked.dart';
// import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/email_confirmation/email_confirmation_view_model.dart';

class EmailConfrimationView extends StackedView<EmailConfrimationViewModel> {
  @override
  Widget builder(
      BuildContext context, EmailConfrimationViewModel model, Widget? child) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.w,
      textStyle: TextStyling.medium,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.appFaddedBlue,
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.appSkyBlue),
    );
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = await showExitConfirmationDialog(context);
        return willLeave;
      },
      child: Scaffold(
          // appBar: AppBar(
          //   leading: IconButton(
          //     color: AppColors.white,
          //     onPressed: () {
          //       NavService.back();
          //     },
          //     icon: Icon(
          //       Icons.arrow_back_ios,
          //     ),
          //   ),
          //   title: Text(
          //     'OTP',
          //     style: TextStyling.semiBold,
          //   ),
          //   centerTitle: true,
          //   backgroundColor: AppColors.primary,
          // ),
          // body: Column(
          //   children: [
          //     CustomAppBar(
          //       titleText: 'Email Verification',
          //     ),
          //     Expanded(
          //       child: SingleChildScrollView(
          //         child: Container(
          //           width: context.screenSize().width,
          //           height: context.screenSize().height - kToolbarHeight,
          //           padding: EdgeInsets.symmetric(
          //             horizontal: 16.w,
          //             vertical: 16.h,
          //           ),
          //           child: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               SizedBox(height: 40.h),
          //               Text(
          //                 'Enter the code sent on your emial\n${model.supabaseAuthService.currentOTPEmail}',
          //                 style: TextStyling.medium,
          //                 textAlign: TextAlign.center,
          //               ),
          //               SizedBox(height: 40.h),
          //               Pinput(
          //                 defaultPinTheme: defaultPinTheme,
          //                 focusedPinTheme: focusedPinTheme,
          //                 length: 6,
          //                 controller: model.pinController,
          //               ),
          //               SizedBox(height: 40.h),
          //               MainButton(
          //                 fullWidth: false,
          //                 buttonText: 'Verify',
          //                 onPressed: model.onVerify,
          //                 isLoading: model.isBusy,
          //               ),
          //               Spacer(),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          ),
    );
  }

  @override
  EmailConfrimationViewModel viewModelBuilder(BuildContext context) =>
      EmailConfrimationViewModel();

  @override
  void onViewModelReady(EmailConfrimationViewModel model) => model.init();

  // @override
  // void onDispose(OtpViewModel model) {
  //   super.onDispose(model);
  // }
}

Future<bool> showExitConfirmationDialog(BuildContext context) async {
  Completer<bool> completer = Completer<bool>();

  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: AppColors.white,
      insetPadding: EdgeInsets.only(left: 10.0, right: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      title: Text(
        'Email not verified',
        textAlign: TextAlign.center,
        style: TextStyling.regular.copyWith(
          fontSize: 16.sp,
          color: AppColors.black,
        ),
      ),
      content: Text('Are you sure you want to go back?'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                completer.complete(true);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                height: 40.0.h,
                width: 70.0.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: AppColors.appFaddedBlue,
                ),
                child: Center(
                  child: Text(
                    "Yes",
                    style: TextStyling.regular.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
            HorizontalSpacing(15.w),
            GestureDetector(
              onTap: () {
                completer.complete(false);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                height: 40.0.h,
                width: 70.0.w,
                decoration: BoxDecoration(
                  color: AppColors.primary,
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
        ),
        VerticalSpacing(10),
      ],
    ),
  );
  return completer.future;
}
