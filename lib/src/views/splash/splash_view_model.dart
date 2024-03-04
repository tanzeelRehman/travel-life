import 'package:stacked/stacked.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';

class SplashViewModel extends ReactiveViewModel {
  init() {
    Future.delayed(Duration(seconds: 2), () => NavService.welcome());
  }
}
