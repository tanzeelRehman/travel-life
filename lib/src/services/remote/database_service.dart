import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/base/utils/supabase_tables.dart';
import 'package:starter_app/src/configs/app_setup.locator.dart';
import 'package:starter_app/src/models/accessory.dart';
import 'package:starter_app/src/models/accessory_category.dart';
import 'package:starter_app/src/models/cost_category.dart';
import 'package:starter_app/src/models/manufacturor.dart';
import 'package:starter_app/src/models/operating_cost.dart';
import 'package:starter_app/src/models/vehicle.dart';
import 'package:starter_app/src/models/vehicle_model.dart';
import 'package:starter_app/src/services/local/connectivity_service.dart';
import 'package:starter_app/src/services/remote/supabase_auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService with ListenableServiceMixin {
  static final SupabaseAuthService _authService =
      locator<SupabaseAuthService>();

  static final ConnectivityService _connectivityService =
      locator<ConnectivityService>();

  static final _supabase = Supabase.instance.client;

  DatabaseService() {
    print('initialzed database service with user ${_authService.user?.id}');
  }

  //GET ALL MANUFACTURERS
  Future<List<Manufacturor>?> getAllManufacturers() async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res =
          await _supabase.from(SupabaseTables.vehicleManufacturers).select('*');

      return Manufacturor.fromJsonList(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //GET ALL MODELS
  Future<List<VehicleModel>?> getAllVehicleModels(int manufacturerID) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.vehicleModels)
          .select(vehicleModelsQuery)
          .eq('manufacturer', manufacturerID);

      return VehicleModel.fromJsonList(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

//////////////////////////////////////////////// VEHICLES ////////////////////////////////////////////////

  //GET ALL VEHICLES
  Future<List<Vehicle>?> getAllVehicles() async {
    try {
      if (!_isConnected()) {
        return null;
      }
      print('---------- check user id: ${_authService.user?.id}');

      final res = await _supabase
          .from(SupabaseTables.vehicles)
          .select(
            vehicleQuery,
          )
          .eq('user', '${_authService.user?.id}');

      print(res);

      return Vehicle.fromJsonList(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //INSERT VEHICLE
  Future<Vehicle?> insertVehicle(Vehicle vehicle) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.vehicles)
          .insert(vehicle.insertToMap())
          .select()
          .single();

      print(res);

      return Vehicle.fromMap(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //UPDATE VEHICLE
  Future<Vehicle?> updateVehicle(Vehicle vehicle) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.vehicles)
          .update(vehicle.insertToMap())
          .eq('id', vehicle.id!)
          .select()
          .single();

      print(res);

      return Vehicle.fromMap(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //DELETE VEHICLE
  Future<Vehicle?> deleteVehicle(int vehicleID) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.vehicles)
          .delete()
          .eq('id', vehicleID)
          .select()
          .single();

      print(res);

      return Vehicle.fromMap(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

//////////////////////////////////////////////// ACCESSORIES //////////////////////////////////////////

  //GET ALL ACCESSORY CATEGORIES
  Future<List<AccessoryCategory>?> getAccessoryCategories() async {
    try {
      if (!_isConnected()) {
        return null;
      }
      print('---------- check user id: ${_authService.user?.id}');

      final res =
          await _supabase.from(SupabaseTables.accessoryCategories).select();

      print(res);

      return AccessoryCategory.fromJsonList(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //GET ALL ACCESSORIES
  Future<List<Accessory>?> getAllAccessories() async {
    try {
      if (!_isConnected()) {
        return null;
      }
      print('---------- check user id: ${_authService.user?.id}');

      final res = await _supabase
          .from(SupabaseTables.accessories)
          .select(
            accessoryQuery,
          )
          .eq('user', '${_authService.user?.id}');

      print(res);

      return Accessory.fromJsonList(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //INSERT ACCESSORY
  Future<Accessory?> insertAccessory(Accessory accessory) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.accessories)
          .insert(accessory.insertToMap())
          .select()
          .single();

      print(res);

      return Accessory.fromMap(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //UPDATE ACCESSORY
  Future<Accessory?> updateAccessory(Accessory accessory) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.accessories)
          .update(accessory.insertToMap())
          .eq('id', accessory.id!)
          .select()
          .single();

      print(res);

      return Accessory.fromMap(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //DELETE ACCESSORY
  Future<Accessory?> deleteAccessory(int accessoryID) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.accessories)
          .delete()
          .eq('id', accessoryID)
          .select()
          .single();

      print(res);

      return Accessory.fromMap(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

//////////////////////////////////////////////// OPERATING COST //////////////////////////////////////////

  //GET ALL OPERATING COSTS CATEGORIES
  Future<List<CostCategory>?> getOperatingCostCategories() async {
    try {
      if (!_isConnected()) {
        return null;
      }
      print('---------- check user id: ${_authService.user?.id}');

      final res =
          await _supabase.from(SupabaseTables.operatingCostCategories).select();

      print(res);

      return CostCategory.fromJsonList(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //GET ALL OPERATING COSTS
  Future<List<OperatingCost>?> getAllOperationalCosts() async {
    try {
      if (!_isConnected()) {
        return null;
      }
      print('---------- check user id: ${_authService.user?.id}');

      final res = await _supabase
          .from(SupabaseTables.accessories)
          .select(
            operationalCostQuery,
          )
          .eq('user', '${_authService.user?.id}');

      print(res);

      return OperatingCost.fromJsonList(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //INSERT OPERATING COST
  Future<OperatingCost?> insertOperatingCost(
      OperatingCost operatingCost) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.operatingCosts)
          .insert(operatingCost.insertToMap())
          .select()
          .single();

      print(res);

      return OperatingCost.fromMap(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //UPDATE OPERATING COST
  Future<OperatingCost?> updateOperatingCost(
      OperatingCost operatingCost) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.operatingCosts)
          .update(operatingCost.insertToMap())
          .eq('id', operatingCost.id!)
          .select()
          .single();

      print(res);

      return OperatingCost.fromMap(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //DELETE OPERATING COST
  Future<OperatingCost?> deleteOperatingCost(int operatingCostID) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.operatingCosts)
          .delete()
          .eq('id', operatingCostID)
          .select()
          .single();

      print(res);

      return OperatingCost.fromMap(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  bool _isConnected() {
    if (!_connectivityService.isInternetConnected) {
      Constants.customWarningSnack('No Internet Connection Found');
    }
    return _connectivityService.isInternetConnected;
  }
}

//TODO: find a better way to do it.

//refrence manufacturor table and refrence model tables (then manufacturer table)
const String vehicleQuery = '''
        *,
        manufacturer(*),
        model('''
    '*, manufacturer(*)'
    ''')''';

const String accessoryQuery = '''
        *,
        category(*),
        vehicle($vehicleQuery)''';

const String operationalCostQuery = '''
        *,
        category(*),
        vehicle($vehicleQuery)''';

const String vehicleModelsQuery = '''
        *,
        manufacturer(*)
        ''';
