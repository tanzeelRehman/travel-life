import 'package:stacked/stacked.dart';
import 'package:starter_app/src/models/accessory_category.dart';
import 'package:starter_app/src/models/cost_category.dart';
import 'package:starter_app/src/models/manufacturor.dart';
import 'package:starter_app/src/models/vehicle_model.dart';

class DataService with ListenableServiceMixin {
  ReactiveValue<List<VehicleModel>> _vehicleModels =
      ReactiveValue<List<VehicleModel>>([]);

  ReactiveValue<List<Manufacturor>> _manufacturors =
      ReactiveValue<List<Manufacturor>>([]);

  ReactiveValue<List<AccessoryCategory>> _accessoryCategories =
      ReactiveValue<List<AccessoryCategory>>([]);

  ReactiveValue<List<CostCategory>> _costCategories =
      ReactiveValue<List<CostCategory>>([]);

  List<VehicleModel> get vehicleModels => _vehicleModels.value;
  List<Manufacturor> get manufacturors => _manufacturors.value;
  List<AccessoryCategory> get accessoryCategories => _accessoryCategories.value;
  List<CostCategory> get costCategories => _costCategories.value;

  set vehicleModels(List<VehicleModel> v) {
    _vehicleModels.value = v;
    notifyListeners();
  }

  set manufacturors(List<Manufacturor> v) {
    _manufacturors.value = v;
    notifyListeners();
  }

  set accessoryCategories(List<AccessoryCategory> v) {
    _accessoryCategories.value = v;
    notifyListeners();
  }

  set costCategories(List<CostCategory> v) {
    _costCategories.value = v;
    notifyListeners();
  }

  @override
  void listenToReactiveValues(List reactiveValues) {
    listenToReactiveValues([]);
    super.listenToReactiveValues(reactiveValues);
  }
}
