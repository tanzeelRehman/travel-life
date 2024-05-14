// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/custom_tab.dart';
import 'package:starter_app/src/shared/editable_profile_avatar.dart';
import 'package:starter_app/src/shared/full_screen_loading_indicator.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/profile_textfield.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/shared/tab_switcher_widget.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/dialogs/groups_dialog/remove_person_dialog.dart';
import 'package:starter_app/src/views/groups/group_member_profile/group_member_profile_view_model.dart';
import 'package:starter_app/src/views/profile/extended_profile_section.dart';
import 'package:starter_app/src/views/profile/personal_detail_section.dart';
import 'package:starter_app/src/views/profile/profile_view_model.dart';

class GroupMemberProfileView extends StackedView<GroupMemberProfileViewModel> {
  @override
  Widget builder(
      BuildContext context, GroupMemberProfileViewModel model, Widget? child) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          width: context.screenSize().width,
          height: context.screenSize().height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset(
                AssetImages.mainBg,
                height: context.screenSize().height,
                width: context.screenSize().width,
              ).image,
              fit: BoxFit.cover,
              opacity: 0.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomAppBar(
                titleText: 'Profile Info',
              ),
              VerticalSpacing(20.h),
              CircleAvatar(
                radius: 75.r,
                backgroundImage: AssetImage(AssetImages.sampleUser),
              ),
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  children: [
                    ProfileTextField(
                      controller: TextEditingController(),
                      title: 'Name',
                      suffixIcon: Icon(
                        Icons.person_2_outlined,
                        color: Colors.white.withOpacity(.5),
                      ),
                    ),
                    VerticalSpacing(15.h),
                    ProfileTextField(
                      controller: TextEditingController(),
                      title: 'Email',
                      suffixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.white.withOpacity(.5),
                      ),
                    ),
                    VerticalSpacing(15.h),
                    ProfileTextField(
                      controller: TextEditingController(),
                      title: 'Date of Join',
                      suffixIcon: Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.white.withOpacity(.5),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              child: RemovePersonDialog(
                                name: 'Tanzeel',
                                no: () {},
                                yes: () {},
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 55.h,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.red,
                            border: AppColors.gradientBordersDecoration),
                        child: Text(
                          'Remove',
                          style: TextStyling.semiBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  GroupMemberProfileViewModel viewModelBuilder(BuildContext context) =>
      GroupMemberProfileViewModel();

  @override
  void onViewModelReady(GroupMemberProfileViewModel model) => model.init();
}
