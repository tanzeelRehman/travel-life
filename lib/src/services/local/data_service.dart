import 'package:stacked/stacked.dart';
import 'package:starter_app/src/models/accessory.dart';
import 'package:starter_app/src/models/accessory_category.dart';
import 'package:starter_app/src/models/cost_category.dart';
import 'package:starter_app/src/models/event.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/models/invited_group.dart';
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

  //////////////////////////////////////////FOR GROUPS//////////////////////////////////////////////////////

  ReactiveValue<List<Group>> _forYouGroups = ReactiveValue<List<Group>>([]);
  List<Group> get forYouGroups => _forYouGroups.value;
  set forYouGroups(List<Group> v) {
    _forYouGroups.value = v;
    notifyListeners();
  }

  ReactiveValue<List<Group>> _publicGroups = ReactiveValue<List<Group>>([]);
  List<Group> get publicGroups => _publicGroups.value;
  set publicGroups(List<Group> v) {
    _publicGroups.value = v;
    notifyListeners();
  }

  ReactiveValue<List<Group>> _privateGroups = ReactiveValue<List<Group>>([]);
  List<Group> get privateGroups => _privateGroups.value;
  set privateGroups(List<Group> v) {
    _privateGroups.value = v;
    notifyListeners();
  }

  ReactiveValue<List<InvitedGroup>> _invites =
      ReactiveValue<List<InvitedGroup>>([]);
  List<InvitedGroup> get invites => _invites.value;
  set invites(List<InvitedGroup> v) {
    _invites.value = v;
    notifyListeners();
  }

  ReactiveValue<List<Group>> _myGroups = ReactiveValue<List<Group>>([]);
  List<Group> get myGroups => _myGroups.value;
  set myGroups(List<Group> v) {
    _myGroups.value = v;
    notifyListeners();
  }

  ReactiveValue<List<Group>> _joinedGroups = ReactiveValue<List<Group>>([]);
  List<Group> get joinedGroups => _joinedGroups.value;
  set joinedGroups(List<Group> v) {
    _joinedGroups.value = v;
    notifyListeners();
  }

  ReactiveValue<List<Event>> _allEvents = ReactiveValue<List<Event>>([]);
  List<Event> get allEvents => _allEvents.value;
  set allEvents(List<Event> v) {
    _allEvents.value = v;
    notifyListeners();
  }

  @override
  void listenToReactiveValues(List reactiveValues) {
    listenToReactiveValues([]);
    super.listenToReactiveValues(reactiveValues);
  }
}
