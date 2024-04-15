import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart';
import 'package:starter_app/src/models/accessory.dart';
import 'package:starter_app/src/models/operating_cost.dart';
import 'package:starter_app/src/models/vehicle.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class VehicleRegistrationViewModel extends ReactiveViewModel
    with SupabaseAuthViewModel, DatabaseViewModel, DataViewModel {
  int selectedTab = 0;

  ValueNotifier<bool> isFabOpen = ValueNotifier(false);

  List<Vehicle> allVehicles = [];
  List<Accessory> allAccessories = [];
  List<OperatingCost> allOperationalCosts = [];

  void init() {
    getAllVehicles();
    getAllAccessories();
    getAllOperationalCosts();
  }

  onChangeTab(int v) {
    selectedTab = v;
    notifyListeners();
  }

  getAppBarTitle() {
    switch (selectedTab) {
      case 0:
        return 'Vehicle Registration';
      case 1:
        return 'Accessory Registration';
      case 2:
        return 'Operational Cost';
      default:
        return '';
    }
  }

  onClickAddActionButton() {
    if (selectedTab == 0) {
      onInsertVehicle();
    }
    if (selectedTab == 1) {
      onInsertAccessory();
    }
    if (selectedTab == 2) {
      onInsertOperatingCost();
    }
  }

  String getBgHeroImage() {
    switch (selectedTab) {
      case 0:
        return AssetImages.vehicleRegistrationCarPNG;
      case 1:
        return AssetImages.vehicleRegistrationBikePNG;
      case 2:
        return AssetImages.vehicleRegistrationFinancePNG;
      default:
        return '';
    }
  }

//////////////////////////// VEHICLE VIEW ///////////////////////////////////////

  bool vehiclesLoading = false;

  setVehiclesLoading(bool v) {
    vehiclesLoading = v;
    notifyListeners();
  }

  getAllVehicles() async {
    setVehiclesLoading(true);
    // allVehicles = await databaseService.getAllVehicles() ?? [];
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

  getVehicleDefaultImageUrl(int manufacturerID) {
    return databaseService.getDefaultVehicleImage(manufacturerID);
  }
//////////////////////////// ACCESSORY VIEW ///////////////////////////////////////

  bool accessoriesLoading = false;

  setAccessoriesLoading(bool v) {
    accessoriesLoading = v;
    notifyListeners();
  }

  getAllAccessories() async {
    setAccessoriesLoading(true);
    // allAccessories = await databaseService.getAllAccessories() ?? [];
    dataService.accessories = await databaseService.getAllAccessories() ?? [];
    allAccessories = dataService.accessories;
    notifyListeners();
    setAccessoriesLoading(false);
  }

  onEditAccessory(Accessory v) {
    NavService.navigateToAccessoryDetail(
      action: VehicleRegistrationAction.edit,
      accessory: v,
    );
  }

  onInsertAccessory() {
    NavService.navigateToAccessoryDetail(
      action: VehicleRegistrationAction.add,
    );
  }

  Vehicle? selectedVehicleForFilterInAccessories;

  onChangeSelectedVehicleForFilterInAccessories(Vehicle? v) {
    selectedVehicleForFilterInAccessories = v;
    filterAccessories();
    notifyListeners();
  }

  void filterAccessories() {
    if (selectedVehicleForFilterInAccessories != null) {
      allAccessories = dataService.accessories
          .where(
            (element) =>
                element.vehicle?.id ==
                selectedVehicleForFilterInAccessories?.id,
          )
          .toList();
      notifyListeners();
    } else {
      allAccessories = dataService.accessories;
      notifyListeners();
    }
  }

  Vehicle? selectedVehicleForFilterInOperatingCosts;

  onChangeSelectedVehicleForFilterInOperatingCosts(Vehicle? v) {
    selectedVehicleForFilterInOperatingCosts = v;
    filterOperatingCosts();
    notifyListeners();
  }

  void filterOperatingCosts() {
    if (selectedVehicleForFilterInOperatingCosts != null) {
      allOperationalCosts = dataService.operatingCosts
          .where(
            (element) =>
                element.vehicle?.id ==
                selectedVehicleForFilterInOperatingCosts?.id,
          )
          .toList();
      notifyListeners();
    } else {
      allOperationalCosts = dataService.operatingCosts;
      notifyListeners();
    }
  }
//////////////////////////// OPERATING COST VIEW ///////////////////////////////////////

  bool operationsCostsLoading = false;

  setOperationsCostsLoading(bool v) {
    operationsCostsLoading = v;
    notifyListeners();
  }

  getAllOperationalCosts() async {
    setOperationsCostsLoading(true);
    // allOperationalCosts = await databaseService.getAllOperationalCosts() ?? [];
    dataService.operatingCosts =
        await databaseService.getAllOperationalCosts() ?? [];
    allOperationalCosts = dataService.operatingCosts;
    setOperationsCostsLoading(false);
  }

  onEditOperatingCost(OperatingCost v) {
    NavService.navigateToOperationalCostDetail(
      action: VehicleRegistrationAction.edit,
      operatingCost: v,
    );
  }

  onInsertOperatingCost() {
    NavService.navigateToOperationalCostDetail(
      action: VehicleRegistrationAction.add,
    );
  }

  // getAllManufacturers() async {
  //   print('hello im called');
  //   final res = await databaseService.getAllManufacturers();
  //   print('res: $res');
  // }

  // getAllVehicleModels() async {
  //   print('hello im called');
  //   final res = await databaseService.getAllVehicleModels(1);
  //   print('res: $res');
  // }

////////////////////////////////////////////////////////////////////////////////
}
