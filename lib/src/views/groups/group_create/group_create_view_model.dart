import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/group_action.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';
import 'package:starter_app/src/services/local/bottom_sheet_service.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class GroupCreateViewModel extends ReactiveViewModel
    with SupabaseAuthViewModel, DatabaseViewModel, DataViewModel {
  // final int maxGroupSize = 50;
  final int minGroupSize = 5;
  final int defaultGroupSize = 20;

  Group? editGroup;
  late final GroupAction groupAction;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController adminAndCreatedByController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isPublic = false;
  final TextEditingController totalLimitController = TextEditingController();
  final TextEditingController createdOnController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  init(GroupAction action, Group? group) {
    groupAction = action;
    editGroup = group;
    notifyListeners();
    if (editGroup != null) {
      nameController.text = editGroup!.name ?? '';
      descriptionController.text = editGroup!.description ?? '';
      isPublic = editGroup!.isPublic ?? true;
      totalLimitController.text =
          editGroup?.maxMembers != null ? editGroup!.maxMembers.toString() : '';
      createdOnController.text =
          editGroup!.createdAt != null ? formatDate(editGroup!.createdAt!) : '';
      adminAndCreatedByController.text = editGroup!.admin?.firstname ?? '';
      locationController.text = editGroup!.locationCity ?? '';
    } else {
      createdOnController.text = formatDate(DateTime.now());
      adminAndCreatedByController.text =
          supabaseAuthService.user?.firstname ?? '';
      totalLimitController.text = defaultGroupSize.toString();
      locationController.text = supabaseAuthService.user?.city ?? '';
    }
    notifyListeners();
  }

  File? selectedImage;

  Future<void> _pickCameraImage() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 60);
      if (image == null) return;

      final imageTemp = File(image.path);

      selectedImage = imageTemp;
      notifyListeners();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> _pickGalleryImage() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 60);
      if (image == null) return;

      final imageTemp = File(image.path);

      selectedImage = imageTemp;

      notifyListeners();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  onClickRemoveImage() {
    selectedImage = null;
    notifyListeners();
  }

  onClickAddImage() async {
    final ImageSource? imageSource =
        await BottSheetViewModel.showImagePickerOptions();
    if (imageSource == null) return;

    if (imageSource == ImageSource.camera) {
      _pickCameraImage();
    } else if (imageSource == ImageSource.gallery) {
      _pickGalleryImage();
    }
  }

  bool validateInput() {
    bool isValid = true;
    StringBuffer message = StringBuffer('Please fill all required fields: ');

    if (nameController.text.isEmpty) {
      message.write('Group Name, ');
      isValid = false;
    }

    if (locationController.text.isEmpty) {
      message.write('Location, ');
      isValid = false;
    }

    if (totalLimitController.text.isEmpty ||
        int.tryParse(totalLimitController.text) == null ||
        (int.tryParse(totalLimitController.text) ?? 0) < minGroupSize) {
      message.write('Total limit (min $minGroupSize), ');
      isValid = false;
    }

    // Remove the last comma and space if present
    if (!isValid) {
      final errorMsg = message.toString();
      if (errorMsg.endsWith(', ')) {
        message.clear();
        message.write(errorMsg.substring(0, errorMsg.length - 2));
      }
      Constants.customWarningSnack(message.toString());
    }

    return isValid;
  }

  Group _createGroup() {
    return Group(
      id: groupAction == GroupAction.edit ? editGroup?.id : null,
      name: nameController.text,
      description: descriptionController.text,
      isPublic: isPublic,
      maxMembers: int.tryParse(totalLimitController.text),
      admin: supabaseAuthService.user,
      locationCity: locationController.text,
      createdAt: DateTime.now(),
    );
  }

  updateOrInsertGroup() async {
    if (!validateInput()) {
      return;
    }
    if (editGroup == null && groupAction == GroupAction.add) {
      setBusy(true);

      final inserted = await databaseService.insertGroup(_createGroup());

      if (inserted != null && selectedImage != null) {
        final updatedGroupWithImage = await databaseService.uploadGroupImage(
          inserted.id!,
          selectedImage!,
        );
        setBusy(false);

        if (updatedGroupWithImage != null) {
          getMyGroups();
          getJoinedGroups();
          NavService.back();
          // clearFeilds();
          Constants.customSuccessSnack('Group created successfully');
        }
        return;
      }
      setBusy(false);

      if (inserted != null) {
        getMyGroups();
        getJoinedGroups();
        NavService.back();
        // clearFeilds();
        Constants.customSuccessSnack('Group created successfully');
      }
    } else {
      setBusy(true);
      final inserted = await databaseService.updateGroup(_createGroup());
      setBusy(false);

      if (inserted != null && selectedImage != null) {
        final updatedUserWithProfile = await databaseService.uploadGroupImage(
          inserted.id!,
          selectedImage!,
        );
        setBusy(false);

        if (updatedUserWithProfile != null) {
          getMyGroups();
          getJoinedGroups();
          NavService.back();
          // clearFeilds();
          Constants.customSuccessSnack('Group updated successfully');
        }
        return;
      }

      setBusy(false);

      if (inserted != null) {
        getMyGroups();
        getJoinedGroups();
        NavService.back();
        // clearFeilds();
        Constants.customSuccessSnack('Group updated successfully');
      }
    }
  }

  //TODO: add this function in the future.
  clearFeilds() {
    selectedImage = null;
    nameController.clear();
    descriptionController.clear();
    isPublic = true;
    locationController.clear();
    totalLimitController.text = defaultGroupSize.toString();
    notifyListeners();
  }

  getMyGroups() async {
    dataService.myGroups = await databaseService.getMyCreatedGroups() ?? [];
  }

  getJoinedGroups() async {
    dataService.joinedGroups = await databaseService.getJoinedGroups() ?? [];
  }

  String formatDate(DateTime time) {
    return DateFormat('yMMMd').format(time);
  }
}
