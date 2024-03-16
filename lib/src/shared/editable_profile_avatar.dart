import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/styles/app_colors.dart';

class EditableProfileAvatar extends StatelessWidget {
  const EditableProfileAvatar({
    Key? key,
    required this.avatarUrl,
    required this.onClickCamera,
    this.heightAndWidth,
  }) : super(key: key);

  final String? avatarUrl;
  final VoidCallback onClickCamera;
  final double? heightAndWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: heightAndWidth ?? 160.w,
          width: heightAndWidth ?? 160.w,
          child: CircleAvatar(
            backgroundColor: AppColors.appFaddedBlue,
            backgroundImage: avatarUrl != null
                ? CachedNetworkImageProvider(
                    avatarUrl!,
                  )
                : Image.asset(AssetImages.defaultUser).image,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onClickCamera,
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(100),
              color: AppColors.appDarkBlue,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.appDarkBlue,
                  shape: BoxShape.circle,
                ),
                height: 50.w,
                width: 50.w,
                padding: EdgeInsets.all(8),
                child: SvgPicture.asset(AssetIcons.cameraIcon),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
