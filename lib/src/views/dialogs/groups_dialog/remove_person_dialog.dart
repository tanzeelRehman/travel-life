import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class RemovePersonDialog extends StatelessWidget {
  final String name;
  final Function() no;
  final Function() yes;
  const RemovePersonDialog({
    Key? key,
    required this.name,
    required this.no,
    required this.yes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.37,
      width: context.width * 0.8,
      decoration: AppColors.groupCardsDecoration2LessTransparent,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment,
        children: [
          Container(
            height: 95.h,
            width: 90.w,
            padding: EdgeInsets.only(left: 10.sp, top: 15.sp),
            alignment: Alignment.center,
            decoration: AppColors.groupCardsDecoration2LessTransparent,
            child: Image.asset(
              AssetImages.memberRemoveIcon,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            'Are you sure? Remove!',
            style: TextStyling.bold.copyWith(fontSize: 18.sp),
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            name,
            style: TextStyling.bold.copyWith(fontSize: 25.sp),
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: no,
                child: Container(
                  height: 50.h,
                  width: MediaQuery.of(context).size.width * 0.3,
                  alignment: Alignment.center,
                  child: Text(
                    'No',
                    style: TextStyling.medium,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      gradient: AppColors.secondaryButtonGradient),
                ),
              ),
              GestureDetector(
                onTap: yes,
                child: Container(
                  height: 50.h,
                  width: MediaQuery.of(context).size.width * 0.3,
                  alignment: Alignment.center,
                  child: Text(
                    'Yes',
                    style: TextStyling.medium,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      gradient: AppColors.mainButtonGradient),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
