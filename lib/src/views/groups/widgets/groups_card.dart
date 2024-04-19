import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class Groupscard extends StatelessWidget {
  final DateTime dateCreated;
  final String groupName;
  final String adminName;
  final String imagepath;
  final Function() onDelete;
  final Function() onMoreIconTap;
  final Function() onEditDetailstap;
  final Function() onSeeAllMembersTap;
  const Groupscard({
    Key? key,
    required this.dateCreated,
    required this.groupName,
    required this.adminName,
    required this.imagepath,
    required this.onDelete,
    required this.onMoreIconTap,
    required this.onEditDetailstap,
    required this.onSeeAllMembersTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: AppColors.groupCardsDecoration2,
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Opacity(
                  opacity: 0.8,
                  child: Container(
                      color: Colors.black,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.r),
                          topRight: Radius.circular(15.r),
                        ),
                        child: Image.asset(
                          imagepath,
                          fit: BoxFit.fitWidth,
                        ),
                      )),
                ),
              ),
              Positioned(
                  top: 15.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat.yMMMd().format(dateCreated),
                                style: TextStyling.thin,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                groupName,
                                style:
                                    TextStyling.bold.copyWith(fontSize: 25.sp),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: onDelete,
                            icon: Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                color: AppColors.red,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                AssetIcons.deleteIcon,
                                fit: BoxFit.none,
                                //height: 30.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onSeeAllMembersTap,
                  child: Text(
                    "See all members",
                    style: TextStyling.thin.copyWith(
                        fontSize: 15.sp, decoration: TextDecoration.underline),
                  ),
                ),
                IconButton(
                    onPressed: onMoreIconTap,
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      groupName,
                      style: TextStyling.semiBold.copyWith(fontSize: 18.sp),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.46,
                      child: Row(
                        children: [
                          Text(
                            "Admin: ",
                            style: TextStyling.thin.copyWith(fontSize: 15.sp),
                          ),
                          Text(
                            adminName,
                            style:
                                TextStyling.semiBold.copyWith(fontSize: 15.sp),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onEditDetailstap,
                  child: Container(
                    height: 50.h,
                    width: 130,
                    alignment: Alignment.center,
                    child: Text(
                      'Edit Details',
                      style: TextStyling.medium,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        gradient: AppColors.mainButtonGradient),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
