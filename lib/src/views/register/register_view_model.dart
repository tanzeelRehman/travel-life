// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/services/local/base/connectivity_view_model.dart';
// import 'package:starter_app/src/models/register_model.dart';
// import 'package:starter_app/src/services/local/bottomsheet_service.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/api_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';
import 'package:starter_app/src/services/remote/supabase_auth_service.dart';

class RegisterViewModel extends ReactiveViewModel
    with SupabaseAuthViewModel, ConnectivityViewModel {
  init() {}

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController numberController = TextEditingController();

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  File? selectedImage;

  // Future<void> _pickCameraImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(
  //       source: ImageSource.camera,
  //     );
  //     if (image == null) return;

  //     final imageTemp = File(image.path);

  //     selectedImage = imageTemp;
  //     notifyListeners();
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  // Future<void> _pickGalleryImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(
  //       source: ImageSource.gallery,
  //     );
  //     if (image == null) return;

  //     final imageTemp = File(image.path);

  //     selectedImage = imageTemp;
  //     notifyListeners();
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  onClickAddImage() async {
    // final ImageSource? imageSource =
    //     await BottSheetViewModel.showImagePickerOptions();
    // if (imageSource == null) return;

    // if (imageSource == ImageSource.camera) {
    //   _pickCameraImage();
    // } else if (imageSource == ImageSource.gallery) {
    //   _pickGalleryImage();
    // }
  }

  onRegister() async {
    if (formKey.currentState!.validate()) {
      setBusy(true);
      try {
        if (!connectivityService.isInternetConnected) {
          Constants.customErrorSnack('No internet connection');
          setBusy(false);
          return;
        }

        final response = await supabaseAuthService.register(
          emailController.text,
          passwordController.text,
          firstName: firstNameController.text,
          phone: numberController.text,
          lastName: lastNameController.text,
        );

        if (response == null) {
          Constants.customWarningSnack('Error registering the user');
          setBusy(false);

          return;
        }
        Constants.customSuccessSnack('Welcome ${response.firstname}');

        setBusy(false);

        NavService.home();
      } on AuthExcepection catch (e) {
        print(e.message);
        Constants.customErrorSnack(e.message);

        setBusy(false);
      } on CustomNoInternetException catch (e) {
        print(e.message);
        Constants.customErrorSnack(e.message);

        setBusy(false);
      } catch (e) {
        print(e);
        setBusy(false);

        Constants.customErrorSnack(e.toString());
        return;
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    numberController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }
}
