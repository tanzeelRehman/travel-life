import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class GroupsTile extends StatelessWidget {
  // final String imagepath;
  // final String groupName;
  // final String adminName;
  // final DateTime createdate;
  final Group group;
  final Function() onAddIconTap;
  final Function() onMoreIconTap;
  final Function() onArrowIconTap;
  const GroupsTile({
    Key? key,
    required this.group,
    required this.onAddIconTap,
    required this.onMoreIconTap,
    required this.onArrowIconTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      height: 155.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      width: MediaQuery.of(context).size.width,
      decoration: AppColors.groupCardsDecoration,
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: group.groupImage != null && group.groupImage!.isNotEmpty
                  ? CachedNetworkImage(imageUrl: group.groupImage ?? "")
                  : Image.asset(AssetImages.defaultImage),
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: onAddIconTap,
                      child: Container(
                        height: 35.h,
                        width: 35.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.appDarkBlue),
                        child: Icon(
                          Icons.person_add,
                          color: Colors.white,
                          size: 17.sp,
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: onMoreIconTap,
                        icon: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              Text(
                group.name ?? "",
                style: TextStyling.semiBold.copyWith(fontSize: 15.sp),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.46,
                child: Row(
                  children: [
                    Text(
                      "Admin: ",
                      style: TextStyling.thin.copyWith(fontSize: 14.sp),
                    ),
                    Text(
                      group.admin?.firstname ?? "",
                      style: TextStyling.semiBold.copyWith(fontSize: 14.sp),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: onArrowIconTap,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: AppColors.mainButtonGradient,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        height: 25.h,
                        width: 25.w,
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 20.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                DateFormat.yMMMd().format(group.createdAt ?? DateTime.now()),
                style: TextStyling.thin.copyWith(fontSize: 14.sp),
              )
            ],
          )
        ],
      ),
    );
  }
}
