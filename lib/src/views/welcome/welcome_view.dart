import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/welcome/welcome_view_model.dart';

class WelcomeView extends StackedView<WelcomeViewModel> {
  @override
  Widget builder(BuildContext context, WelcomeViewModel model, Widget? child) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset(AssetImages.mainBgWithoutGlow).image,
            fit: BoxFit.cover,
          ),
        ),
        width: context.screenSize().width,
        height: context.screenSize().height,
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 16.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              height: 55.h,
              decoration: BoxDecoration(
                boxShadow: AppColors.appNameBoxShadows,
                color: AppColors.appDarkBlue,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Text(
                  'Travel Life',
                  style: TextStyling.bold.copyWith(fontSize: 24.sp),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Image.asset(AssetImages.imagesPlaceholder250),
            ),
            SizedBox(height: 40.h),
            MainButton(
              buttonText: 'Sign up',
              buttonFontColor: AppColors.white,
              onPressed: model.onClickRegister,
              isLoading: model.isBusy,
            ),
            SizedBox(height: 24.h),
            MainButton(
              buttonText: 'Sign in',
              buttonFontColor: AppColors.white,
              onPressed: model.onClickLogin,
              isLoading: model.isBusy,
              gradient: AppColors.secondaryButtonGradient,
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  @override
  WelcomeViewModel viewModelBuilder(BuildContext context) => WelcomeViewModel();

  @override
  void onViewModelReady(WelcomeViewModel model) => model.init();

  // @override
  // void onDispose(LoginViewModel model) {
  //   super.onDispose(model);
  // }
}
