import 'package:stacked/stacked.dart';
import 'package:starter_app/src/configs/app_setup.locator.dart';
import 'package:starter_app/src/services/local/connectivity_service.dart';

mixin ConnectivityViewModel on ReactiveViewModel {
  ConnectivityService _connectivityService = locator<ConnectivityService>();
  ConnectivityService get connectivityService => _connectivityService;

  @override
  List<ListenableServiceMixin> get listenableServices => [_connectivityService];
}
