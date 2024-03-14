import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/blood_group.dart';
import 'package:starter_app/src/base/enums/gender.dart';
import 'package:starter_app/src/base/enums/riding_experience.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/services/local/bottom_sheet_service.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';
import 'package:starter_app/src/services/remote/supabase_auth_service.dart';

class ProfileViewModel extends ReactiveViewModel with SupabaseAuthViewModel {
  int selectedTab = 0;

  List<GenderButtonModel> genderButtons = [
    GenderButtonModel(gender: Gender.male, iconPath: AssetIcons.maleIcon),
    GenderButtonModel(gender: Gender.female, iconPath: AssetIcons.femaleIcon),
    GenderButtonModel(gender: Gender.others, iconPath: AssetIcons.othersIcon),
  ];

  toggleSelectedTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  File? selectedImage;

  DateTime? dob;

  Gender? gender;

  Gender? selectedGender;

  BloodGroup? bloodGroup;

  BloodGroup? selectedBloodGroup;

  RidingExperience? ridingExperience;

  final formKey = GlobalKey<FormState>();

  final firstnameController = TextEditingController();

  final lastnameController = TextEditingController();

  final dobController = TextEditingController();

  final emailController = TextEditingController();

  final bioController = TextEditingController();

  final mobileController = TextEditingController();

  final ageController = TextEditingController();

  final ridingExperienceController = TextEditingController();

  final nextOfKin = TextEditingController();

  final nextOfKinMobile = TextEditingController();

  final aliasController = TextEditingController();

  final genderController = TextEditingController();

  final bloodGroupController = TextEditingController();

  //EXTENDED PROFILE

  final addressController = TextEditingController();

  final stateController = TextEditingController();

  final cityController = TextEditingController();

  final countryController = TextEditingController();

  final zipCodeController = TextEditingController();

  final websiteController = TextEditingController();

  final currencyController = TextEditingController();

  int calculateAge(DateTime dob) {
    DateTime now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }

  toggleGender(Gender gender) {
    selectedGender = gender;
    notifyListeners();
    rebuildUi();
  }

  toggleBloodGroup(BloodGroup bloodGroup) {
    selectedBloodGroup = bloodGroup;
    notifyListeners();
    rebuildUi();
  }

  bool isUploading = false;

  setIsUploading(bool value) {
    isUploading = value;
    notifyListeners();
  }

  _uploadImage() async {
    if (selectedImage != null) {
      print('hello im here');
      try {
        setIsUploading(true);
        await supabaseAuthService.uploadProfilePicture(selectedImage!);
        setIsUploading(false);
      } on CustomNoInternetException catch (e) {
        setIsUploading(false);
        Constants.customErrorSnack(e.message);

        print(e);
      } catch (e) {
        setIsUploading(false);
        // print(e);
        Constants.customErrorSnack(e.toString());
      }
    }
  }

  init() {
    final user = supabaseAuthService.user;
    if (user != null) {
      firstnameController.text = user.firstname ?? "";
      lastnameController.text = user.lastname ?? "";
      emailController.text = user.email ?? "";
      bioController.text = user.bio ?? "";
      mobileController.text = user.mobile ?? "";
      ageController.text = user.age != null ? user.age.toString() : "";
      ridingExperienceController.text =
          user.ridingExperience != null ? user.ridingExperience.toString() : "";
      nextOfKin.text = user.nextOfKin ?? "";
      nextOfKinMobile.text =
          user.nextOfKinMobile != null ? user.nextOfKinMobile.toString() : "";
      aliasController.text = user.alias ?? "";

      //EXTENDED PROFILE
      genderController.text = user.gender ?? "";
      bloodGroupController.text = user.bloodGroup ?? "";

      //EXTENDED PROFILE

      addressController.text = user.address ?? "";
      stateController.text = user.state ?? "";
      cityController.text = user.city ?? "";
      countryController.text = user.country ?? "";
      zipCodeController.text = user.zip ?? "";
      websiteController.text = user.website ?? "";
      currencyController.text = user.currency ?? "";

      print('user dob is: ${user.dob}');
      if (user.dob != null) {
        dob = user.dob;
        dobController.text = DateFormat('dd/MM/yyyy').format(user.dob!);
      }
      if (user.gender != null && user.gender!.isNotEmpty) {
        gender = getGenderFromReadable(user.gender!);
      }
      if (user.bloodGroup != null && user.bloodGroup!.isNotEmpty) {
        bloodGroup = getBloodGroupFromReadable(user.bloodGroup!);
      }
      if (user.ridingExperience != null && user.ridingExperience!.isNotEmpty) {
        ridingExperience =
            getRidingExperienceFromReadable(user.ridingExperience!);
        ridingExperienceController.text =
            getReadableRidingExperience(ridingExperience!);
      }
    }
  }

