import 'dart:io';

import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/base/utils/supabase_buckets.dart';
import 'package:starter_app/src/base/utils/supabase_tables.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/configs/app_setup.locator.dart';
import 'package:starter_app/src/models/accessory.dart';
import 'package:starter_app/src/models/accessory_category.dart';
import 'package:starter_app/src/models/app_user.dart';
import 'package:starter_app/src/models/cost_category.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/models/group_member.dart';
import 'package:starter_app/src/models/invited_group.dart';
// import 'package:starter_app/src/models/join_request_user.dart';
import 'package:starter_app/src/models/manufacturor.dart';
import 'package:starter_app/src/models/operating_cost.dart';
import 'package:starter_app/src/models/see_all_members_user.dart';
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

  //DISABLE VEHICLE
  Future<bool> disableVehicle(int vehicleId, bool isEnabled) async {
    try {
      if (!_isConnected()) {
        return false;
      }

      final res = await _supabase
          .from(SupabaseTables.vehicles)
          .update({'is_enabled': isEnabled})
          .eq('id', vehicleId)
          .select(vehicleQuery)
          .single();

      print(res);

      // return Vehicle.fromMap(res);
      return true;
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return false;
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

  String getDefaultVehicleImage(int manufacturerID) {
    return _supabase.storage
        .from(SupabaseBuckets.avatarsBucket)
        .getPublicUrl('BikeLogos/Logo$manufacturerID.png');
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

  //GET ALL ACCESSORIES OF A VEHICLE
  Future<List<Accessory>?> getAllAccessoriesOfVehicle(int vehicleID) async {
    try {
      if (!_isConnected()) {
        return null;
      }
      print('---------- check vehicle id: $vehicleID');

      final res = await _supabase
          .from(SupabaseTables.accessories)
          .select(
            accessoryQuery,
          )
          .eq('vehicle', vehicleID);

      print(res);

      return Accessory.fromJsonList(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //GET ALL ACCESSORIES OF USER
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

  //ADD OPERATING COST ATTACHMENTS (Insert)
  Future<Accessory?> addAccessoryAttachments(
    int accessoryID,
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
            '${_authService.user?.id}/$accessoryID/$randomIdentifier';

        final res = await _supabase.storage
            .from(SupabaseBuckets.accessoryAttachmentsBucket)
            .upload(attachmentName, attachment);
        print('upload res: $res');

        uploadedAttachmentPaths.add(attachmentName);
      }

      final pehleVaaliAttachments = await getAccessoryAttachments(accessoryID);

      print('pehleVaaliAttachments: ${pehleVaaliAttachments}');

      final updatedUser = await _supabase
          .from(SupabaseTables.accessories)
          .update({
            'attachments': [
              ...pehleVaaliAttachments,
              ...uploadedAttachmentPaths
            ]
          })
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

  //REMOVE OPERATING COST ATTACHMENT (DELETE)
  Future<bool?> removeAccessoryAttachment(
    int accessoryID,
    String attachmentPath,
  ) async {
    try {
      print('attachment: $attachmentPath');

      if (!_isConnected()) {
        return null;
      }

      List updatedAttachmentPaths = [];

      final res = await _supabase.storage
          .from(SupabaseBuckets.accessoryAttachmentsBucket)
          .remove([attachmentPath]);

      print('deleted attachement: ${res.first}');

      final pehleVaaliAttachments = await getAccessoryAttachments(accessoryID);

      updatedAttachmentPaths = pehleVaaliAttachments
          .where((element) => element != attachmentPath)
          .toList();

      final updatedUser = await _supabase
          .from(SupabaseTables.accessories)
          .update({'attachments': updatedAttachmentPaths})
          .eq('id', accessoryID)
          .select(accessoryQuery)
          .single();

      final updatedAccessory = Accessory.fromMap(updatedUser);

      return updatedAccessory.id != null;
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  Future<List<dynamic>> getAccessoryAttachments(int accessoryID) async {
    try {
      final res = await _supabase
          .from(SupabaseTables.accessories)
          .select('attachments')
          .eq('id', accessoryID)
          .single();

      print('attachments in getAccessoryAttachments : ${res}');

      if (res['attachments'] == null) {
        return [];
      }
      return res['attachments'];
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return [];
    }
  }

  String getAccessoryAttachmentUrl(String attachmentPath) {
    return _supabase.storage
        .from(SupabaseBuckets.accessoryAttachmentsBucket)
        .getPublicUrl(attachmentPath);
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

  //GET ALL OPERATING COSTS OF A VEHICLE
  Future<List<OperatingCost>?> getAllOperationalCostsOfVehicle(
      int vehicleID) async {
    try {
      if (!_isConnected()) {
        return null;
      }
      print('---------- check vehicle id: $vehicleID');

      final res = await _supabase
          .from(SupabaseTables.operatingCosts)
          .select(operationalCostQuery)
          .eq('vehicle', vehicleID);

      print(res);

      return OperatingCost.fromJsonList(res);
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

  //REMOVE OPERATING COST ATTACHMENT (DELETE)
  Future<bool?> removeOperatingCostAttachment(
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

      final updatedOperatingCost = OperatingCost.fromMap(updatedUser);

      return updatedOperatingCost.id != null;
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
          .select('attachments')
          .eq('id', operatingCostID)
          .single();

      print('attachments in getOperationalCostAttachments : ${res}');

      if (res['attachments'] == null) {
        return [];
      }
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

  //////////////////////////////////// GROUP OPERATIONS /////////////////////////////

  //TODO: view all suggested i.e for you groups (with some restrictions i.e for you groups etc)
  Future<List<Group>?> getForYouGroups() async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res =
          await _supabase.from(SupabaseTables.groups).select(groupsQuery);

      //filter out my joined groups
      final joinedGroups = await _supabase
          .from(SupabaseTables.groupMemebers)
          .select('*')
          // .eq('joined', true)
          .or('requested_to_join.eq.true, joined.eq.true')
          .eq('user', '${_authService.user?.id}');

      final joinedGroupIds =
          joinedGroups.map((group) => group['group']).toList();

      final filteredGroups =
          res.where((group) => !joinedGroupIds.contains(group['id'])).toList();

      return Group.fromJsonList(filteredGroups);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //TODO: view all public groups (decide on what basis these groups are going to be shown)
  Future<List<Group>?> getPublicGroups() async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.groups)
          .select(groupsQuery)
          .eq('is_public', true);

      //filter out my joined groups
      final joinedGroups = await _supabase
          .from(SupabaseTables.groupMemebers)
          .select('*')
          .eq('joined', true)
          .eq('user', '${_authService.user?.id}');

      final joinedGroupIds =
          joinedGroups.map((group) => group['group']).toList();

      final filteredGroups =
          res.where((group) => !joinedGroupIds.contains(group['id'])).toList();

      return Group.fromJsonList(filteredGroups);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //TODO: view all private groups (with some restrictions)
  Future<List<Group>?> getPrivateGroups() async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.groups)
          .select(groupsQuery)
          .eq('is_public', false);

      //filter out my joined groups
      final joinedGroups = await _supabase
          .from(SupabaseTables.groupMemebers)
          .select('*')
          // .eq('joined', true)
          .or('requested_to_join.eq.true, joined.eq.true')
          .eq('user', '${_authService.user?.id}');

      final joinedGroupIds =
          joinedGroups.map((group) => group['group']).toList();

      final filteredGroups =
          res.where((group) => !joinedGroupIds.contains(group['id'])).toList();

      return Group.fromJsonList(filteredGroups);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //TODO: view all public groups (with some restrictions i.e for you groups etc)
  Future<List<Group>?> getMyCreatedGroups() async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.groups)
          .select(groupsQuery)
          .eq('admin', '${_authService.user?.id}');

      return Group.fromJsonList(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //TODO: view_joined_groups
  Future<List<Group>?> getJoinedGroups() async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.groupMemebers)
          .select(joinedGroupsQuery)
          .eq('joined', true)
          .eq('user', '${_authService.user?.id}');

      print('res in getJoinedGroups $res');

      return Group.fromJoinedGroupJsonList(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //TODO: view groups_in_which_you_are_invited
  Future<List<InvitedGroup>?> getInvitedGroups() async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final List<InvitedGroup> allGroups = [];

      final res = await _supabase
          .from(SupabaseTables.groupMemebers)
          .select(invitedGroupsQuery)
          .eq('joined', false)
          .eq('invited', true)
          .eq('user', '${_authService.user?.id}');

      if (res.length > 0) {
        for (Map<String, dynamic> e in res) {
          final Group? invitedGroup = e['group'] != null
              ? Group.fromMap(e['group'] as Map<String, dynamic>)
              : null;

          List<AppUser>? invitedByUsers;

          if (e['invited_by'] != null) {
            invitedByUsers =
                await getListOfUsers(e['invited_by'] as List<dynamic>);
          }

          final int totalMembers = invitedGroup?.id != null
              ? await getTotalGroupMembers(invitedGroup!.id!)
              : 0;

          allGroups.add(InvitedGroup(
            groupMemberId: e['id'],
            group: invitedGroup,
            invitedBy: invitedByUsers,
            groupTotalMembers: totalMembers,
          ));
        }
      }

      print(res);

      return allGroups;
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //TODO: view_all_join_requests (USERS basically)_of_a_group
  Future<List<GroupMember>?> getJoinRequests(int groupId) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.groupMemebers)
          .select(groupMembersQuery)
          .eq('joined', false)
          .eq('requested_to_join', true)
          .eq('group', groupId);

      print(res);

      return GroupMember.fromJsonList(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //TODO: see all members of a group
  Future<List<SeeAllMembersUser>?> getAllMembers(int groupId) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.groupMemebers)
          .select(seeAllMembersQuery)
          .eq('joined', true)
          .eq('requested_to_join', false)
          .eq('invited', false)
          .eq('group', groupId);

      print(res);

      return SeeAllMembersUser.fromJsonList(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //TODO: insert group
  Future<Group?> insertGroup(Group group) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.groups)
          .insert(group.insertToMap())
          .select(groupsQuery)
          .single();

      print(res);
      if (res['id'] != null) {
        final joined = await joinPublicGroup(
            _authService.user?.id ?? '', res['id'] as int);

        if (joined) {
          return Group.fromMap(res);
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //TODO: update group
  Future<Group?> updateGroup(Group group) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.groups)
          .update(group.toMap())
          .eq('id', group.id!)
          .select(groupsQuery)
          .single();

      print(res);

      return Group.fromMap(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //TODO: delete group
  Future<Group?> deleteGroup(int groupId) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.groups)
          .delete()
          .eq('id', groupId)
          .select(groupsQuery)
          .single();

      print(res);

      return Group.fromMap(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //TODO: disable group
  Future<bool> disableGroup(int groupId, bool isEnabled) async {
    try {
      if (!_isConnected()) {
        return false;
      }

      final res = await _supabase
          .from(SupabaseTables.groups)
          .update({'is_enabled': isEnabled})
          .eq('id', groupId)
          .select(groupsQuery)
          .single();

      print(res);

      return true;
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return false;
    }
  }

  //TODO: add or update group image/cover
  Future<Group?> uploadGroupImage(int groupId, File image) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final imageName = '${_authService.user?.id}/$groupId';

      final publicUrl = _supabase.storage
          .from(SupabaseBuckets.groupImagesBucket)
          .getPublicUrl(imageName);

      final bool doesExists = await UtilFunctions.isResourceFound(publicUrl);

      if (doesExists) {
        final res = await _supabase.storage
            .from(SupabaseBuckets.groupImagesBucket)
            .update(imageName, image);
        print('update res: $res');
      } else {
        final res = await _supabase.storage
            .from(SupabaseBuckets.groupImagesBucket)
            .upload(imageName, image);
        print('upload res: $res');
      }

      final updatedGroup = await _supabase
          .from(SupabaseTables.groups)
          .update({'group_image': publicUrl})
          .eq('id', groupId)
          .select(groupsQuery)
          .single();

      return Group.fromMap(updatedGroup);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //TODO: approve join request (only used by admin of the group)
  Future<bool> approveJoinRequest(int groupMemberId) async {
    try {
      if (!_isConnected()) {
        return false;
      }

      final res = await _supabase
          .from(SupabaseTables.groupMemebers)
          .update({
            'joined': true,
            'date_joined': DateTime.now().toIso8601String(),
            'requested_to_join': false,
            'invited': false,
            'invited_by': null,
          })
          .eq('id', groupMemberId)
          .select(groupMembersQuery)
          .single();

      // print(res);
      final member = GroupMember.fromMap(res);

      return member.joined != null && member.joined!;
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return false;
    }
  }

  //TODO: reject join request
  Future<bool> rejectJoinRequest(int groupMemberId) async {
    try {
      if (!_isConnected()) {
        return false;
      }

      final groupMember = await _supabase
          .from(SupabaseTables.groupMemebers)
          .select(groupMembersQuery)
          .eq('id', groupMemberId)
          .single();

      final member = GroupMember.fromMap(groupMember);

      if (member.invited == true &&
          (member.invitedBy != null && member.invitedBy!.isNotEmpty)) {
        final res = await _supabase
            .from(SupabaseTables.groupMemebers)
            .update({
              'joined': false,
              'requested_to_join': false,
            })
            .eq('id', groupMemberId)
            .select(groupMembersQuery)
            .single();

        final result = GroupMember.fromMap(res);

        return result.joined != null &&
            result.joined! &&
            result.requestedToJoin != null &&
            result.requestedToJoin!;
      } else {
        final res = await _supabase
            .from(SupabaseTables.groupMemebers)
            .delete()
            .eq('id', groupMemberId)
            .select(groupMembersQuery)
            .single();

        final result = GroupMember.fromMap(res);

        return result.id != null;
      }
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return false;
    }
  }

  //TODO: join a group by accepting an invite
  Future<bool> acceptInviteRequest(int groupMemberId) async {
    try {
      if (!_isConnected()) {
        return false;
      }

      final res = await _supabase
          .from(SupabaseTables.groupMemebers)
          .update({
            'joined': true,
            'date_joined': DateTime.now().toIso8601String(),
            'requested_to_join': false,
            'invited': false,
            'invited_by': null,
          })
          .eq('id', groupMemberId)
          .select(groupMembersQuery)
          .single();

      // print(res);
      final member = GroupMember.fromMap(res);

      return member.joined != null && member.joined!;
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return false;
    }
  }

  //TODO: reject an group invite
  Future<bool> rejectInviteRequest(int groupMemberId) async {
    try {
      if (!_isConnected()) {
        return false;
      }

      final groupMember = await _supabase
          .from(SupabaseTables.groupMemebers)
          .select(groupMembersQuery)
          .eq('id', groupMemberId)
          .single();

      final member = GroupMember.fromMap(groupMember);

      if (member.requestedToJoin == true) {
        final res = await _supabase
            .from(SupabaseTables.groupMemebers)
            .update({
              'joined': false,
              'invited': false,
              'invited_by': null,
            })
            .eq('id', groupMemberId)
            .select(groupMembersQuery)
            .single();

        final result = GroupMember.fromMap(res);

        return result.joined != null &&
            result.joined! &&
            result.requestedToJoin != null &&
            result.requestedToJoin!;
      } else {
        final res = await _supabase
            .from(SupabaseTables.groupMemebers)
            .delete()
            .eq('id', groupMemberId)
            .select(groupMembersQuery)
            .single();

        final result = GroupMember.fromMap(res);

        return result.id != null;
      }
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return false;
    }
  }

  //TODO: get total members of a group
  Future<int> getTotalGroupMembers(int groupId) async {
    try {
      if (!_isConnected()) {
        return 0;
      }

      final res = await _supabase
          .from(SupabaseTables.groupMemebers)
          .select(groupMembersQuery)
          .eq('group', groupId)
          .eq('joined', true)
          .count(CountOption.exact);

      return res.count;
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return 0;
    }
  }

  //TODO: invite user to group
  Future<bool> inviteUserToGroup(String userId, int groupId,
      {bool showSnackbar = false}) async {
    try {
      if (!_isConnected()) {
        return false;
      }

      final doesExist = await _supabase
          .from(SupabaseTables.groupMemebers)
          .select(groupMembersQuery)
          .eq('group', groupId)
          .eq('user', userId);

      if (doesExist.isEmpty) {
        final res = await _supabase
            .from(SupabaseTables.groupMemebers)
            .insert({
              'user': userId,
              'group': groupId,
              'joined': false,
              'requested_to_join': false,
              'invited': true,
              'invited_by': [_authService.user!.id!],
            })
            .select(groupMembersQuery)
            .single();
        return res['id'] != null;
      }

      //TODO: update the invited_by field
      List<dynamic>? invitedBy = doesExist.first['invited_by'];

      List<dynamic> newInvitedBy = [];

      if (invitedBy != null && invitedBy.isNotEmpty) {
        newInvitedBy.addAll(invitedBy);
      }
      newInvitedBy.add(_authService.user!.id!);

      final res = await _supabase
          .from(SupabaseTables.groupMemebers)
          .update({
            'invited': 'true',
            'invited_by': newInvitedBy,
          })
          .eq('id', doesExist.first['id'])
          .select(groupMembersQuery)
          .single();

      return res['id'] != null;
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return false;
    }
  }

  //TODO: leave group / remove user from group
  Future<bool> leaveOrRemoveUserFromGroup(String userId, int groupId) async {
    try {
      if (!_isConnected()) {
        return false;
      }

      final res = await _supabase
          .from(SupabaseTables.groupMemebers)
          .delete()
          .eq('user', userId)
          .eq('group', groupId)
          .select(groupMembersQuery)
          .single();
      return res['id'] != null;
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return false;
    }
  }

  //TODO: leave group / remove user from group
  Future<bool> leaveOrRemoveUserFromGroupByGroudMemberId(
      int groupMemberId) async {
    try {
      if (!_isConnected()) {
        return false;
      }

      final res = await _supabase
          .from(SupabaseTables.groupMemebers)
          .delete()
          .eq('id', groupMemberId)
          .select(groupMembersQuery)
          .single();

      return res['id'] != null;
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return false;
    }
  }

  //TODO: request to join group
  Future<bool> requestToJoinGroup(String userId, int groupId) async {
    try {
      if (!_isConnected()) {
        return false;
      }

      final doesExist = await _supabase
          .from(SupabaseTables.groupMemebers)
          .select(groupMembersQuery)
          .eq('group', groupId)
          .eq('user', userId);

      if (doesExist.isEmpty) {
        final res = await _supabase
            .from(SupabaseTables.groupMemebers)
            .insert({
              'user': userId,
              'group': groupId,
              'join_request_time': DateTime.now().toIso8601String(),
              'joined': false,
              'requested_to_join': true,
            })
            .select(groupMembersQuery)
            .single();
        return res['id'] != null;
      }

      final res = await _supabase
          .from(SupabaseTables.groupMemebers)
          .update({
            'join_request_time': DateTime.now().toIso8601String(),
            'requested_to_join': true,
          })
          .eq('id', doesExist.first['id'])
          .select(groupMembersQuery)
          .single();

      return res['id'] != null;
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return false;
    }
  }

  //TODO: join group
  Future<bool> joinPublicGroup(String userId, int groupId) async {
    try {
      if (!_isConnected()) {
        return false;
      }

      final groupMembers = await _supabase
          .from(SupabaseTables.groupMemebers)
          .select(groupMembersQuery)
          .eq('group', groupId)
          .eq('user', userId);

      if (groupMembers.isNotEmpty) {
        Constants.customWarningSnack('You are already a member of this group');
        return false;
      }

      final res = await _supabase
          .from(SupabaseTables.groupMemebers)
          .insert({
            'user': userId,
            'group': groupId,
            'date_joined': DateTime.now().toIso8601String(),
            'joined': true,
          })
          .select(groupMembersQuery)
          .single();

      return res['id'] != null;
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return false;
    }
  }

  // get the list of users for inviting
  Future<List<AppUser>?> getUsersForInvite(int groupId) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase.from(SupabaseTables.appUsers).select('*');

      //TODO: filter the users that are not invited yet or requested to join
      final alreadyInvitedOrJoinedUsers = await _supabase
          .from(SupabaseTables.groupMemebers)
          .select('user')
          .eq('group', groupId)
          .or('invited.eq.true, joined.eq.true');
      // .eq('invited', true);

      // final alreadyJoined = await _supabase
      //     .from(SupabaseTables.groupMemebers)
      //     .select('user')
      //     .eq('group', groupId)
      //     .eq('joined', true);

      final filteredRes = res
          .where((user) =>
              !alreadyInvitedOrJoinedUsers.any((u) => u['user'] == user['id']))
          .toList();

      // filteredRes.removeWhere(
      //     (user) => alreadyJoined.any((u) => u['user'] == user['id']));

      return AppUser.fromJsonList(filteredRes);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //TODO: important: when a user joins a group joined will be true baki sab false and join date will also be updated

  ///////////////////////////////HELPER FUNCTIONS///////////////////////////////////

  // get the list of users with userIds
  Future<List<AppUser>?> getListOfUsers(List<dynamic> userIds) async {
    try {
      if (!_isConnected()) {
        return null;
      }

      final res = await _supabase
          .from(SupabaseTables.appUsers)
          .select('*')
          .inFilter('id', userIds);

      print('list of users: $res');

      return AppUser.fromJsonList(res);
    } catch (e) {
      print(e);
      Constants.customErrorSnack(e.toString());
      return null;
    }
  }

  //////////////////////////////////////////////////////////////////////////////////

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

const String groupsQuery = '''
        *,
        admin(*)
        ''';

const String joinedGroupsQuery = '''
        group($groupsQuery)
        ''';

const String invitedGroupsQuery = '''
        id,
        invited_by,
        group($groupsQuery)
        ''';
const String joinRequestsQuery = '''
        user(*),
        join_request_time
        ''';

const String seeAllMembersQuery = '''
        id,
        user(*),
        date_joined
        ''';

const String groupMembersQuery = '''
        *,
        user(*),
        group($groupsQuery)
        ''';
