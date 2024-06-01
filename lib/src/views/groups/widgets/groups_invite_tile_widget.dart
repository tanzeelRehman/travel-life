import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/models/app_user.dart';
import 'package:starter_app/src/models/invited_group.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class GroupsInviteTile extends StatelessWidget {
  final InvitedGroup invitedGroup;
  final VoidCallback onAddIconTap;
  final VoidCallback onMoreIconTap;
  final VoidCallback onArrowIconTap;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final bool isButtonLoading;
  const GroupsInviteTile({
    Key? key,
    required this.isButtonLoading,
    required this.invitedGroup,
    required this.onAddIconTap,
    required this.onMoreIconTap,
    required this.onArrowIconTap,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: (invitedGroup.group?.isEnabled ?? true) ? 1 : 0.5,
      child: Container(
        margin: EdgeInsets.only(bottom: 25.h),
        height: 280.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
        width: MediaQuery.of(context).size.width,
        decoration: AppColors.groupCardsDecoration,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: SizedBox(
                    height: 110.h,
                    width: 110.w,
                    child: invitedGroup.group?.groupImage != null
                        ? CachedNetworkImage(
                            imageUrl: invitedGroup.group!.groupImage!,
                          )
                        : Image.asset(
                            AssetImages.defaultImage,
                          ),
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Members (${invitedGroup.groupTotalMembers ?? 0})',
                            style: TextStyling.thin,
                          ),
                          Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          )
                        ],
                      ),
                      Text(
                        invitedGroup.group?.name ?? '----',
                        style: TextStyling.semiBold,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Admin: ",
                                style: TextStyling.thin,
                              ),
                              Text(
                                invitedGroup.group?.admin?.firstname ?? '----',
                                style: TextStyling.semiBold,
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: (invitedGroup.group?.isEnabled ?? true)
                                ? onArrowIconTap
                                : null,
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
                      Text(
                        invitedGroup.group?.createdAt != null
                            ? DateFormat.yMMMd()
                                .format(invitedGroup.group!.createdAt!)
                            : '----',
                        style: TextStyling.thin,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 35.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: AppColors.vehicleRegTextFieldBoxShadows),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Invited by: ',
                    style: TextStyling.thin,
                  ),
                  Text(
                    getInvitedByString(invitedGroup.invitedBy),
                    style:
                        TextStyling.thin.copyWith(color: AppColors.appSkyBlue),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: isButtonLoading
                      ? null
                      : (invitedGroup.group?.isEnabled ?? true)
                          ? onReject
                          : null,
                  child: Container(
                    height: 50.h,
                    width: MediaQuery.of(context).size.width * 0.4,
                    alignment: Alignment.center,
                    child: Text(
                      'Reject',
                      style: TextStyling.medium,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        gradient: AppColors.secondaryButtonGradient),
                  ),
                ),
                GestureDetector(
                  onTap: isButtonLoading
                      ? null
                      : (invitedGroup.group?.isEnabled ?? true)
                          ? onAccept
                          : null,
                  child: Container(
                    height: 50.h,
                    width: MediaQuery.of(context).size.width * 0.4,
                    alignment: Alignment.center,
                    child: Text(
                      'Accept',
                      style: TextStyling.medium,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      gradient: AppColors.mainButtonGradient,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

String getInvitedByString(List<AppUser>? users) {
  if (users == null || users.isEmpty) {
    return '----';
  }
  String res = '';

  users.forEach((element) {
    if (element.firstname != null && element.firstname!.isNotEmpty) {
      res += '${element.firstname}, ';
    }
  });

  res = res.trimRight();
  res = res.substring(0, res.length - 1);

  return res;
}
