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
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/ui_models/gender_button_model.dart';
import 'package:starter_app/src/services/local/bottom_sheet_service.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';
import 'package:starter_app/src/services/remote/supabase_auth_service.dart';

class ProfileViewModel extends ReactiveViewModel with SupabaseAuthViewModel {
  int selectedTab = 0;

  toggleSelectedTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  List<GenderButtonModel> genderButtons = [
    GenderButtonModel(gender: Gender.male, iconPath: AssetIcons.maleIcon),
    GenderButtonModel(gender: Gender.female, iconPath: AssetIcons.femaleIcon),
    GenderButtonModel(gender: Gender.others, iconPath: AssetIcons.othersIcon),
  ];

  File? selectedImage; //for updating the profile image

  DateTime? dob;

  Gender? gender;
  Gender? selectedGender; //for dialog (temporarily selected)

  BloodGroup? bloodGroup;

  BloodGroup? selectedBloodGroup; //for dialog (temporarily selected)

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
      //PERSONAL DETAILS
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

      if (user.dob != null) {
        dob = user.dob;
        dobController.text = DateFormat('dd/MM/yyyy').format(user.dob!);
      }
      if (user.gender != null && user.gender!.isNotEmpty) {
        gender = getGenderFromReadable(user.gender!);
        genderController.text = user.gender ?? "";
      }
      if (user.bloodGroup != null && user.bloodGroup!.isNotEmpty) {
        bloodGroup = getBloodGroupFromReadable(user.bloodGroup!);
        bloodGroupController.text = user.bloodGroup ?? "";
      }
      if (user.ridingExperience != null && user.ridingExperience!.isNotEmpty) {
        ridingExperience =
            getRidingExperienceFromReadable(user.ridingExperience!);
        ridingExperienceController.text =
            getReadableRidingExperience(ridingExperience!);
      }

      //EXTENDED PROFILE
      addressController.text = user.address ?? "";
      stateController.text = user.state ?? "";
      cityController.text = user.city ?? "";
      countryController.text = user.country ?? "";
      zipCodeController.text = user.zip ?? "";
      websiteController.text = user.website ?? "";
      currencyController.text = user.currency ?? "";
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
        address:
            addressController.text.isNotEmpty ? addressController.text : null,
        city: cityController.text.isNotEmpty ? cityController.text : null,
        state: stateController.text.isNotEmpty ? stateController.text : null,
        country:
            countryController.text.isNotEmpty ? countryController.text : null,
        zip: zipCodeController.text.isNotEmpty ? zipCodeController.text : null,
        website:
            websiteController.text.isNotEmpty ? websiteController.text : null,
        currency:
            currencyController.text.isNotEmpty ? currencyController.text : null,
        age: int.tryParse(ageController.text),
        alias: aliasController.text.isNotEmpty ? aliasController.text : null,
        gender: genderController.text.isNotEmpty ? genderController.text : null,
        bio: bioController.text.isNotEmpty ? bioController.text : null,
        dob: dob,
        bloodGroup: bloodGroupController.text.isNotEmpty
            ? bloodGroupController.text
            : null,
        mobile: mobileController.text.isNotEmpty ? mobileController.text : null,
        nextOfKin: nextOfKin.text.isNotEmpty ? nextOfKin.text : null,
        nextOfKinMobile: int.tryParse(nextOfKinMobile.text),
        ridingExperience: ridingExperienceController.text.isNotEmpty
            ? ridingExperienceController.text
            : null,
        firstname: firstnameController.text.isNotEmpty
            ? firstnameController.text
            : null,
        lastname:
            lastnameController.text.isNotEmpty ? lastnameController.text : null,
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

  removeWhiteSpaces() {
    addressController.text = addressController.text.trim();
    cityController.text = cityController.text.trim();
    stateController.text = stateController.text.trim();
    countryController.text = countryController.text.trim();
    zipCodeController.text = countryController.text.trim();
    websiteController.text = websiteController.text.trim();
    currencyController.text = currencyController.text.trim();

    ageController.text = ageController.text.trim();
    aliasController.text = aliasController.text.trim();
    genderController.text = genderController.text.trim();
    bioController.text = bioController.text.trim();
    bloodGroupController.text = bloodGroupController.text.trim();
    mobileController.text = mobileController.text.trim();
    nextOfKin.text = nextOfKin.text.trim();
    nextOfKinMobile.text = nextOfKinMobile.text.trim();
    ridingExperienceController.text = ridingExperienceController.text.trim();
    firstnameController.text = firstnameController.text.trim();
    lastnameController.text = lastnameController.text.trim();
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

      ageController.text = UtilFunctions.calculateAge(dateTime).toString();
      notifyListeners();
    }
  }

  onSelectGender(Gender? gender) {
    if (gender != null) {
      this.gender = gender;
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
