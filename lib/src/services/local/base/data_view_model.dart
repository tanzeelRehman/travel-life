import 'package:stacked/stacked.dart';
import 'package:starter_app/src/configs/app_setup.locator.dart';

import '../data_service.dart';

mixin DataViewModel on ReactiveViewModel {
  DataService _dataService = locator<DataService>();
  DataService get dataService => _dataService;

  @override
  List<ListenableServiceMixin> get listenableServices =>
      super.listenableServices + [_dataService];
}
