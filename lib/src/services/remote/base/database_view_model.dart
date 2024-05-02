import 'package:stacked/stacked.dart';
import 'package:starter_app/src/configs/app_setup.locator.dart';
import 'package:starter_app/src/services/remote/database_service.dart';

mixin DatabaseViewModel on ReactiveViewModel {
  DatabaseService _databaseService = locator<DatabaseService>();

  DatabaseService get databaseService => _databaseService;

  @override
  List<ListenableServiceMixin> get listenableServices =>
      super.listenableServices + [_databaseService];
}
