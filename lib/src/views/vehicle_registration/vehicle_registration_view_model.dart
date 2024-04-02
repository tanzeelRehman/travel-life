import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class VehicleRegistrationViewModel extends ReactiveViewModel
    with SupabaseAuthViewModel, DatabaseViewModel {
  int selectedTab = 0;

  ValueNotifier<bool> isFabOpen = ValueNotifier(false);

  bool customDialRoot = true;
  bool extend = false;
  bool rmIcons = false;

  void init() {
    // getAllVehicles();
    // getAllAccessories();
    // getAllOperationalCosts();
    // getAllManufacturers();
    getAllVehicleModels();
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
      NavService.navigateToVehicleDetail(action: VehicleRegistrationAction.add);
    }
    if (selectedTab == 1) {
      NavService.navigateToAccessoryDetail(
          action: VehicleRegistrationAction.add);
    }
    if (selectedTab == 2) {
      NavService.navigateToOperationalCostDetail(
          action: VehicleRegistrationAction.add);
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

  getAllVehicles() async {
    print('hello im called');
    final res = await databaseService.getAllVehicles();
    print('res: $res');
  }

  getAllAccessories() async {
    print('hello im called');
    final res = await databaseService.getAllAccessories();
    print('res: $res');
  }

  getAllOperationalCosts() async {
    print('hello im called');
    final res = await databaseService.getAllOperationalCosts();
    print('res: $res');
  }

  getAllManufacturers() async {
    print('hello im called');
    final res = await databaseService.getAllManufacturers();
    print('res: $res');
  }

  getAllVehicleModels() async {
    print('hello im called');
    final res = await databaseService.getAllVehicleModels(1);
    print('res: $res');
  }

////////////////////////////////////////////////////////////////////////////////
  ////////////For accessories view
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
}
