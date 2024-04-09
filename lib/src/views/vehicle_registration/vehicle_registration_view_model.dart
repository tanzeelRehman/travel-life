import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart';
import 'package:starter_app/src/models/accessory.dart';
import 'package:starter_app/src/models/operating_cost.dart';
import 'package:starter_app/src/models/vehicle.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class VehicleRegistrationViewModel extends ReactiveViewModel
    with SupabaseAuthViewModel, DatabaseViewModel {
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
    allVehicles = await databaseService.getAllVehicles() ?? [];
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

//////////////////////////// ACCESSORY VIEW ///////////////////////////////////////

  bool accessoriesLoading = false;

  setAccessoriesLoading(bool v) {
    accessoriesLoading = v;
    notifyListeners();
  }

  getAllAccessories() async {
    setAccessoriesLoading(true);
    allAccessories = await databaseService.getAllAccessories() ?? [];
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

  int selectedAccessoryCategory = 0;
  List<String> accessoryCategories = [
    'BMW Cabiro',
    'Harley Davidson',
    'Kawasaki',
    'Royal Enfeild',
    'Yamaha R15',
  ];

  onChangeSelectedAccessoryCategory(int v) {
    selectedAccessoryCategory = v;
    notifyListeners();
  }

//////////////////////////// OPERATING COST VIEW ///////////////////////////////////////

  bool operationsCostsLoading = false;

  setOperationsCostsLoading(bool v) {
    operationsCostsLoading = v;
    notifyListeners();
  }

  getAllOperationalCosts() async {
    setOperationsCostsLoading(true);
    allOperationalCosts = await databaseService.getAllOperationalCosts() ?? [];
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
