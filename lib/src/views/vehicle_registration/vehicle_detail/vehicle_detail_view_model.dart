import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart';
import 'package:starter_app/src/base/enums/vehicle_status.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/models/accessory.dart';
import 'package:starter_app/src/models/manufacturor.dart';
import 'package:starter_app/src/models/operating_cost.dart';
import 'package:starter_app/src/models/vehicle.dart';
import 'package:starter_app/src/models/vehicle_model.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';
import 'package:starter_app/src/services/local/bottom_sheet_service.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class VehicleDetailViewModel extends ReactiveViewModel
    with DatabaseViewModel, SupabaseAuthViewModel, DataViewModel {
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  late final VehicleRegistrationAction _registrationAction;

  //FOR EDITING AND ADDING PURPOSES
  List<Manufacturor>? manufacturers;
  List<VehicleModel>? vehicleModels;

  //FOR EDITING PURPOSES
  Manufacturor? selectedManufacturer;

  onChangeManufacturer(Manufacturor? v) {
    if (v != null) {
      selectedManufacturer = v;
      selectedVehicleModel = null;
      _getAllVehicleModels();
      notifyListeners();
    }
  }

  VehicleModel? selectedVehicleModel;

  onChangeVehicleModel(VehicleModel? v) {
    if (v != null) {
      selectedVehicleModel = v;
      if (descriptionController.text.isEmpty) {
        descriptionController.text =
            "${selectedManufacturer?.name} ${selectedVehicleModel?.model}";
      }
      notifyListeners();
    }
  }

  int? editVehicleID;

  String? manufacturer;
  String? model;

  bool isPrimaryVehicle = false;
  bool isInUse = false;

  toggleIsPrimaryVehicle(bool? v) {
    isPrimaryVehicle = v ?? false;
    notifyListeners();
  }

  toggleIsInUse(bool? v) {
    isInUse = v ?? false;
    notifyListeners();
  }

  DateTime? purchaseDate;

  onChangePurchaseDate(DateTime? v) {
    if (v != null) {
      purchaseDate = v;
      notifyListeners();
    }
  }

  onChangeLastServiceDate(DateTime? v) {
    if (v != null) {
      lastServiceDate = v;
      notifyListeners();
    }
  }

  onChangeManufactureYear(DateTime? v) {
    if (v != null) {
      manufactureYear = v;
      notifyListeners();
    }
  }

  onChangeWarrentyExpiryDate(DateTime? v) {
    if (v != null) {
      warrentyExpiryDate = v;

      //TODO: calculate warrenty period

      if (purchaseDate != null) {
        // Calculate warranty period
        final warrantyPeriodInDays =
            warrentyExpiryDate!.difference(purchaseDate!).inDays;
        final warrantyPeriodInMonths =
            warrantyPeriodInDays ~/ 30; // Assuming 30 days per month

        if (warrantyPeriodInMonths < 0) {
          warentyPeriodController.text = '0';
        } else {
          warentyPeriodController.text = warrantyPeriodInMonths.toString();
        }

        print('Warranty period in months: $warrantyPeriodInMonths');

        // You can use warrantyPeriodInMonths as needed

        notifyListeners();
      }
      notifyListeners();
    }
  }

  DateTime? lastServiceDate;
  DateTime? manufactureYear;
  DateTime? warrentyExpiryDate;

  //! By Default both set to active
  VehicleStatus? status = VehicleStatus.active;
  VehicleStatus? selectedStatus =
      VehicleStatus.active; //temporarilySelected for dialog

  toggleStatus(VehicleStatus v) {
    selectedStatus = v;
    notifyListeners();
    rebuildUi();
  }

  onSelectStatus(VehicleStatus? v) {
    if (v != null) {
      status = v;
      notifyListeners();
    }
  }

  final TextEditingController registrationNumberController =
      TextEditingController();

  final TextEditingController vinController = TextEditingController();

  final TextEditingController tankCapacityController =
      TextEditingController(); //will only accept double

  final TextEditingController serviceController =
      TextEditingController(); //will only accept int

  final TextEditingController dailyDistanceController =
      TextEditingController(); //will only accept double

  final TextEditingController odometerReadingController =
      TextEditingController(); //will only accept double

  final TextEditingController horsePowerController = TextEditingController();

  final TextEditingController fuelConsumptionController =
      TextEditingController(); //will only accept double

  final TextEditingController warentyPeriodController =
      TextEditingController(); //will only accept double

  final TextEditingController tireFrontController = TextEditingController();

  final TextEditingController tireRearController = TextEditingController();

  init(VehicleRegistrationAction action, Vehicle? vehicle) async {
    _registrationAction = action;
    if (action == VehicleRegistrationAction.edit && vehicle != null) {
      _setFieldsForEditing(vehicle);
      _getAccessoryCategories();
      if (selectedManufacturer != null) {
        _getAllVehicleModels();
      }
      getAllAccessories(vehicle.id!);
      getAllOperationalCosts(vehicle.id!);
    }
    await _getAllVehicleManufacturer();
  }

  _setFieldsForEditing(Vehicle vehicle) {
    print('Vehicle for editing:');
    print(vehicle.toString());

    editVehicleID = vehicle.id;
    descriptionController.text = vehicle.description ?? '';
    priceController.text =
        vehicle.price == null ? '' : vehicle.price.toString();
    selectedManufacturer = vehicle.manufacturer;
    selectedVehicleModel = vehicle.model;
    isPrimaryVehicle = vehicle.primaryVehicle ?? false;
    isInUse = vehicle.inUse ?? false;
    purchaseDate = vehicle.purchaseDate;
    registrationNumberController.text = vehicle.regNo ?? '';
    vinController.text = vehicle.vinNo ?? '';
    tankCapacityController.text = vehicle.tankCapacity ?? '';
    serviceController.text = vehicle.serviceInterval == null
        ? ''
        : vehicle.serviceInterval.toString();
    lastServiceDate = vehicle.lastService;
    dailyDistanceController.text =
        vehicle.dailyDistance == null ? '' : vehicle.dailyDistance.toString();
    odometerReadingController.text =
        vehicle.odometer == null ? '' : vehicle.odometer.toString();
    status = vehicle.status;
    horsePowerController.text = vehicle.horsepower ?? '';
    fuelConsumptionController.text =
        vehicle.consumption == null ? '' : vehicle.consumption.toString();
    warrentyExpiryDate = vehicle.warrantyExpiryDate;
    warentyPeriodController.text =
        vehicle.warrantyPeriod == null ? '' : vehicle.warrantyPeriod.toString();
    manufactureYear = vehicle.manufactureYear != null
        ? DateTime(vehicle.manufactureYear!)
        : null;
    tireFrontController.text = vehicle.tireFront ?? '';
    tireRearController.text = vehicle.tireRear ?? '';
  }

  Vehicle _createVehicle() {
    Vehicle v = Vehicle();
    if (_registrationAction == VehicleRegistrationAction.add) {
      v = Vehicle(
        consumption: int.tryParse(fuelConsumptionController.text),
        dailyDistance: int.tryParse(dailyDistanceController.text),
        description: descriptionController.text,
        inUse: isInUse,
        lastService: lastServiceDate,
        manufactureYear: manufactureYear?.year,
        manufacturer: selectedManufacturer,
        model: selectedVehicleModel,
        odometer: int.tryParse(odometerReadingController.text),
        price: double.tryParse(priceController.text),
        primaryVehicle: isPrimaryVehicle,
        purchaseDate: purchaseDate,
        regNo: registrationNumberController.text,
        serviceInterval: int.tryParse(serviceController.text),
        status: status,
        tankCapacity: tankCapacityController.text,
        vinNo: vinController.text,
        warrantyExpiryDate: warrentyExpiryDate,
        warrantyPeriod: int.tryParse(warentyPeriodController.text),
        horsepower: horsePowerController.text,
        user: supabaseAuthService.user?.id,
        tireFront: tireFrontController.text,
        tireRear: tireRearController.text,
      );
    } else {
      v = Vehicle(
        id: editVehicleID,
        consumption: int.tryParse(fuelConsumptionController.text),
        dailyDistance: int.tryParse(dailyDistanceController.text),
        description: descriptionController.text,
        inUse: isInUse,
        lastService: lastServiceDate,
        manufactureYear: manufactureYear?.year,
        manufacturer: selectedManufacturer,
        model: selectedVehicleModel,
        odometer: int.tryParse(odometerReadingController.text),
        price: double.tryParse(priceController.text),
        primaryVehicle: isPrimaryVehicle,
        purchaseDate: purchaseDate,
        regNo: registrationNumberController.text,
        serviceInterval: int.tryParse(serviceController.text),
        status: status,
        tankCapacity: tankCapacityController.text,
        vinNo: vinController.text,
        warrantyExpiryDate: warrentyExpiryDate,
        warrantyPeriod: int.tryParse(warentyPeriodController.text),
        horsepower: horsePowerController.text,
        user: supabaseAuthService.user?.id,
        tireFront: tireFrontController.text,
        tireRear: tireRearController.text,
      );
    }
    return v;
  }

  bool validateInput() {
    bool isValid = true;
    StringBuffer message = StringBuffer('Please fill all required fields: ');

    if (selectedManufacturer == null) {
      message.write('Manufacturer, ');
      isValid = false;
    }
    if (selectedVehicleModel == null) {
      message.write('Model, ');
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

  updateOrInsertVehicle() async {
    if (!validateInput()) {
      return;
    }
    if (editVehicleID == null &&
        _registrationAction == VehicleRegistrationAction.add) {
      setBusy(true);

      final inserted = await databaseService.insertVehicle(_createVehicle());

      if (inserted != null && selectedImage != null) {
        final updatedUserWithProfile = await databaseService.uploadVehicleImage(
          inserted.id!,
          selectedImage!,
        );
        setBusy(false);

        if (updatedUserWithProfile != null) {
          getAllVehicles();
          NavService.back();
          Constants.customSuccessSnack('Vehicle added successfully');
        }
        return;
      }
      setBusy(false);

      if (inserted != null) {
        getAllVehicles();
        NavService.back();
        Constants.customSuccessSnack('Vehicle added successfully');
      }
    } else {
      setBusy(true);
      final inserted = await databaseService.updateVehicle(_createVehicle());
      setBusy(false);

      if (inserted != null && selectedImage != null) {
        final updatedUserWithProfile = await databaseService.uploadVehicleImage(
          inserted.id!,
          selectedImage!,
        );
        setBusy(false);

        if (updatedUserWithProfile != null) {
          getAllVehicles();
          NavService.back();
          Constants.customSuccessSnack('Vehicle updated successfully');
        }
        return;
      }

      setBusy(false);

      if (inserted != null) {
        getAllVehicles();
        NavService.back();
        Constants.customSuccessSnack('Vehicle updated successfully');
      }
    }
  }

  getAllVehicles() async {
    dataService.vehicles = await databaseService.getAllVehicles() ?? [];
    notifyListeners();
  }

  bool isManufacturersLoading = false;
  bool isVehicleModelsLoading = false;

  setIsManufacturersLoading(bool v) {
    isManufacturersLoading = v;
    notifyListeners();
  }

  setIsVehicleModelsLoading(bool v) {
    isVehicleModelsLoading = v;
    notifyListeners();
  }

  _getAllVehicleManufacturer() async {
    setIsManufacturersLoading(true);
    dataService.manufacturors =
        await databaseService.getAllManufacturers() ?? [];
    setIsManufacturersLoading(false);
    notifyListeners();
  }

  _getAllVehicleModels() async {
    if (selectedManufacturer == null) {
      return;
    }
    setIsVehicleModelsLoading(true);
    dataService.vehicleModels =
        await databaseService.getAllVehicleModels(selectedManufacturer!.id!) ??
            [];
    setIsVehicleModelsLoading(false);

    notifyListeners();
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

  @override
  void dispose() {
    super.dispose();
    descriptionController.dispose();
    priceController.dispose();
    registrationNumberController.dispose();
    vinController.dispose();
    tankCapacityController.dispose();
    serviceController.dispose();
    dailyDistanceController.dispose();
    odometerReadingController.dispose();
    horsePowerController.dispose();
    fuelConsumptionController.dispose();
    warentyPeriodController.dispose();
    tireFrontController.dispose();
    tireRearController.dispose();
  }

  //////////////////////////////////// EDIT VIEW ////////////////////////////////////////

  //for edit view//////////

  int selectedTab = 0;

  onChangeTab(int v) {
    selectedTab = v;
    notifyListeners();
  }

  //////////////////////////// ACCESSORY VIEW ///////////////////////////////////////

  _getAccessoryCategories() async {
    final res = await databaseService.getAccessoryCategories();

    if (res != null) {
      dataService.accessoryCategories = res;
      notifyListeners();
    }
  }

  bool accessoriesLoading = false;

  setAccessoriesLoading(bool v) {
    accessoriesLoading = v;
    notifyListeners();
  }

  getAllAccessories(int vehicleID) async {
    setAccessoriesLoading(true);
    dataService.accessories =
        await databaseService.getAllAccessoriesOfVehicle(vehicleID) ?? [];
    notifyListeners();
    setAccessoriesLoading(false);
  }

  onEditAccessory(Accessory v) {
    NavService.navigateToAccessoryDetail(
      action: VehicleRegistrationAction.edit,
      accessory: v,
    );
  }

  onInsertAccessory(Vehicle? vehicle) {
    NavService.navigateToAccessoryDetail(
      action: VehicleRegistrationAction.add,
      vehicle: vehicle,
    );
  }

  //////////////////////////// OPERATING COST VIEW ///////////////////////////////////////

  bool operationsCostsLoading = false;

  setOperationsCostsLoading(bool v) {
    operationsCostsLoading = v;
    notifyListeners();
  }

  getAllOperationalCosts(int vehicleID) async {
    setOperationsCostsLoading(true);
    dataService.operatingCosts =
        await databaseService.getAllOperationalCostsOfVehicle(vehicleID) ?? [];
    setOperationsCostsLoading(false);
  }

  onEditOperatingCost(OperatingCost v) {
    NavService.navigateToOperationalCostDetail(
      action: VehicleRegistrationAction.edit,
      operatingCost: v,
    );
  }

  onInsertOperatingCost(Vehicle? vehicle) {
    NavService.navigateToOperationalCostDetail(
      action: VehicleRegistrationAction.add,
      vehicle: vehicle,
    );
  }
}
