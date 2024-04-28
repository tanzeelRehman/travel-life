// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class AddMemberSearchBar extends StatelessWidget {
  final TextEditingController seacrchController;
  final Function() onSearch;
  const AddMemberSearchBar({
    Key? key,
    required this.seacrchController,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.88,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: AppColors.vehicleRegTextFieldBoxShadows,
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            height: 55.h,
            alignment: Alignment.center,
            width: context.width * 0.8,
            child: TextField(
                controller: seacrchController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search user by name...",
                    hintStyle: TextStyling.thin.copyWith(
                      fontSize: 15.sp,
                      color: AppColors.white.withOpacity(0.7),
                    )),
                style: TextStyling.thin.copyWith(
                  fontSize: 15.sp,
                  color: AppColors.white.withOpacity(0.7),
                ),
                cursorColor: AppColors.white),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onSearch,
              child: Container(
                height: 55.h,
                width: 50.w,
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: AppColors.mainButtonGradient),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 32.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
