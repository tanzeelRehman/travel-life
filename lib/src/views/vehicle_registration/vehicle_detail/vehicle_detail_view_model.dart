import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/vehicle_status.dart';

class VehicleDetailViewModel extends ReactiveViewModel {
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

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

  init() {}

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
