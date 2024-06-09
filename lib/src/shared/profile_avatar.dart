import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/styles/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    Key? key,
    required this.onClickProfile,
    this.avatarUrl,
    this.heightAndWidth,
  }) : super(key: key);

  final VoidCallback onClickProfile;

  final String? avatarUrl;
  final double? heightAndWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClickProfile,
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.appSkyBlue,
            width: 1,
          ),
          shape: BoxShape.circle,
        ),
        child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.appSkyBlue,
              width: 1,
            ),
            shape: BoxShape.circle,
          ),
          child: SizedBox(
            height: heightAndWidth ?? 70.w,
            width: heightAndWidth ?? 70.w,
            child: CircleAvatar(
              backgroundImage: avatarUrl != null
                  ? CachedNetworkImageProvider(avatarUrl!)
                  : Image.asset(AssetImages.defaultUser).image,
            ),
          ),
        ),
      ),
    );
  }
}
