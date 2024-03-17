import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/custom_tab.dart';
import 'package:starter_app/src/shared/editable_profile_avatar.dart';
import 'package:starter_app/src/shared/full_screen_loading_indicator.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/shared/tab_switcher_widget.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/views/profile/extended_profile_section.dart';
import 'package:starter_app/src/views/profile/personal_detail_section.dart';
import 'package:starter_app/src/views/vehicle_registration/vehicle_registration_view_model.dart';
// import 'package:starter_app/src/views/profile/profile_view_model.dart';

class VehicleRegistrationView
    extends StackedView<VehicleRegistrationViewModel> {
  @override
  Widget builder(
      BuildContext context, VehicleRegistrationViewModel model, Widget? child) {
    return Stack(
      children: [
        Scaffold(
          body: Container(
            width: context.screenSize().width,
            height: context.screenSize().height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.asset(
                  AssetImages.vehicleRegistrationBg,
                  height: context.screenSize().height,
                  width: context.screenSize().width,
                ).image,
                fit: BoxFit.cover,
                opacity: 0.7,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -context.screenSize().width * 0.4,
                  top: 0,
                  child: SizedBox(
                    height: context.screenSize().height * 0.25,
                    width: context.screenSize().width,
                    child: Image.asset(
                      // AssetImages.vehicleRegistrationFinancePNG,
                      model.getBgHeroImage(),
                      alignment: Alignment.centerRight,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      titleText: 'Accessory Registration',
                    ),
                    VerticalSpacing(context.screenSize().height * 0.18),
                    TabSwitcherWidget(
                      horizontalSpacing: 0,
                      outerPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      tabs: [
                        CustomTab(
                          title: 'Vehicles',
                          onTap: () {
                            model.onChangeTab(0);
                          },
                          isSelected: model.selectedTab == 0,
                        ),
                        CustomTab(
                          title: 'Accessories',
                          onTap: () {
                            model.onChangeTab(1);
                          },
                          isSelected: model.selectedTab == 1,
                        ),
                        CustomTab(
                          title: 'Operational Cost',
                          onTap: () {
                            model.onChangeTab(2);
                          },
                          isSelected: model.selectedTab == 2,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  VehicleRegistrationViewModel viewModelBuilder(BuildContext context) =>
      VehicleRegistrationViewModel();

  @override
  void onViewModelReady(VehicleRegistrationViewModel model) => model.init();
}
