import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/shared/blur_container.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/custom_tab.dart';
import 'package:starter_app/src/shared/editable_profile_avatar.dart';
import 'package:starter_app/src/shared/full_screen_loading_indicator.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/shared/tab_switcher_widget.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/profile/extended_profile_section.dart';
import 'package:starter_app/src/views/profile/personal_detail_section.dart';
import 'package:starter_app/src/views/vehicle_registration/vehicle_registration_view_model.dart';

class VehicleRegistrationView
    extends StackedView<VehicleRegistrationViewModel> {
  @override
  Widget builder(
    BuildContext context,
    VehicleRegistrationViewModel model,
    Widget? child,
  ) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 27.w,
          vertical: 10.h,
        ),
        child: SizedBox(
          height: 55.h,
          child: OutlinedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 10.h, horizontal: 24.w),
              ),
              side: MaterialStateProperty.all(
                BorderSide(
                  color: AppColors.appSkyBlue,
                ),
              ),
            ),
            onPressed: model.onClickAddActionButton,
            child: Text(
              getActionButtonText(model.selectedTab),
              style: TextStyling.medium.copyWith(
                fontSize: 18.sp,
                // color: AppColors.appSkyBlue,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SpeedDial(
        // icon: Icons.add,
        // activeIcon: Icons.close,
        spacing: 3,
        openCloseDial: model.isFabOpen,
        // childPadding: const EdgeInsets.all(5),
        child: Container(
          height: 65.w,
          width: 65.w,
          decoration: BoxDecoration(
            gradient: AppColors.mainButtonGradient,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.add,
            size: 36.w,
          ),
        ),
        activeChild: Container(
          height: 65.w,
          width: 65.w,
          decoration: BoxDecoration(
            gradient: AppColors.fabCloseButtonGradient,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.close,
            size: 36.w,
          ),
        ),
        spaceBetweenChildren: 4,
        visible: true,

        direction: SpeedDialDirection.up,
        switchLabelPosition: false,
        closeManually: false,
        renderOverlay: true,
        overlayColor: AppColors.black,
        overlayOpacity: 0.6,
        onOpen: () => debugPrint('OPENING DIAL'),
        onClose: () => debugPrint('DIAL CLOSED'),
        elevation: 8.0,
        animationCurve: Curves.elasticInOut,
        isOpenOnStart: false,
        animationDuration: const Duration(milliseconds: 200),

        children: [
          SpeedDialChild(
            child: Container(
              height: 41.w,
              width: 41.w,
              decoration: BoxDecoration(
                gradient: AppColors.mainButtonGradient,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                AssetIcons.quickNavigationIcon,
                height: 20.h,
                fit: BoxFit.scaleDown,
              ),
            ),
            foregroundColor: AppColors.white,
            backgroundColor: Colors.transparent,
            shape: CircleBorder(),
            labelWidget: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                'Quick Navigation',
                style: TextStyling.semiBold.copyWith(
                  color: AppColors.appDarkBlue,
                  fontSize: 12.sp,
                ),
              ),
            ),
            onTap: () => debugPrint('SECOND CHILD'),
          ),
        ],
      ),
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
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomAppBar(
                  titleText: model.getAppBarTitle(),
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
                if (model.selectedTab == 0) VehiclesView(),
                if (model.selectedTab == 1) AccessoriesView(model: model),
                if (model.selectedTab == 2) OperationalCostView(model: model),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  VehicleRegistrationViewModel viewModelBuilder(BuildContext context) =>
      VehicleRegistrationViewModel();

  @override
  void onViewModelReady(VehicleRegistrationViewModel model) => model.init();
}

class VehiclesView extends StatelessWidget {
  const VehiclesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: 27.w,
          vertical: 16.h,
        ),
        separatorBuilder: (context, index) => VerticalSpacing(20.h),
        itemBuilder: (context, index) {
          return VehicleCard();
        },
        shrinkWrap: true,
        itemCount: 10,
      ),
    );
  }
}

