import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/custom_form_field.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/login/login_view_model.dart';

class LoginView extends StackedView<LoginViewModel> {
  @override
  Widget builder(BuildContext context, LoginViewModel model, Widget? child) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset(AssetImages.bgImage).image,
              fit: BoxFit.cover,
              opacity: 0.5,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.asset(AssetImages.squaresBg).image,
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
            ),
            height: context.screenSize().height,
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 16.h,
            ),
            child: Form(
              key: model.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VerticalSpacing(40.h),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 150.w,
                          width: 150.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: AppColors.appNameBoxShadows,
                            color: AppColors.appDarkBlue,
                          ),
                        ),
                        VerticalSpacing(20.h),
                        Text(
                          'Travel Manager',
                          style: TextStyling.regular,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyling.regular.copyWith(
                          fontSize: 24.sp,
                        ),
                      ),
                      Text(
                        'Please sign in to continue.',
                        style: TextStyling.thin.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  CustomFormField(
                    prefixWidget: SvgPicture.asset(
                      AssetIcons.mailIcon,
                      height: 20.h,
                    ),
                    controller: model.emailController,
                    labelText: 'Email',
                    isPassword: false,
                    validatorFunction: (v) {
                      return ValidationUtils.validateEmail(v);
                    },
                    primaryColor: AppColors.white,
                    textColor: AppColors.white,
                    isLabelCenter: false,
                  ),
                  SizedBox(height: 24.h),
                  CustomFormField(
                    prefixWidget: SvgPicture.asset(
                      AssetIcons.lockIcon,
                      height: 20.h,
                    ),
                    controller: model.passwordController,
                    textFieldBgColor: AppColors.appDarkBlue,
                    labelText: 'Password',
                    isPassword: true,
                    validatorFunction: (v) {
                      return ValidationUtils.validatePassword(v);
                    },
                    primaryColor: AppColors.white,
                    textColor: AppColors.white,
                    isLabelCenter: false,
                  ),
                  SizedBox(height: 32.h),
                  MainButton(
                    buttonText: 'Login',
                    buttonFontColor: AppColors.white,
                    onPressed: model.onLogin,
                    isLoading: model.isBusy,
                  ),
                  SizedBox(height: 5.h),
                  Center(
                    child: TextButton(
                      onPressed: model.onClickForgetPassword,
                      child: Text(
                        'Forget password?',
                        style: TextStyling.thin.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.appSkyBlue,
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Center(
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyling.bold.copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                              overlayColor: MaterialStateProperty.all(
                                  AppColors.white.withOpacity(0.1)),
                            ),
                            onPressed: model.onClickRegister,
                            child: Text(
                              'Sign up',
                              style: TextStyling.extraBold.copyWith(
                                fontSize: 14.sp,
                                color: AppColors.appSkyBlue,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();

  @override
  void onViewModelReady(LoginViewModel model) => model.init();

  // @override
  // void onDispose(LoginViewModel model) {
  //   super.onDispose(model);
  // }
}
