import 'package:stacked/stacked.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class HomeViewModel extends ReactiveViewModel with SupabaseAuthViewModel {
  init() {}

  onClickProfile() {
    NavService.navigateToProfile();
  }

  onClickTripPlanner() {}
  onClickVehicleRegistration() {}
  onClickGroups() {}
  onClickMoneyManager() {}
  onClickChats() {}
  onClickEventMoneyManager() {}
}
