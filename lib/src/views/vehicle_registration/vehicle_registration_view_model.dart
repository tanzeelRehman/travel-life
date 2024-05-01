import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart';
import 'package:starter_app/src/models/vehicle.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class VehicleRegistrationViewModel extends ReactiveViewModel
    with SupabaseAuthViewModel, DatabaseViewModel, DataViewModel {
  ValueNotifier<bool> isFabOpen = ValueNotifier(false);

  void init() {
    getAllVehicles();
  }

  bool vehiclesLoading = false;

  setVehiclesLoading(bool v) {
    vehiclesLoading = v;
    notifyListeners();
  }

  getAllVehicles() async {
    setVehiclesLoading(true);
    dataService.vehicles = await databaseService.getAllVehicles() ?? [];
    setVehiclesLoading(false);
    notifyListeners();
  }

  onEditVehicle(Vehicle v) {
    NavService.navigateToVehicleDetail(
        action: VehicleRegistrationAction.edit, vehicle: v);
  }

  onInsertVehicle() {
    NavService.navigateToVehicleDetail(action: VehicleRegistrationAction.add);
  }

  onDisableVehicle(int vehicleID, bool isEnabled) async {
    final shouldLoad =
        await databaseService.disableVehicle(vehicleID, isEnabled);

    if (shouldLoad) {
      getAllVehicles();
    }
  }

  getVehicleDefaultImageUrl(int manufacturerID) {
    return databaseService.getDefaultVehicleImage(manufacturerID);
  }
}
