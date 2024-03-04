import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/custom_form_field.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/login/login_view_model.dart';

class LoginView extends StackedView<LoginViewModel> {
  @override
  Widget builder(BuildContext context, LoginViewModel model, Widget? child) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // width: context.screenSize().width,
          height: context.screenSize().height - kTextTabBarHeight,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          child: Form(
            key: model.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset(AssetImages.imagesPlaceholder250),
                ),
                SizedBox(height: 40.h),
                CustomFormField(
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
                // const SizedBox(height: 24),
                SizedBox(height: 24.h),
                CustomFormField(
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
                  buttonText: 'Sign in',
                  buttonFontColor: AppColors.white,
                  onPressed: model.onLogin,
                  isLoading: model.isBusy,
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          tristate: false,
                          value: false,
                          side: BorderSide(color: AppColors.appSkyBlue),
                          onChanged: (v) {},
                        ),
                        Text(
                          'Remember me',
                          style: TextStyling.thin.copyWith(fontSize: 12.sp),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: model.onClickForgetPassword,
                      child: Text(
                        'Forget password?',
                        style: TextStyling.thin.copyWith(
                          fontSize: 12.sp,
                          // color: AppColors.appLightGreen,
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 10.h),
                Center(
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: AppColors.white,
                                  ),
                        ),
                        SizedBox(width: 4.w),
                        TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            overlayColor: MaterialStateProperty.all(
                                AppColors.white.withOpacity(0.1)),
                          ),
                          onPressed: model.onClickRegister,
                          child: Text(
                            'Sign up',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: AppColors.appSkyBlue,
                                    ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(flex: 1),
              ],
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
