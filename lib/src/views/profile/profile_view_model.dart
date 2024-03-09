import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/services/local/bottom_sheet_service.dart';
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

      //EXTENDED PROFILE
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

  // onClickAddImage() {}
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

  onClickSave() async {
    try {
      setBusy(true);
      final newUser = supabaseAuthService.user!.copyWith(
        address: addressController.text,
        city: cityController.text,
        state: stateController.text,
        country: countryController.text,
        zip: zipCodeController.text,
        website: websiteController.text,
        currency: currencyController.text,
        age: int.tryParse(ageController.text),
        alias: aliasController.text,
        gender: genderController.text,
        bio: bioController.text,
        dob: dob,
        bloodGroup: bloodGroupController.text,
        mobile: mobileController.text,
        nextOfKin: nextOfKin.text,
        nextOfKinMobile: int.tryParse(nextOfKinMobile.text),
        ridingExperience: ridingExperienceController.text,
        firstname: firstnameController.text,
        lastname: lastnameController.text,
        updatedAt: DateTime.now(),
      );

      final updatedUser = await supabaseAuthService.updateUser(newUser);

      if (updatedUser != null) {
        Constants.customSuccessSnack('Profile updated successfully');
      }
      setBusy(false);
      return;
    } on CustomNoInternetException catch (e) {
      Constants.customWarningSnack(e.message);
      setBusy(false);
    } catch (e) {
      Constants.customWarningSnack(e.toString());
      setBusy(false);
    }
  }
}

enum Gender { male, female, others }

enum BloodGroup {
  o_positive,
  o_negative,
  a_positive,
  a_negative,
  b_positive,
  b_negative,
  ab_positive,
  ab_negative
}

String getReadableBloodGroup(BloodGroup bloodGroup) {
  switch (bloodGroup) {
    case BloodGroup.o_positive:
      return 'O+';
    case BloodGroup.o_negative:
      return 'O-';
    case BloodGroup.a_positive:
      return 'A+';
    case BloodGroup.a_negative:
      return 'A-';
    case BloodGroup.b_positive:
      return 'B+';
    case BloodGroup.b_negative:
      return 'B-';
    case BloodGroup.ab_positive:
      return 'AB+';
    case BloodGroup.ab_negative:
      return 'AB-';
    default:
      throw ArgumentError('Invalid blood group: $bloodGroup');
  }
}

BloodGroup getBloodGroupFromReadable(String text) {
  switch (text) {
    case 'O+':
      return BloodGroup.o_positive;
    case 'O-':
      return BloodGroup.o_negative;
    case 'A+':
      return BloodGroup.a_positive;
    case 'A-':
      return BloodGroup.a_negative;
    case 'B+':
      return BloodGroup.b_positive;
    case 'B-':
      return BloodGroup.b_negative;
    case 'AB+':
      return BloodGroup.ab_positive;
    case 'AB-':
      return BloodGroup.ab_negative;
    default:
      throw ArgumentError('Invalid blood group text: $text');
  }
}

String getReadableGender(Gender gender) {
  switch (gender) {
    case Gender.male:
      return 'Male';
    case Gender.female:
      return 'Female';
    case Gender.others:
      return 'Others';
    default:
      throw ArgumentError('Invalid gender: $gender');
  }
}

Gender getGenderFromReadable(String text) {
  switch (text.toLowerCase()) {
    case 'male':
      return Gender.male;
    case 'female':
      return Gender.female;
    case 'others':
      return Gender.others;
    default:
      throw ArgumentError('Invalid gender text: $text');
  }
}

class GenderButtonModel {
  final Gender gender;
  final String iconPath;

  GenderButtonModel({required this.gender, required this.iconPath});
}
