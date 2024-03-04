import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/custom_form_field.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/register/register_view_model.dart';

class RegisterView extends StackedView<RegisterViewModel> {
  @override
  Widget builder(BuildContext context, RegisterViewModel model, Widget? child) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: context.screenSize().width,
          height: context.screenSize().height - kToolbarHeight,
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
                SizedBox(height: 20.h),
                Expanded(
                  flex: 3,
                  child: Image.asset(AssetImages.imagesPlaceholder250),
                ),
                SizedBox(height: 20.h),
                CustomFormField(
                  controller: model.nameController,
                  labelText: 'Fist name',
                  isPassword: false,
                  validatorFunction: (v) {
                    // return null;
                    if (v != null && v.length > 3) {
                      return null;
                    }
                    return 'Username must be atleast 3 chars long.';
                  },
                  primaryColor: AppColors.white,
                  textColor: AppColors.white,
                  isLabelCenter: false,
                ),
                SizedBox(height: 24.h),
                CustomFormField(
                  controller: model.nameController,
                  labelText: 'Last name',
                  isPassword: false,
                  validatorFunction: (v) {
                    // return null;
                    if (v != null && v.length > 3) {
                      return null;
                    }
                    return 'Username must be atleast 3 chars long.';
                  },
                  primaryColor: AppColors.white,
                  textColor: AppColors.white,
                  isLabelCenter: false,
                ),
                SizedBox(height: 24.h),
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
                SizedBox(height: 24.h),
                CustomFormField(
                  maxLength: 10,
                  textInputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.deny(RegExp('^0+'))
                  ],
                  prefixWidget: Padding(
                    padding: EdgeInsets.only(right: 4.w),
                    child: Text(
                      '+92',
                      style: TextStyling.medium
                          .copyWith(color: AppColors.white, fontSize: 16.sp),
                    ),
                  ),
                  controller: model.numberController,
                  labelText: 'Phone number',
                  isPassword: false,
                  validatorFunction: (v) {
                    return ValidationUtils.validateMobile(v);
                  },
                  primaryColor: AppColors.white,
                  textColor: AppColors.white,
                  isLabelCenter: false,
                ),
                SizedBox(height: 24.h),
                CustomFormField(
                  controller: model.passwordController,
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
                  buttonText: 'Sign up',
                  buttonFontColor: AppColors.primary,
                  onPressed: model.onRegister,
                  isLoading: model.isBusy,
                ),
                SizedBox(height: 10.h),
                Center(
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have account?",
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
                          // onPressed: model.onClickRegister,
                          onPressed: () {},
                          child: Text(
                            'Sign in',
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
  RegisterViewModel viewModelBuilder(BuildContext context) =>
      RegisterViewModel();

  @override
  void onViewModelReady(RegisterViewModel model) => model.init();

  // @override
  // void onDispose(RegisterViewModel model) {
  //   super.onDispose(model);
  // }
}
