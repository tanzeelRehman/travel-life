import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/base/utils/utils.dart';
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

  final int maxFileSizeAllowedInMB = 5;

  final int maxFilesAllowed = 5;

  bool isAttachmentsLimitReached() {
    final int previousTotalAttachments =
        editOperatingCost?.attachments?.length ?? 0;

    final int newTotalAttachments = localAttachments?.length ?? 0;

    return previousTotalAttachments + newTotalAttachments >= maxFilesAllowed;
  }

  bool isAttachmentsLimitExceeded() {
    final int previousTotalAttachments =
        editOperatingCost?.attachments?.length ?? 0;

    final int newTotalAttachments = localAttachments?.length ?? 0;

    return previousTotalAttachments + newTotalAttachments > maxFilesAllowed;
  }

  onChangePurchaseDate(DateTime? v) {
    if (v != null) {
      purchaseDate = v;
      notifyListeners();
    }
  }

  //for edit flow (when the operatingCost is passed)
  OperatingCost? editOperatingCost;

  Vehicle? _addVehicle;

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

  final TextEditingController vatController = TextEditingController(text: '15');

  final TextEditingController priceController = TextEditingController();

  VehicleRegistrationAction? registrationAction;

  init(VehicleRegistrationAction action, OperatingCost? accessory,
      Vehicle? vehicle) {
    registrationAction = action;
    print(vehicle);

    if (action == VehicleRegistrationAction.edit) {
      editOperatingCost = accessory;

      _setFields(accessory!);
    } else {
      selectedVehicle = vehicle;
      _addVehicle = vehicle;
      notifyListeners();
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

    _addVehicle =
        accessory.vehicle; //for fetching the accessories with this vehicle
    notifyListeners();
  }

  OperatingCost _createAccessory() {
    print('in create accessory');
    print(supabaseAuthService.user?.id);
    return OperatingCost(
      id: registrationAction == VehicleRegistrationAction.edit
          ? editOperatingCost?.id
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

  List<File>? localAttachments = [];

  onClickRemoveAttachmentFromLocalAttachment(int i) {
    localAttachments?.removeAt(i);
    notifyListeners();
  }

  bool isRemoveAttachmentLoading = false;

  setRemoveAttachmentLoading(bool v) {
    isRemoveAttachmentLoading = v;
    notifyListeners();
  }

  onClickRemoveAttachment(int i) async {
    final attachment = editOperatingCost?.attachments?[i];
    if (attachment != null) {
      setRemoveAttachmentLoading(true);
      final deleted = await databaseService.removeOperatingCostAttachment(
        editOperatingCost!.id!,
        attachment.toString(),
      );
      if (deleted == null || !deleted) {
        setRemoveAttachmentLoading(false);
        Constants.customWarningSnack('Failed to delete attachment');
        return;
      }
      setRemoveAttachmentLoading(false);
      editOperatingCost?.attachments?.removeAt(i);
      notifyListeners();

      getAllOperationalCosts();
    }
  }

  onClickAddAttachments() async {
    if (isAttachmentsLimitReached()) {
      Constants.customWarningSnack(
        'You can only add upto $maxFilesAllowed attachments, remove some to add more',
      );
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
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
      for (int i = 0; i < result.files.length; i++) {
        final file = File(result.files[i].path!);
        final fileSize = await file.length();

        if (fileSize <= maxFileSizeAllowedInMB * 1024 * 1024) {
          localAttachments?.add(file);
        } else {
          // Handle case where attachment size exceeds max allowed size in MB
          Constants.customWarningSnack(
            '${UtilFunctions.getFileNameWithExtension(file)} size exceeds $maxFileSizeAllowedInMB MB, Please choose a attachment under $maxFileSizeAllowedInMB mb',
          );
          print('Attachment size exceeds $maxFileSizeAllowedInMB MB');
        }

        notifyListeners();
      }
    }
  }

  bool validateInput() {
    bool isValid = true;
    StringBuffer message = StringBuffer('Please fill all required fields: ');

    if (selectedVehicle == null) {
      message.write('Vehicle, ');
      isValid = false;
    }
    if (category == null) {
      message.write('Category, ');
      isValid = false;
    }
    if (purchasePriceController.text.isEmpty) {
      message.write('Purchase Price, ');
      isValid = false;
    }
    if (priceController.text.isEmpty) {
      message.write('Price');
      isValid = false;
    }

    // Remove the last comma and space if present
    if (!isValid) {
      final errorMsg = message.toString();
      if (errorMsg.endsWith(', ')) {
        message.clear();
        message.write(errorMsg.substring(0, errorMsg.length - 2));
      }
      Constants.customWarningSnack(message.toString());
    }

    return isValid;
  }

  updateOrInsertAccesssory() async {
    if (isAttachmentsLimitExceeded()) {
      Constants.customWarningSnack(
          'Max attachments limit ($maxFilesAllowed) reached, Please remove some attachments');
      return;
    }
    if (!validateInput()) {
      return;
    }
    bool success = false;
    bool hasAttachment =
        localAttachments != null && localAttachments!.isNotEmpty;

    try {
      setBusy(true);

      final accessory = _createAccessory();

      if (editOperatingCost?.id == null &&
          registrationAction == VehicleRegistrationAction.add) {
        final insertedAccessory =
            await databaseService.insertOperatingCost(accessory);

        success = insertedAccessory != null;

        if (insertedAccessory != null) {
          if (hasAttachment) {
            final updatedOperationalCostWithAttachment =
                await databaseService.addOperatingCostAttachments(
                    insertedAccessory.id!, localAttachments!);
            success = updatedOperationalCostWithAttachment != null;
          }
        }
      } else {
        final updatedAccessory =
            await databaseService.updateOperatingCost(accessory);

        success = updatedAccessory != null;

        if (updatedAccessory != null) {
          if (hasAttachment) {
            final updatedOperationalCostWithAttachment =
                await databaseService.addOperatingCostAttachments(
                    updatedAccessory.id!, localAttachments!);
            success = updatedOperationalCostWithAttachment != null;
          }
        }
      }

      if (success) {
        getAllOperationalCosts();
        NavService.back();
        Constants.customSuccessSnack(
            'Cost ${editOperatingCost?.id == null ? 'added' : 'updated'} successfully');
      } else {
        Constants.customErrorSnack(
            'Failed to ${editOperatingCost?.id == null ? 'add' : 'update'} cost');
      }
    } catch (e) {
      Constants.customErrorSnack('An error occurred: $e');
    } finally {
      setBusy(false);
    }
  }

  getAllOperationalCosts() async {
    dataService.operatingCosts = await databaseService
            .getAllOperationalCostsOfVehicle(_addVehicle!.id!) ??
        [];
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

  calculateTax(String taxRate) {
    double purchasePrice = purchasePriceController.text.isEmpty
        ? 0
        : double.parse(purchasePriceController.text);

    double rate = taxRate.isEmpty ? 0 : double.parse(taxRate);

    double taxAmount = purchasePrice * (rate / 100);
    double totalPriceAfterTax = purchasePrice + taxAmount;
    priceController.text = totalPriceAfterTax.toStringAsFixed(3);
    notifyListeners();
  }
}