  Future<void> _pickCameraImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (image == null) return;

      final imageTemp = File(image.path);

      selectedImage = imageTemp;
      notifyListeners();
      _uploadImage();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> _pickGalleryImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image == null) return;

      final imageTemp = File(image.path);

      selectedImage = imageTemp;

      notifyListeners();
      _uploadImage();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
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

  onClickLogout() async {
    try {
      setIsUploading(true);
      await supabaseAuthService.logout();
      setIsUploading(false);

      NavService.login();
    } on CustomNoInternetException catch (e) {
      setIsUploading(false);

      print(e.message);
    } on AuthExcepection catch (e) {
      setIsUploading(false);

      print(e.message);
    } catch (e) {
      setIsUploading(false);

      print(e);
    }
  }

  onClickSave() async {
    try {
      setBusy(true);
      final newUser = supabaseAuthService.user!.copyWith(
        address: addressController.text.trim(),
        city: cityController.text.trim(),
        state: stateController.text.trim(),
        country: countryController.text.trim(),
        zip: zipCodeController.text.trim(),
        website: websiteController.text.trim(),
        currency: currencyController.text.trim(),
        age: int.tryParse(ageController.text),
        alias: aliasController.text.trim(),
        gender: genderController.text.trim(),
        bio: bioController.text.trim(),
        dob: dob,
        bloodGroup: bloodGroupController.text.trim(),
        mobile: mobileController.text.trim(),
        nextOfKin: nextOfKin.text.trim(),
        nextOfKinMobile: int.tryParse(nextOfKinMobile.text.trim()),
        ridingExperience: ridingExperienceController.text.trim(),
        firstname: firstnameController.text.trim(),
        lastname: lastnameController.text.trim(),
        updatedAt: DateTime.now(),
      );

      final updatedUser = await supabaseAuthService.updateUser(newUser);

      if (updatedUser != null) {
        NavService.back();

        Constants.customSuccessSnack('Profile updated successfully');
      }
      setBusy(false);
      return;
    } on CustomNoInternetException catch (e) {
      Constants.customWarningSnack(e.message);
      setBusy(false);
    } on AuthExcepection catch (e) {
      Constants.customWarningSnack(e.message);
      setBusy(false);
    } catch (e) {
      Constants.customWarningSnack(e.toString());
      setBusy(false);
    }
  }

  onSelectRidingExperience(RidingExperience? ridingExperience) {
    if (ridingExperience != null) {
      this.ridingExperience = ridingExperience;
      ridingExperienceController.text =
          getReadableRidingExperience(ridingExperience);
      notifyListeners();
    }
  }

  onSelectDob(DateTime? dateTime) {
    if (dateTime != null) {
      dob = dateTime;
      dobController.text = DateFormat('dd-MM-yyyy').format(dateTime);

      ageController.text = calculateAge(dateTime).toString();
      notifyListeners();
    }
  }

  onSelectGender(Gender? gender) {
    if (gender != null) {
      this.gender = gender;
      this.selectedGender = gender;
      genderController.text = getReadableGender(gender);
      notifyListeners();
    }
  }

  onSelectBloodGroup(BloodGroup? bloodGroup) {
    if (bloodGroup != null) {
      this.bloodGroup = bloodGroup;
      bloodGroupController.text = getReadableBloodGroup(bloodGroup);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    dobController.dispose();
    bioController.dispose();
    mobileController.dispose();
    ageController.dispose();
    ridingExperienceController.dispose();
    nextOfKin.dispose();
    nextOfKinMobile.dispose();
    aliasController.dispose();

    genderController.dispose();
    bloodGroupController.dispose();

    //EXTENDED PROFILE

    addressController.dispose();
    stateController.dispose();
    cityController.dispose();
    countryController.dispose();
    zipCodeController.dispose();
    websiteController.dispose();
    currencyController.dispose();

    super.dispose();
  }
}

class GenderButtonModel {
  final Gender gender;
  final String iconPath;

  GenderButtonModel({required this.gender, required this.iconPath});
}
