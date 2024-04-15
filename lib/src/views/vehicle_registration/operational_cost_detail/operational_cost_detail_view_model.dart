import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/models/cost_category.dart';
import 'package:starter_app/src/models/operating_cost.dart';
import 'package:starter_app/src/models/vehicle.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class OperationalCostDetailViewModel extends ReactiveViewModel
    with DataViewModel, DatabaseViewModel, SupabaseAuthViewModel {
  DateTime? purchaseDate;

  onChangePurchaseDate(DateTime? v) {
    if (v != null) {
      purchaseDate = v;
      notifyListeners();
    }
  }

  CostCategory? category;
  Vehicle? selectedVehicle;

  onChangeVehicle(Vehicle? v) {
    if (v != null) {
      selectedVehicle = v;
      notifyListeners();
    }
  }

  onChangeCategory(CostCategory? v) {
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

    final res = await databaseService.getOperatingCostCategories();

    if (res != null) {
      dataService.costCategories = res;
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

  init(VehicleRegistrationAction action, OperatingCost? accessory) {
    registrationAction = action;

    if (action == VehicleRegistrationAction.edit) {
      editAccessoryID = accessory?.id;

      _setFields(accessory!);
    }
    _getAccessoryCategories();
  }

  _setFields(OperatingCost accessory) {
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
    selectedVehicle = accessory.vehicle;
    notifyListeners();
  }

  OperatingCost _createAccessory() {
    print('in create accessory');
    print(supabaseAuthService.user?.id);
    return OperatingCost(
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
      vehicle: selectedVehicle,
    );
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

  updateOrInsertAccesssory() async {
    bool success = false;
    bool hasAttachment = attachment != null;

    try {
      setBusy(true);

      final accessory = _createAccessory();

      if (editAccessoryID == null &&
          registrationAction == VehicleRegistrationAction.add) {
        final insertedAccessory =
            await databaseService.insertOperatingCost(accessory);

        success = insertedAccessory != null;

        if (insertedAccessory != null) {
          if (hasAttachment) {
            final updatedAccessoryWithAttachment =
                await databaseService.insertOrUpdateOperatingCostAttachment(
              insertedAccessory.id!,
              attachment!,
            );
            success = updatedAccessoryWithAttachment != null;
          }
        }
      } else {
        final updatedAccessory =
            await databaseService.updateOperatingCost(accessory);

        success = updatedAccessory != null;

        if (updatedAccessory != null) {
          if (hasAttachment) {
            final updatedAccessoryWithAttachment =
                await databaseService.insertOrUpdateOperatingCostAttachment(
              updatedAccessory.id!,
              attachment!,
            );
            success = updatedAccessoryWithAttachment != null;
          }
        }
      }

      if (success) {
        getAllOperationalCosts();
        NavService.back();
        Constants.customSuccessSnack(
            'Cost ${editAccessoryID == null ? 'added' : 'updated'} successfully');
      } else {
        Constants.customErrorSnack(
            'Failed to ${editAccessoryID == null ? 'add' : 'update'} cost');
      }
    } catch (e) {
      Constants.customErrorSnack('An error occurred: $e');
    } finally {
      setBusy(false);
    }
  }

  getAllOperationalCosts() async {
    dataService.operatingCosts =
        await databaseService.getAllOperationalCosts() ?? [];
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

  //! Functions Added by Tanzeel
  calculateTotalPrice(String value) {
    priceController.text = value;
    notifyListeners();
  }

  calculateTax(String taxRate) {
    double taxAmount = double.parse(purchasePriceController.text) *
        (double.parse(taxRate) / 100);
    double totalPriceAfterTax =
        double.parse(purchasePriceController.text) + taxAmount;
    priceController.text = totalPriceAfterTax.toStringAsFixed(3);
    notifyListeners();
  }
}
