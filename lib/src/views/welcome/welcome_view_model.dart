import 'package:stacked/stacked.dart';
import 'package:starter_app/src/services/local/base/auth_view_model.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/api_view_model.dart';

class WelcomeViewModel extends ReactiveViewModel
    with ApiViewModel, AuthViewModel {
  init() {}

  onClickRegister() {
    NavService.navigateToRegister();
  }

  onClickLogin() {
    NavService.navigateToLogin();
  }
}