class VehicleCard extends StatelessWidget {
  const VehicleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      height: 384.h,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
              top: 10.h,
              bottom: 20.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfhVdI0FxDS2N0sqI8b9Dm_H2vK19hHptpetvbBg33KQ&s',
                    height: 173.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                VerticalSpacing(10.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'BMW Cabrio',
                        style: TextStyling.semiBold.copyWith(
                          fontSize: 20.sp,
                        ),
                      ),
                      VerticalSpacing(10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AssetImages.vehicleCardFuelAverage,
                                height: 15.h,
                              ),
                              HorizontalSpacing(8.w),
                              Text(
                                '12 Km/L',
                                style: TextStyling.regular.copyWith(
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AssetImages.vehicleCardBuildyear,
                                height: 15.h,
                              ),
                              HorizontalSpacing(8.w),
                              Text(
                                '12 Km/L',
                                style: TextStyling.regular.copyWith(
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      VerticalSpacing(10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AssetImages.vehicleCardPurchasePrice,
                                height: 15.h,
                              ),
                              HorizontalSpacing(8.w),
                              Text(
                                '12 Km/L',
                                style: TextStyling.regular.copyWith(
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AssetImages.vehicleCardRunningKM,
                                height: 15.h,
                              ),
                              HorizontalSpacing(8.w),
                              Text(
                                '12 Km/L',
                                style: TextStyling.regular.copyWith(
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                VerticalSpacing(20.h),
                MainButton(
                  buttonText: 'Edit Details',
                  onPressed: () {},
                  isLoading: false,
                ),
              ],
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              onPressed: () {},
              icon: Container(
                height: 30.w,
                width: 30.w,
                decoration: BoxDecoration(
                  color: AppColors.red,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AssetIcons.deleteIcon,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AccessoriesView extends StatelessWidget {
  const AccessoriesView({
    Key? key,
    required this.model,
  }) : super(key: key);

  final VehicleRegistrationViewModel model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 45.h + 40.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: 27.w,
                  vertical: 16.h,
                ),
                separatorBuilder: (context, index) => HorizontalSpacing(20.w),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      model.onChangeSelectedAccessoryCategory(index);
                    },
                    child: Container(
                      height: 45.h,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: model.selectedAccessoryCategory == index
                            ? AppColors.appDarkBlue
                            : AppColors.white,
                        border: Border.all(
                          color: model.selectedAccessoryCategory == index
                              ? AppColors.lightGrey.withOpacity(0.2)
                              : AppColors.grey.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          model.accessoryCategories[index],
                          style: TextStyling.semiBold.copyWith(
                            fontSize: 12.sp,
                            color: model.selectedAccessoryCategory == index
                                ? AppColors.white
                                : AppColors.appDarkBlue,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: model.accessoryCategories.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
              ),
            ),
            AccessoryCategoryHeader(),
            SizedBox(
              height: 32.h + 360.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: 27.w,
                  vertical: 16.h,
                ),
                separatorBuilder: (context, index) => HorizontalSpacing(20.h),
                itemBuilder: (context, index) {
                  return AccessoryCard();
                },
                shrinkWrap: false,
                itemCount: 10,
                scrollDirection: Axis.horizontal,
              ),
            ),
            AccessoryCategoryHeader(),
            SizedBox(
              height: 32.h + 360.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: 27.w,
                  vertical: 16.h,
                ),
                separatorBuilder: (context, index) => HorizontalSpacing(20.h),
                itemBuilder: (context, index) {
                  return AccessoryCard();
                },
                shrinkWrap: false,
                itemCount: 10,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccessoryCategoryHeader extends StatelessWidget {
  const AccessoryCategoryHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 27.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Safety Gear',
            style: TextStyling.regular,
          ),
          MainButton(
            width: 25.w,
            height: 25.w,
            padding: EdgeInsets.zero,
            fullWidth: false,
            buttonText: '',
            onPressed: () {},
            isLoading: false,
            child: Icon(
              Icons.add,
              color: AppColors.white,
              size: 20.sp,
            ),
            borderRadius: BorderRadius.circular(5.r),
          ),
        ],
      ),
    );
  }
}

class AccessoryCard extends StatelessWidget {
  const AccessoryCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      height: 360.h,
      width: 200.w,
      sigmaX: 1,
      sigmaY: 1,
      child: Padding(
        padding: EdgeInsets.only(
          left: 7.w,
          right: 7.w,
          top: 7.h,
          bottom: 7.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfhVdI0FxDS2N0sqI8b9Dm_H2vK19hHptpetvbBg33KQ&s',
                height: 150.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            VerticalSpacing(10.h),
            Text(
              '\$1400',
              style: TextStyling.semiBold.copyWith(
                fontSize: 15.sp,
              ),
            ),
            VerticalSpacing(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Purchasing Date',
                      style: TextStyling.regular.copyWith(
                        fontSize: 10.sp,
                        color: AppColors.grey,
                      ),
                    ),
                    HorizontalSpacing(8.w),
                    Text(
                      '12-Mar-2019',
                      style: TextStyling.medium.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Purchasing Price',
                      style: TextStyling.regular.copyWith(
                        fontSize: 10.sp,
                        color: AppColors.grey,
                      ),
                    ),
                    HorizontalSpacing(8.w),
                    Text(
                      '\$1600',
                      style: TextStyling.medium.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            VerticalSpacing(10.h),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.appFaddedBlue,
                ),
                child: Text(
                  'Lorem ipsum dolor sit amet consectetur. Sed suspendisse lobortis pharetra tellus nulla eget luctus facilisi. Nibh eget...',
                  style: TextStyling.regular.copyWith(fontSize: 10.sp),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Edit',
                      style: TextStyling.regular.copyWith(
                        fontSize: 12.sp,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.white,
                      ),
                    ),
                    HorizontalSpacing(8.w),
                    Icon(
                      Icons.edit_outlined,
                      color: AppColors.white,
                      size: 15.sp,
                    )
                  ],
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OperationalCostView extends StatelessWidget {
  const OperationalCostView({
    Key? key,
    required this.model,
  }) : super(key: key);

  final VehicleRegistrationViewModel model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 45.h + 40.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 27.w,
                vertical: 16.h,
              ),
              separatorBuilder: (context, index) => HorizontalSpacing(20.w),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    model.onChangeSelectedAccessoryCategory(index);
                  },
                  child: Container(
                    height: 45.h,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: model.selectedAccessoryCategory == index
                          ? AppColors.appDarkBlue
                          : AppColors.white,
                      border: Border.all(
                        color: model.selectedAccessoryCategory == index
                            ? AppColors.lightGrey.withOpacity(0.2)
                            : AppColors.grey.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        model.accessoryCategories[index],
                        style: TextStyling.semiBold.copyWith(
                          fontSize: 12.sp,
                          color: model.selectedAccessoryCategory == index
                              ? AppColors.white
                              : AppColors.appDarkBlue,
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: model.accessoryCategories.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.sp,
                mainAxisSpacing: 20.sp,
                mainAxisExtent: 260.h,
              ),
              itemBuilder: (context, index) {
                return OperationalCostCard();
              },
              itemCount: 4,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: 27.w,
              ),
              scrollDirection: Axis.vertical,
            ),
          ),
        ],
      ),
    );
  }
}

