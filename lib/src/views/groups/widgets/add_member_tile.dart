// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:starter_app/src/models/app_user.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/groups/add_members/add_member_view_model.dart';

class AddMemberTile extends StatelessWidget {
  final AppUser user;
  final AddMemberViewModel model;
  const AddMemberTile({Key? key, required this.user, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            user.firstname ?? '',
            style: TextStyling.thin.copyWith(fontSize: 17.sp),
          ),
          customRadioButton()
        ],
      ),
    );
  }

  Widget customRadioButton() {
    return SizedBox(
      height: 30,
      width: 30,
      child: Column(
        children: [
          model.membersIsInList(user)
              ? GestureDetector(
                  onTap: () {
                    model.removeMemberToList(user);
                  },
                  child: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: model.membersIsInList(user)
                            ? const LinearGradient(
                                colors: [Color(0xff38acea), Color(0xff4378ee)])
                            : const LinearGradient(colors: [
                                Color(0xff404755),
                                Color(0xff4a5160)
                              ])),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    model.addMemberToList(user);
                  },
                  child: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: GradientBoxBorder(
                        gradient: !model.membersIsInList(user)
                            ? const LinearGradient(
                                colors: [Color(0xff38acea), Color(0xff4378ee)])
                            : const LinearGradient(
                                colors: [Color(0xff404755), Color(0xff4a5160)]),
                        width: 2,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
