import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:starter_app/src/base/enums/bottom_sheet_type.dart';
import 'package:starter_app/src/configs/app_setup.locator.dart';

class BottSheetViewModel extends BaseViewModel {
  static BottomSheetService _service = locator<BottomSheetService>();

  static Future<ImageSource?> showImagePickerOptions() async {
    var sheetResponse = await _service.showCustomSheet(
      variant: BottomSheetType.imagePickerBottomSheet,
    );
    return sheetResponse?.data;
  }
}
