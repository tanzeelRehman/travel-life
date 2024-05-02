import 'package:stacked/stacked.dart';
import 'package:starter_app/src/models/accessory.dart';
import 'package:starter_app/src/models/accessory_category.dart';
import 'package:starter_app/src/models/cost_category.dart';
import 'package:starter_app/src/models/manufacturor.dart';
import 'package:starter_app/src/models/operating_cost.dart';
import 'package:starter_app/src/models/vehicle.dart';
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

  //FOR Vehicles, Accessories and Operating costs
  ReactiveValue<List<Vehicle>> _vehicles = ReactiveValue<List<Vehicle>>([]);

  ReactiveValue<List<Accessory>> _accessories =
      ReactiveValue<List<Accessory>>([]);

  ReactiveValue<List<OperatingCost>> _operatingCosts =
      ReactiveValue<List<OperatingCost>>([]);

  //FOR Vehicles, Accessories and Operating costs
  List<Vehicle> get vehicles => _vehicles.value;

  List<Accessory> get accessories => _accessories.value;

  List<OperatingCost> get operatingCosts => _operatingCosts.value;

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

  set vehicles(List<Vehicle> v) {
    _vehicles.value = v;
    notifyListeners();
  }

  set accessories(List<Accessory> v) {
    _accessories.value = v;
    notifyListeners();
  }

  set operatingCosts(List<OperatingCost> v) {
    _operatingCosts.value = v;
    notifyListeners();
  }

  @override
  void listenToReactiveValues(List reactiveValues) {
    listenToReactiveValues([]);
    super.listenToReactiveValues(reactiveValues);
  }
}
