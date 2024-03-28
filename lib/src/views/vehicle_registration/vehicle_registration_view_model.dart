import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class VehicleRegistrationViewModel extends ReactiveViewModel
    with SupabaseAuthViewModel {
  int selectedTab = 0;

  ValueNotifier<bool> isFabOpen = ValueNotifier(false);

  bool customDialRoot = true;
  bool extend = false;
  bool rmIcons = false;

  void init() {}

  onChangeTab(int v) {
    selectedTab = v;
    notifyListeners();
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
