import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/models/vehicle_model.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';

class VehicleModelBottomSheetViewModel extends ReactiveViewModel
    with DataViewModel {
  List<VehicleModel> allVehicleModels = [];

  List<VehicleModel> vehicleModels = [];

  void init() {
    allVehicleModels = dataService.vehicleModels;
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
            (manufacturer) => manufacturer.model!.toLowerCase().contains(
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
