import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/models/vehicle.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';

class VehicleBottomSheetViewModel extends ReactiveViewModel with DataViewModel {
  List<Vehicle> allVehicleModels = [];

  List<Vehicle> vehicleModels = [];

  void init() {
    allVehicleModels = dataService.vehicles;
    vehicleModels = allVehicleModels;
    notifyListeners();
  }

  final TextEditingController searchController = TextEditingController();

  onSearch(String? query) {
    if (query == null || query.isEmpty) {
      vehicleModels = allVehicleModels;
    } else {
      vehicleModels = allVehicleModels
          .where(
            (manufacturer) => manufacturer.model!.model!.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
    }

    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
