import 'dart:io';

import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/base/utils/supabase_buckets.dart';
import 'package:starter_app/src/base/utils/supabase_tables.dart';
import 'package:starter_app/src/base/utils/utils.dart';
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
import 'package:uuid/uuid.dart';

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
          .select(vehicleQuery)
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
          .update(vehicle.toMap())
          .eq('id', vehicle.id!)
          .select(vehicleQuery)
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
          .select(vehicleQuery)
          .single();

      print(res);

      return Vehicle.fromMap(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //UPDATE/INSERT VEHICLE IMAGE
  Future<Vehicle?> uploadVehicleImage(int vehicleID, File image) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final imageName = '${_authService.user?.id}/$vehicleID';

      final publicUrl = _supabase.storage
          .from(SupabaseBuckets.vehicleRegistrationImagesBucket)
          .getPublicUrl(imageName);

      final bool doesExists = await UtilFunctions.isResourceFound(publicUrl);

      if (doesExists) {
        final res = await _supabase.storage
            .from(SupabaseBuckets.vehicleRegistrationImagesBucket)
            .update(imageName, image);
        print('update res: $res');
      } else {
        final res = await _supabase.storage
            .from(SupabaseBuckets.vehicleRegistrationImagesBucket)
            .upload(imageName, image);
        print('upload res: $res');
      }

      final updatedUser = await _supabase
          .from(SupabaseTables.vehicles)
          .update({'photoURL': publicUrl})
          .eq('id', vehicleID)
          .select(vehicleQuery)
          .single();

      return Vehicle.fromMap(updatedUser);
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
          .select(accessoryQuery)
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
          .update(accessory.toMap())
          .eq('id', accessory.id!)
          .select(accessoryQuery)
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
          .select(accessoryQuery)
          .single();

      print(res);

      return Accessory.fromMap(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //ADD ACCESSORY IMAGE
  Future<Accessory?> insertOrUpdateAccessoryImage(
      int accessoryID, File image) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final imageName = '${_authService.user?.id}/$accessoryID';

      final publicUrl = await _supabase.storage
          .from(SupabaseBuckets.accessoryImagesBucket)
          .getPublicUrl(imageName);

      final bool doesExists = await UtilFunctions.isResourceFound(publicUrl);

      if (doesExists) {
        final res = await _supabase.storage
            .from(SupabaseBuckets.accessoryImagesBucket)
            .update(imageName, image);
        print('update res: $res');
      } else {
        final res = await _supabase.storage
            .from(SupabaseBuckets.accessoryImagesBucket)
            .upload(imageName, image);
        print('upload res: $res');
      }

      final updatedUser = await _supabase
          .from(SupabaseTables.accessories)
          .update({'accessoryimage_attachment': publicUrl})
          .eq('id', accessoryID)
          .select(accessoryQuery)
          .single();

      return Accessory.fromMap(updatedUser);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //ADD ACCESSORY Attachment
  Future<Accessory?> insertOrUpdateAccessoryAttachment(
      int accessoryID, File image) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final imageName = '${_authService.user?.id}/$accessoryID';

      final publicUrl = _supabase.storage
          .from(SupabaseBuckets.accessoryAttachmentsBucket)
          .getPublicUrl(imageName);

      final bool doesExists = await UtilFunctions.isResourceFound(publicUrl);

      if (doesExists) {
        final res = await _supabase.storage
            .from(SupabaseBuckets.accessoryAttachmentsBucket)
            .update(imageName, image);
        print('update res: $res');
      } else {
        final res = await _supabase.storage
            .from(SupabaseBuckets.accessoryAttachmentsBucket)
            .upload(imageName, image);
        print('upload res: $res');
      }

      final updatedUser = await _supabase
          .from(SupabaseTables.accessories)
          .update({'invoice_attachment': publicUrl})
          .eq('id', accessoryID)
          .select(accessoryQuery)
          .single();

      return Accessory.fromMap(updatedUser);
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
          .from(SupabaseTables.operatingCosts)
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
          .select(operationalCostQuery)
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
          .update(operatingCost.toMap())
          .eq('id', operatingCost.id!)
          .select(operationalCostQuery)
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
          .eq('id', operationalCostQuery)
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

  //ADD OPERATING COST ATTACHMENT
  Future<OperatingCost?> insertOrUpdateOperatingCostAttachment(
      int operatingCostID, File image) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final imageName = '${_authService.user?.id}/$operatingCostID';

      final publicUrl = _supabase.storage
          .from(SupabaseBuckets.operationalCostAttachmentsBucket)
          .getPublicUrl(imageName);

      final bool doesExists = await UtilFunctions.isResourceFound(publicUrl);

      if (doesExists) {
        final res = await _supabase.storage
            .from(SupabaseBuckets.operationalCostAttachmentsBucket)
            .update(imageName, image);
        print('update res: $res');
      } else {
        final res = await _supabase.storage
            .from(SupabaseBuckets.operationalCostAttachmentsBucket)
            .upload(imageName, image);
        print('upload res: $res');
      }

      final updatedUser = await _supabase
          .from(SupabaseTables.operatingCosts)
          .update({'attachment': publicUrl})
          .eq('id', operatingCostID)
          .select(operationalCostQuery)
          .single();

      return OperatingCost.fromMap(updatedUser);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //ADD OPERATING COST ATTACHMENTS (Insert)
  Future<OperatingCost?> addOperatingCostAttachments(
    int operatingCostID,
    List<File> attachments,
  ) async {
    try {
      print('total attachments: ${attachments.length}');

      if (!_isConnected()) {
        return null;
      }

      List uploadedAttachmentPaths = [];

      for (File attachment in attachments) {
        final String randomIdentifier = Uuid().v4();

        final attachmentName =
            '${_authService.user?.id}/$operatingCostID/$randomIdentifier';

        final res = await _supabase.storage
            .from(SupabaseBuckets.operationalCostAttachmentsBucket)
            .upload(attachmentName, attachment);
        print('upload res: $res');

        uploadedAttachmentPaths.add(attachmentName);
      }

      final pehleVaaliAttachments =
          await getOperationalCostAttachments(operatingCostID);

      print('pehleVaaliAttachments: ${pehleVaaliAttachments}');

      final updatedUser = await _supabase
          .from(SupabaseTables.operatingCosts)
          .update({
            'attachments': [
              ...pehleVaaliAttachments,
              ...uploadedAttachmentPaths
            ]
          })
          .eq('id', operatingCostID)
          .select(operationalCostQuery)
          .single();

      return OperatingCost.fromMap(updatedUser);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //ADD OPERATING COST ATTACHMENT (Insert)
  Future<OperatingCost?> removeOperatingCostAttachment(
    int operatingCostID,
    String attachmentPath,
  ) async {
    try {
      print('attachment: $attachmentPath');

      if (!_isConnected()) {
        return null;
      }

      List updatedAttachmentPaths = [];

      final res = await _supabase.storage
          .from(SupabaseBuckets.operationalCostAttachmentsBucket)
          .remove([attachmentPath]);

      print('deleted attachement: ${res.first}');

      final pehleVaaliAttachments =
          await getOperationalCostAttachments(operatingCostID);

      updatedAttachmentPaths = pehleVaaliAttachments
          .where((element) => element != attachmentPath)
          .toList();

      final updatedUser = await _supabase
          .from(SupabaseTables.operatingCosts)
          .update({'attachments': updatedAttachmentPaths})
          .eq('id', operatingCostID)
          .select(operationalCostQuery)
          .single();

      return OperatingCost.fromMap(updatedUser);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  Future<List<dynamic>> getOperationalCostAttachments(
      int operatingCostID) async {
    try {
      final res = await _supabase
          .from(SupabaseTables.operatingCosts)
          .select('*')
          .eq('id', operatingCostID)
          .single();

      print('attachments in getOperationalCostAttachments : ${res}');

      if (res['attachments'] == null) {
        return [];
      }
      // else{

      // }

      return res['attachments'];
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return [];
    }
  }

  String getOperatingCostAttachmentUrl(String attachmentPath) {
    return _supabase.storage
        .from(SupabaseBuckets.operationalCostAttachmentsBucket)
        .getPublicUrl(attachmentPath);
  }

  bool _isConnected() {
    if (!_connectivityService.isInternetConnected) {
      Constants.customWarningSnack('No Internet Connection Found');
    }
    return _connectivityService.isInternetConnected;
  }

  String getDefaultVehicleImage(int manufacturerID) {
    return _supabase.storage
        .from(SupabaseBuckets.avatarsBucket)
        .getPublicUrl('BikeLogos/Logo$manufacturerID.png');
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
