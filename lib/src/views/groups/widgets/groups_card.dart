import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class Groupscard extends StatelessWidget {
  final Group group;
  final Function() onDelete;
  final Function() onMoreIconTap;
  final Function() onEditDetailstap;
  final Function() onSeeAllMembersTap;
  final Function() onTap;
  const Groupscard({
    Key? key,
    required this.group,
    required this.onDelete,
    required this.onMoreIconTap,
    required this.onEditDetailstap,
    required this.onSeeAllMembersTap,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: AppColors.groupCardsDecoration2MoreTransparent,
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
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r),
                          ),
                          color: Colors.black,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r),
                          ),
                          child: group.groupImage != null
                              ? CachedNetworkImage(
                                  imageUrl: group.groupImage!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  AssetImages.defaultImage,
                                  fit: BoxFit.fitHeight,
                                ),
                        )),
                  ),
                ),
                Positioned(
                    top: 15.h,
                    right: 7.w,
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
                                  group.createdAt != null
                                      ? DateFormat.yMMMd()
                                          .format(group.createdAt!)
                                      : '----',
                                  style: TextStyling.thin,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  group.name ?? '----',
                                  style: TextStyling.bold
                                      .copyWith(fontSize: 25.sp),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: onDelete,
                              child: Container(
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
                            )
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
                          fontSize: 15.sp,
                          decoration: TextDecoration.underline),
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
                        group.name ?? '----',
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
                              group.admin?.firstname ?? '----',
                              style: TextStyling.semiBold
                                  .copyWith(fontSize: 15.sp),
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
      ),
    );
  }
}
