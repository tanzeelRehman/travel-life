import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/event_action.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/models/app_user.dart';
import 'package:starter_app/src/models/event.dart';
import 'package:starter_app/src/models/ors_models/get_geocode_response_model.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';
import 'package:starter_app/src/services/local/bottom_sheet_service.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class EventCreateViewModel extends ReactiveViewModel
    with SupabaseAuthViewModel, DatabaseViewModel, DataViewModel {
  Event? editEvent;
  late final EventAction eventAction;

  double? destLat;
  double? destLong;
  AppUser? organizer;
  int? noOfDays;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  init(EventAction action, Event? event) {
    eventAction = action;
    editEvent = event;
    notifyListeners();
    if (editEvent != null) {
      nameController.text = editEvent!.name ?? '';
      descriptionController.text = editEvent!.description ?? '';

      startDate = editEvent!.startTime;
      if (startDate != null) {
        startDateController.text = formatDate(startDate!);
      }

      endDate = editEvent!.endTime;
      if (endDate != null) {
        endDateController.text = formatDate(endDate!);
      }

      destinationController.text = editEvent!.destination ?? '';

      destLat = editEvent!.destLat;
      destLong = editEvent!.destLong;
      organizer = editEvent?.organizer;
      noOfDays = editEvent?.noOfDays;
    } else {
      startDate = DateTime.now();
      startDateController.text = formatDate(startDate!);
      endDate = DateTime.now().add(const Duration(days: 1));
      endDateController.text = formatDate(endDate!);
      noOfDays = 1;
      organizer = supabaseAuthService.user;
    }
    notifyListeners();
  }

  onChangeStartDate(DateTime? date) {
    if (date == null) return;
    startDate = date;
    startDateController.text = formatDate(date);
    notifyListeners();
  }

  onChangeEndDate(DateTime? date) {
    if (date == null) return;
    endDate = date;
    endDateController.text = formatDate(date);
    notifyListeners();
  }

  onChangeDestination(Features? v) {
    if (v == null) return;
    destinationController.text = v.properties?.label ?? '';
    destLong = v.geometry?.coordinates?.first;
    destLat = v.geometry?.coordinates?.last;
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
      message.write('Event Name, ');
      isValid = false;
    }

    if (destinationController.text.isEmpty) {
      message.write('Destination, ');
      isValid = false;
    }

    if (startDate == null) {
      message.write('Start Date, ');
      isValid = false;
    }

    if (endDate == null) {
      message.write('End Date, ');
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

  Event _createEvent() {
    noOfDays = calculateDays(startDate: startDate, endDate: endDate);
    return Event(
      id: eventAction == EventAction.edit ? editEvent?.id : null,
      name: nameController.text,
      description: descriptionController.text,
      destLat: destLat,
      destLong: destLong,
      endTime: endDate,
      startTime: startDate,
      destination: destinationController.text,
      organizer: organizer,
      noOfDays: noOfDays,
    );
  }

  updateOrInsertEvent() async {
    if (!validateInput()) {
      return;
    }
    if (editEvent == null && eventAction == EventAction.add) {
      setBusy(true);

      final inserted = await databaseService.insertEvent(_createEvent());

      if (inserted != null && selectedImage != null) {
        final updatedEventWithImage =
            await databaseService.uploadEventCoverImage(
          inserted.id!,
          selectedImage!,
        );
        setBusy(false);

        if (updatedEventWithImage != null) {
          // getMyGroups();
          // getJoinedGroups();
          NavService.back();
          // clearFeilds();
          Constants.customSuccessSnack('Event created successfully');
        }
        return;
      }
      setBusy(false);

      if (inserted != null) {
        // getMyGroups();
        // getJoinedGroups();
        NavService.back();
        // clearFeilds();
        Constants.customSuccessSnack('Event created successfully');
      }
    } else {
      //   setBusy(true);
      //   final inserted = await databaseService.updateEvent(_createEvent());
      //   setBusy(false);

      //   if (inserted != null && selectedImage != null) {
      //     final updatedUserWithProfile = await databaseService.uploadGroupImage(
      //       inserted.id!,
      //       selectedImage!,
      //     );
      //     setBusy(false);

      //     if (updatedUserWithProfile != null) {
      //       getMyGroups();
      //       getJoinedGroups();
      //       NavService.back();
      //       // clearFeilds();
      //       Constants.customSuccessSnack('Group updated successfully');
      //     }
      //     return;
      //   }

      //   setBusy(false);

      //   if (inserted != null) {
      //     getMyGroups();
      //     getJoinedGroups();
      //     NavService.back();
      //     // clearFeilds();
      //     Constants.customSuccessSnack('Group updated successfully');
      //   }
      // }
    }
  }

  // getMyGroups() async {
  //   dataService.myGroups = await databaseService.getMyCreatedGroups() ?? [];
  // }

  // getJoinedGroups() async {
  //   dataService.joinedGroups = await databaseService.getJoinedGroups() ?? [];
  // }

  int calculateDays({DateTime? startDate, DateTime? endDate}) {
    if (startDate == null || endDate == null) {
      return 0;
    } else {
      return endDate.difference(startDate).inDays;
    }
  }

  String formatDate(DateTime time) {
    return DateFormat('yMMMd').format(time);
  }
}
