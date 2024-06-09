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
  final VoidCallback onDelete;
  final VoidCallback onMoreIconTap;
  final VoidCallback onEditDetailstap;
  final VoidCallback onInviteMemberTap;
  final VoidCallback onTap;
  const Groupscard({
    Key? key,
    required this.group,
    required this.onDelete,
    required this.onMoreIconTap,
    required this.onEditDetailstap,
    required this.onInviteMemberTap,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: (group.isEnabled ?? true) ? 1 : 0.5,
      child: GestureDetector(
        onTap: (group.isEnabled ?? true) ? onTap : null,
        child: Container(
          margin: EdgeInsets.only(bottom: 20.h),
          decoration: AppColors.groupCardsDecoration2MoreTransparent,
          // height: MediaQuery.of(context).size.height * 0.35,
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
                        ),
                      ),
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
                                // decoration: BoxDecoration(
                                //   color: AppColors.red,
                                //   shape: BoxShape.circle,
                                // ),
                                // child: SvgPicture.asset(
                                //   AssetIcons.deleteIcon,
                                //   fit: BoxFit.none,
                                //   //height: 30.h,
                                // ),
                                decoration: BoxDecoration(
                                  color: (group.isEnabled ?? true)
                                      ? AppColors.red
                                      : Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: (group.isEnabled ?? true)
                                    ? SvgPicture.asset(
                                        AssetIcons.deleteIcon,
                                        fit: BoxFit.scaleDown,
                                      )
                                    : Icon(
                                        Icons.check,
                                        color: AppColors.white,
                                        size: 20.sp,
                                      ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
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
                      onTap:
                          (group.isEnabled ?? true) ? onInviteMemberTap : null,
                      child: Text(
                        "Invite members",
                        style: TextStyling.medium.copyWith(
                          fontSize: 15.sp,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.appSkyBlueLight,
                          color: AppColors.appSkyBlueLight,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed:
                          (group.isEnabled ?? true) ? onMoreIconTap : null,
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 12.w, left: 12.w, bottom: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            group.name ?? '----',
                            style:
                                TextStyling.semiBold.copyWith(fontSize: 18.sp),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Text(
                                "Admin: ",
                                style:
                                    TextStyling.thin.copyWith(fontSize: 15.sp),
                              ),
                              Text(
                                group.admin?.firstname ?? '----',
                                style: TextStyling.semiBold
                                    .copyWith(fontSize: 15.sp),
                              ),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap:
                          (group.isEnabled ?? true) ? onEditDetailstap : null,
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
      ),
    );
  }
}
