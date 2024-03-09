import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:starter_app/src/base/enums/bottom_sheet_type.dart';
import 'package:starter_app/src/configs/app_setup.locator.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

void setupBottomSheet() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.imagePickerBottomSheet:
        (context, sheetRequest, completer) => _ImagePickerBottomSheet(
              request: sheetRequest,
              completer: completer,
            )
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}

class _ImagePickerBottomSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;
  const _ImagePickerBottomSheet({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
      decoration: BoxDecoration(
        color: AppColors.appFaddedBlue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.appDarkBlue,
                    ),
                    child: IconButton(
                      iconSize: 35.w,
                      color: AppColors.white,
                      onPressed: () => completer(
                        SheetResponse(data: ImageSource.camera),
                      ),
                      icon: Icon(
                        Icons.camera_alt,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    'Camera',
                    style: TextStyling.thin.copyWith(fontSize: 14.sp),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.appDarkBlue,
                    ),
                    child: IconButton(
                      iconSize: 35.w,
                      constraints: BoxConstraints(),
                      color: AppColors.white,
                      onPressed: () => completer(
                        SheetResponse(data: ImageSource.gallery),
                      ),
                      icon: Icon(
                        Icons.photo_library,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    'Gallery',
                    style: TextStyling.thin,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
