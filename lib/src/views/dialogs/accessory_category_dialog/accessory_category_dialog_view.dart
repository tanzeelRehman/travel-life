import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/models/accessory_category.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/dialogs/accessory_category_dialog/accessory_category_dialog_view_model.dart';

class AccessoryCategoryDialogView
    extends StackedView<AccessoryCategoryDialogViewModel> {
  final AccessoryCategory? initialSelectedCategory;

  AccessoryCategoryDialogView({required this.initialSelectedCategory});

  @override
  Widget builder(BuildContext context, AccessoryCategoryDialogViewModel model,
      Widget? child) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                color: Color(0xff777c88),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category",
                    style: TextStyling.bold.copyWith(fontSize: 18.sp),
                  ),
                  VerticalSpacing(20.h),
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final item = model.accessoryCategories[index];
                      return categoryRow(
                        context,
                        item.name ?? '',
                        model.selectedAccessoryCategory == item,
                        () {
                          model.onChangeAccessoryCategory(item);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => VerticalSpacing(10.h),
                    shrinkWrap: true,
                    itemCount: model.accessoryCategories.length,
                  ),
                  VerticalSpacing(20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyling.semiBold.copyWith(
                            color: AppColors.appDarkBlue,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            model.selectedAccessoryCategory,
                          );
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyling.semiBold.copyWith(
                            color: AppColors.appSkyBlue,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  AccessoryCategoryDialogViewModel viewModelBuilder(BuildContext context) =>
      AccessoryCategoryDialogViewModel();

  @override
  void onViewModelReady(AccessoryCategoryDialogViewModel model) =>
      model.init(initialSelectedCategory);
}

Row categoryRow(
  BuildContext context,
  String title,
  bool isSelected,
  VoidCallback onTap,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10),
          // width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(.4),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            title,
            style: TextStyling.regular,
          ),
        ),
      ),
      HorizontalSpacing(25.w),
      CustomRadioButton(
        value: title,
        isActive: isSelected,
        onTap: onTap,
      ),
    ],
  );
}

class CustomRadioButton extends StatelessWidget {
  final String value;
  final VoidCallback onTap;
  final bool isActive;
  const CustomRadioButton({
    required this.value,
    required this.onTap,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isActive
                      ? const LinearGradient(
                          colors: [Color(0xff38acea), Color(0xff4378ee)])
                      : const LinearGradient(
                          colors: [Color(0xff404755), Color(0xff4a5160)]),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: GradientBoxBorder(
                    gradient: isActive
                        ? const LinearGradient(
                            colors: [Color(0xff38acea), Color(0xff4378ee)])
                        : const LinearGradient(
                            colors: [Color(0xff404755), Color(0xff4a5160)]),
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
