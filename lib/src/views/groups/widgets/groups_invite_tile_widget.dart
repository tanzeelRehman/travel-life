import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class GroupsInviteTile extends StatelessWidget {
  final String imagepath;
  final String groupName;
  final String adminName;
  final DateTime createdate;
  final Function() onAddIconTap;
  final Function() onMoreIconTap;
  final Function() onArrowIconTap;
  const GroupsInviteTile({
    Key? key,
    required this.imagepath,
    required this.groupName,
    required this.adminName,
    required this.createdate,
    required this.onAddIconTap,
    required this.onMoreIconTap,
    required this.onArrowIconTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      height: 200.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      width: MediaQuery.of(context).size.width,
      decoration: AppColors.groupCardsDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: SizedBox(
                  height: 120.h, width: 100.w, child: Image.asset(imagepath))),
          SizedBox(
            width: 15.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Members (24)',
                      style: TextStyling.thin,
                    ),
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
                groupName,
                style: TextStyling.semiBold,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Row(
                  children: [
                    Text(
                      "Admin: ",
                      style: TextStyling.thin,
                    ),
                    Text(
                      adminName,
                      style: TextStyling.semiBold,
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
                DateFormat.yMMMd().format(createdate),
                style: TextStyling.thin,
              )
            ],
          )
        ],
      ),
    );
  }
}
