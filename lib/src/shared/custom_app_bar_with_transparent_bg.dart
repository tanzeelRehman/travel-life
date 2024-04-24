import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class CustomAppBarWithTransparentBG extends StatelessWidget {
  const CustomAppBarWithTransparentBG({
    Key? key,
    required this.groupName,
  }) : super(key: key);

  final String groupName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Container(
          height: 50.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.black.withOpacity(.2)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  NavService.back();
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.mainButtonGradient,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  height: 30.h,
                  width: 30.w,
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 20.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              Text(
                groupName,
                style: TextStyling.bold,
              ),
              SizedBox(
                width: 10.w,
              )
            ],
          ),
        ),
      ),
    );
  }
}