class OperationalCostCard extends StatelessWidget {
  const OperationalCostCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      sigmaX: 11,
      sigmaY: 1,
      child: Padding(
        padding: EdgeInsets.only(
          left: 7.w,
          right: 7.w,
          top: 7.h,
          bottom: 7.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                // child: CachedNetworkImage(
                //   imageUrl:
                //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfhVdI0FxDS2N0sqI8b9Dm_H2vK19hHptpetvbBg33KQ&s',
                //   height: 150.h,
                //   width: double.infinity,
                //   fit: BoxFit.contain,
                // ),
                child: SvgPicture.asset(
                  AssetIcons.chatsButtonIcon,
                  height: 120.h,
                  alignment: Alignment.center,
                ),
              ),
            ),
            VerticalSpacing(20.h),
            Text(
              '\$1400',
              style: TextStyling.semiBold.copyWith(
                fontSize: 15.sp,
              ),
            ),
            VerticalSpacing(10.h),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 10.sp,
                          color: AppColors.white,
                        ),
                        HorizontalSpacing(3.w),
                        Text(
                          'P - Price',
                          style: TextStyling.regular.copyWith(
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '\$1300',
                      style: TextStyling.medium.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 10.sp,
                          color: AppColors.white,
                        ),
                        HorizontalSpacing(3.w),
                        Text(
                          'P - Date',
                          style: TextStyling.regular.copyWith(
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '12/3/19',
                      style: TextStyling.medium.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Edit',
                      style: TextStyling.regular.copyWith(
                        fontSize: 12.sp,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.white,
                      ),
                    ),
                    HorizontalSpacing(8.w),
                    Icon(
                      Icons.edit_outlined,
                      color: AppColors.white,
                      size: 15.sp,
                    )
                  ],
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getActionButtonText(int index) {
  switch (index) {
    case 0:
      return 'Add Vehicle';
    case 1:
      return 'Add Accessory';
    case 2:
      return 'Add Cost';
    default:
      return '';
  }
}
