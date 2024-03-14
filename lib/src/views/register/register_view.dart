import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/custom_form_field.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/register/register_view_model.dart';

class RegisterView extends StackedView<RegisterViewModel> {
  @override
  Widget builder(BuildContext context, RegisterViewModel model, Widget? child) {
    return Scaffold(
      body: Container(
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
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: context.screenSize().height,
            ),
            child: Column(
              children: [
                CustomAppBar(
                  titleText: '',
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      height: context.screenSize().height * 0.95,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create Account',
                                  style: TextStyling.regular.copyWith(
                                    fontSize: 24.sp,
                                  ),
                                ),
                                Text(
                                  'Please fill the input below here...',
                                  style: TextStyling.thin.copyWith(
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 40.h),
                            CustomFormField(
                              prefixWidget: SvgPicture.asset(
                                AssetIcons.userIcon,
                                height: 20.h,
                              ),
                              controller: model.firstNameController,
                              labelText: 'First Name',
                              isPassword: false,
                              validatorFunction: (v) {
                                if (v!.isEmpty) {
                                  return 'Please enter your first name';
                                }

                                if (v.length < 3) {
                                  return 'first name must be at least 3 characters';
                                }

                                return null;
                              },
                              primaryColor: AppColors.white,
                              textColor: AppColors.white,
                              isLabelCenter: false,
                            ),
                            SizedBox(height: 24.h),
                            CustomFormField(
                              prefixWidget: SvgPicture.asset(
                                AssetIcons.userIcon,
                                height: 20.h,
                              ),
                              controller: model.lastNameController,
                              labelText: 'Last Name',
                              isPassword: false,
                              validatorFunction: (v) {
                                if (v!.isEmpty) {
                                  return 'Please enter your last name';
                                }

                                if (v.length < 2) {
                                  return 'first name must be at least 2 characters';
                                }

                                return null;
                              },
                              primaryColor: AppColors.white,
                              textColor: AppColors.white,
                              isLabelCenter: false,
                            ),
                            VerticalSpacing(24.h),
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
                            VerticalSpacing(24.h),
                            CustomFormField(
                              prefixWidget: SvgPicture.asset(
                                AssetIcons.mobileIcon,
                                height: 20.h,
                              ),
                              controller: model.numberController,
                              labelText: 'Phone',
                              isPassword: false,
                              validatorFunction: (v) {
                                return ValidationUtils.validateMobile(v);
                              },
                              primaryColor: AppColors.white,
                              textColor: AppColors.white,
                              isLabelCenter: false,
                              textInputType: TextInputType.phone,
                            ),
                            VerticalSpacing(24.h),
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
                            VerticalSpacing(24.h),
                            CustomFormField(
                              prefixWidget: SvgPicture.asset(
                                AssetIcons.lockIcon,
                                height: 20.h,
                              ),
                              controller: model.confirmPasswordController,
                              textFieldBgColor: AppColors.appDarkBlue,
                              labelText: 'Repeat Password',
                              isPassword: true,
                              validatorFunction: (v) {
                                return ValidationUtils.validateConfirmPassword(
                                  confirmPassword: v,
                                  password: model.passwordController.text,
                                );
                              },
                              primaryColor: AppColors.white,
                              textColor: AppColors.white,
                              isLabelCenter: false,
                            ),
                            VerticalSpacing(32.h),
                            MainButton(
                              buttonText: 'Sign Up',
                              buttonFontColor: AppColors.white,
                              onPressed: model.onRegister,
                              isLoading: model.isBusy,
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
                                      "Already have an account?",
                                      style: TextStyling.bold.copyWith(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    TextButton(
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.zero),
                                        overlayColor: MaterialStateProperty.all(
                                            AppColors.white.withOpacity(0.1)),
                                      ),
                                      // onPressed: model.onClickRegister,
                                      onPressed: () {},
                                      child: Text(
                                        'Sign in',
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
}
