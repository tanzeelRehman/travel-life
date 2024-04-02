import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart';
import 'package:starter_app/src/base/enums/vehicle_status.dart';
import 'package:starter_app/src/models/manufacturor.dart';
import 'package:starter_app/src/models/vehicle.dart';
import 'package:starter_app/src/models/vehicle_model.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class VehicleDetailViewModel extends ReactiveViewModel
    with DatabaseViewModel, SupabaseAuthViewModel {
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  //FOR EDITING AND ADDING PURPOSES
  List<Manufacturor>? manufacturers;
  List<VehicleModel>? vehicleModels;

  //FOR EDITING PURPOSES
  Manufacturor? selectedManufacturer;

  onChangeManufacturer(Manufacturor? v) {
    if (v != null) {
      selectedManufacturer = v;
      _getAllVehicleModels();
      notifyListeners();
    }
  }

  VehicleModel? selectedVehicleModel;

  onChangeVehicleModel(VehicleModel? v) {
    if (v != null) {
      selectedVehicleModel = v;
      notifyListeners();
    }
  }

  int? editVehicleID;
  VehicleRegistrationAction? registrationAction;

  String? manufacturer;
  String? model;

  bool isPrimaryVehicle = false;
  bool isInUse = false;

  DateTime? purchaseDate;
  DateTime? lastServiceDate;
  DateTime? manufactureYear;
  DateTime? warrentyExpiryDate;

  VehicleStatus? status;

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

  init(VehicleRegistrationAction action, Vehicle? vehicle) async {
    registrationAction = action;
    if (action == VehicleRegistrationAction.edit && vehicle != null) {
      //TODO: set fields with the data
      _setFieldsForEditing(vehicle);
    }
    await _getAllVehicleManufacturer();
  }

  _setFieldsForEditing(Vehicle vehicle) {
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
    status = vehicle.status == null
        ? null
        : getVehicleStatusFromReadable(vehicle.status!);
    horsePowerController.text = vehicle.horsepower ?? '';
    fuelConsumptionController.text =
        vehicle.consumption == null ? '' : vehicle.consumption.toString();
    warentyPeriodController.text =
        vehicle.warrantyPeriod == null ? '' : vehicle.warrantyPeriod.toString();
    manufactureYear = vehicle.manufactureYear != null
        ? DateTime(vehicle.manufactureYear!)
        : null;
  }

  Vehicle _createVehicle() {
    final v = Vehicle(
      id: editVehicleID,
      consumption: int.tryParse(fuelConsumptionController.text),
      dailyDistance: int.tryParse(dailyDistanceController.text),
      description: descriptionController.text,
      inUse: isInUse,
      lastService: lastServiceDate,
      manufactureYear: manufactureYear?.year,
      manufacturer: selectedManufacturer,
      model: selectedVehicleModel,
      number: registrationNumberController.text,
      odometer: int.tryParse(odometerReadingController.text),
      price: double.tryParse(priceController.text),
      primaryVehicle: isPrimaryVehicle,
      purchaseDate: purchaseDate,
      regNo: registrationNumberController.text,
      serviceInterval: int.tryParse(serviceController.text),
      status: status == null ? null : getReadableVehicleStatus(status!),
      tankCapacity: tankCapacityController.text,
      vinNo: vinController.text,
      warrantyExpiryDate: warrentyExpiryDate,
      warrantyPeriod: int.tryParse(warentyPeriodController.text),
      horsepower: horsePowerController.text,
      user: supabaseAuthService.user?.id,
    );
    return v;
  }

  updateOrInsertVehicle() async {
    if (editVehicleID == null &&
        registrationAction == VehicleRegistrationAction.add) {
      await databaseService.insertVehicle(_createVehicle());
    } else {
      await databaseService.updateVehicle(_createVehicle());
    }
  }

  _getAllVehicleManufacturer() async {
    manufacturers = await databaseService.getAllManufacturers();
    notifyListeners();
  }

  _getAllVehicleModels() async {
    if (selectedManufacturer == null) {
      return;
    }
    vehicleModels =
        await databaseService.getAllVehicleModels(selectedManufacturer!.id!);
    notifyListeners();
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
  }
}
