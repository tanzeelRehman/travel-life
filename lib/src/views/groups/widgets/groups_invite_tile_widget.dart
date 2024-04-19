import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class GroupsInviteTile extends StatelessWidget {
  final String imagepath;
  final String groupName;
  final String adminName;
  final String invitedBy;
  final DateTime createdate;
  final Function() onAddIconTap;
  final Function() onMoreIconTap;
  final Function() onArrowIconTap;
  final Function() onAccept;
  final Function() onReject;
  const GroupsInviteTile({
    Key? key,
    required this.imagepath,
    required this.groupName,
    required this.adminName,
    required this.createdate,
    required this.onAddIconTap,
    required this.onMoreIconTap,
    required this.onArrowIconTap,
    required this.invitedBy,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      child: Image.asset(imagepath))),
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
                          'Members (24)',
                          style: TextStyling.thin,
                        ),
                        Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        )
                      ],
                    ),
                    Text(
                      groupName,
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
                              adminName,
                              style: TextStyling.semiBold,
                            ),
                          ],
                        ),
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
                    Text(
                      DateFormat.yMMMd().format(createdate),
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
                  invitedBy,
                  style: TextStyling.thin.copyWith(color: AppColors.appSkyBlue),
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
                onTap: onReject,
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
                onTap: onAccept,
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
