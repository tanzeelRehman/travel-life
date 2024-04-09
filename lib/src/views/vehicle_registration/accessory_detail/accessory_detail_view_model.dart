import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/models/accessory.dart';
import 'package:starter_app/src/models/accessory_category.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';
import 'package:starter_app/src/services/local/bottom_sheet_service.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class AccessoryDetailViewModel extends ReactiveViewModel
    with DataViewModel, DatabaseViewModel, SupabaseAuthViewModel {
  DateTime? purchaseDate;

  onChangePurchaseDate(DateTime? v) {
    if (v != null) {
      purchaseDate = v;
      notifyListeners();
    }
  }

  AccessoryCategory? category;

  onChangeCategory(AccessoryCategory? v) {
    if (v != null) {
      category = v;
      notifyListeners();
    }
  }

  bool isCategoriesLoading = false;

  setIsCategoriesLoading(bool v) {
    isCategoriesLoading = v;
    notifyListeners();
  }

  _getAccessoryCategories() async {
    setIsCategoriesLoading(true);

    final res = await databaseService.getAccessoryCategories();

    if (res != null) {
      dataService.accessoryCategories = res;
      notifyListeners();
    }

    setIsCategoriesLoading(false);
  }

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController purchasePriceController = TextEditingController();

  final TextEditingController vatController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  int? editAccessoryID;
  VehicleRegistrationAction? registrationAction;

  init(VehicleRegistrationAction action, Accessory? accessory) {
    registrationAction = action;

    if (action == VehicleRegistrationAction.edit) {
      editAccessoryID = accessory?.id;

      _setFields(accessory!);
    }
    _getAccessoryCategories();
  }

  _setFields(Accessory accessory) {
    descriptionController.text = accessory.description ?? '';
    purchaseDate = accessory.purchaseDate;
    category = accessory.category;
    purchasePriceController.text = accessory.purchasePrice == null
        ? ''
        : accessory.purchasePrice.toString();
    vatController.text = accessory.vat == null ? '' : accessory.vat.toString();
    purchaseDate = accessory.purchaseDate;
    priceController.text =
        double.tryParse(accessory.purchasePrice.toString())?.toString() ?? '';
    priceController.text = accessory.total != null
        ? accessory.total.toString()
        : calculatePrice(accessory.purchasePrice, accessory.vat).toString();
    notifyListeners();
  }

  Accessory _createAccessory() {
    print('in create accessory');
    print(supabaseAuthService.user?.id);
    return Accessory(
      id: registrationAction == VehicleRegistrationAction.edit
          ? editAccessoryID
          : null,
      user: supabaseAuthService.user?.id,
      description: descriptionController.text,
      purchaseDate: purchaseDate,
      category: category,
      purchasePrice: double.tryParse(purchasePriceController.text),
      vat: double.tryParse(vatController.text),
      total: calculatePrice(purchasePriceController.text, vatController.text),
    );
  }

  File? selectedImage;

  Future<void> _pickCameraImage() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 60);
      if (image == null) return;

      final imageTemp = File(image.path);

      selectedImage = imageTemp;
      notifyListeners();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> _pickGalleryImage() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 60);
      if (image == null) return;

      final imageTemp = File(image.path);

      selectedImage = imageTemp;

      notifyListeners();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  onClickRemoveImage() {
    selectedImage = null;
    notifyListeners();
  }

  onClickAddImage() async {
    final ImageSource? imageSource =
        await BottSheetViewModel.showImagePickerOptions();
    if (imageSource == null) return;

    if (imageSource == ImageSource.camera) {
      _pickCameraImage();
    } else if (imageSource == ImageSource.gallery) {
      _pickGalleryImage();
    }
  }

  File? attachment;

  onClickRemoveAttachment() {
    attachment = null;
    notifyListeners();
  }

  onClickAddAttachment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowCompression: true,
      allowedExtensions: [
        'pdf',
        'doc',
        'docx',
        'jpg',
        'jpeg',
        'png',
        //TODO: add more

        // for iphone
      ], // optional
      type: FileType.custom,

      dialogTitle: 'Select Attachment',
      compressionQuality: 40,
    );

    if (result != null) {
      final file = File(result.files.single.path!);
      final fileSize = await file.length();

      if (fileSize <= 5 * 1024 * 1024) {
        attachment = file;
      } else {
        // Handle case where attachment size exceeds 5 MB
        Constants.customWarningSnack(
            'Attachment size exceeds 5 MB, Please choose a attachment under 5 mb');
        print('Attachment size exceeds 5 MB');
        // You may want to display an error message to the user here
      }

      notifyListeners();
    }
  }

  // updateOrInsertAccesssory() async {
  //   if (editAccessoryID == null &&
  //       registrationAction == VehicleRegistrationAction.add) {
  //     setBusy(true);

  //     final inserted =
  //         await databaseService.insertAccessory(_createAccessory());

  //     if (inserted != null && selectedImage != null) {
  //       final updatedUserWithProfile =
  //           await databaseService.insertOrUpdateAccessoryImage(
  //         inserted.id!,
  //         selectedImage!,
  //       );
  //       setBusy(false);

  //       if (updatedUserWithProfile != null) {
  //         NavService.back();
  //         Constants.customSuccessSnack('Vehicle added successfully');
  //       }
  //       return;
  //     }
  //     setBusy(false);

  //     if (inserted != null) {
  //       NavService.back();
  //       Constants.customSuccessSnack('Accessory added successfully');
  //     }
  //   } else {
  //     setBusy(true);
  //     final inserted =
  //         await databaseService.updateAccessory(_createAccessory());
  //     setBusy(false);

  //     if (inserted != null && selectedImage != null) {
  //       final updatedUserWithProfile =
  //           await databaseService.insertOrUpdateAccessoryImage(
  //         inserted.id!,
  //         selectedImage!,
  //       );
  //       setBusy(false);

  //       if (updatedUserWithProfile != null) {
  //         NavService.back();
  //         Constants.customSuccessSnack('Accessory updated successfully');
  //       }
  //       return;
  //     }

  //     setBusy(false);

  //     if (inserted != null) {
  //       NavService.back();
  //       Constants.customSuccessSnack('Vehicle updated successfully');
  //     }
  //   }
  // }

  updateOrInsertAccesssory() async {
    bool success = false;
    bool hasImage = selectedImage != null;
    bool hasAttachment = attachment != null;

    try {
      setBusy(true);

      final accessory = _createAccessory();

      if (editAccessoryID == null &&
          registrationAction == VehicleRegistrationAction.add) {
        final insertedAccessory =
            await databaseService.insertAccessory(accessory);
        success = insertedAccessory != null;

        if (insertedAccessory != null) {
          if (hasImage) {
            final updatedAccessoryWithImage =
                await databaseService.insertOrUpdateAccessoryImage(
              insertedAccessory.id!,
              selectedImage!,
            );
            success = updatedAccessoryWithImage != null;
          }
          if (hasAttachment) {
            final updatedAccessoryWithAttachment =
                await databaseService.insertOrUpdateAccessoryAttachment(
              insertedAccessory.id!,
              attachment!,
            );
            success = updatedAccessoryWithAttachment != null;
          }
        }
      } else {
        final updatedAccessory =
            await databaseService.updateAccessory(accessory);

        success = updatedAccessory != null;

        if (updatedAccessory != null) {
          if (hasImage) {
            final updatedAccessoryWithImage =
                await databaseService.insertOrUpdateAccessoryImage(
              updatedAccessory.id!,
              selectedImage!,
            );
            success = updatedAccessoryWithImage != null;
          }
          if (hasAttachment) {
            final updatedAccessoryWithAttachment =
                await databaseService.insertOrUpdateAccessoryAttachment(
              updatedAccessory.id!,
              attachment!,
            );
            success = updatedAccessoryWithAttachment != null;
          }
        }
      }

      if (success) {
        NavService.back();
        Constants.customSuccessSnack(
            'Accessory ${editAccessoryID == null ? 'added' : 'updated'} successfully');
      } else {
        Constants.customErrorSnack(
            'Failed to ${editAccessoryID == null ? 'add' : 'update'} accessory');
      }
    } catch (e) {
      Constants.customErrorSnack('An error occurred: $e');
    } finally {
      setBusy(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    descriptionController.dispose();
    purchasePriceController.dispose();
    vatController.dispose();
    priceController.dispose();
  }

  double calculatePrice(dynamic purchasePrice, dynamic vat) {
    double price = double.tryParse(purchasePrice.toString()) ?? 0;
    double vatValue = double.tryParse(vat.toString()) ?? 0;

    return price + vatValue;
  }
}
