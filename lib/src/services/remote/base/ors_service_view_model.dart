import 'package:stacked/stacked.dart';
import 'package:starter_app/src/configs/app_setup.locator.dart';
import 'package:starter_app/src/services/remote/ors/ors_service.dart';

mixin OrsServiceViewModel on ReactiveViewModel {
  OrsService _orsService = locator<OrsService>();

  OrsService get orsService => _orsService;
}
