import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class VehicleRegistrationViewModel extends ReactiveViewModel
    with SupabaseAuthViewModel {
  int selectedTab = 0;

  void init() {}

  onChangeTab(int v) {
    selectedTab = v;
    notifyListeners();
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
}
