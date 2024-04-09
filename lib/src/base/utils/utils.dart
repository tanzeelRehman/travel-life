import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension UIExt on BuildContext {
  double topSpace() => MediaQuery.of(this).padding.top;
  double appBarHeight() => AppBar().preferredSize.height;
  Size screenSize() => MediaQuery.of(this).size;
  double completeHeight() =>
      MediaQuery.of(this).size.height +
      MediaQuery.of(this).padding.top +
      MediaQuery.of(this).padding.bottom +
      MediaQuery.of(this).viewPadding.top +
      MediaQuery.of(this).viewPadding.bottom;

  ThemeData appTheme() => Theme.of(this);
  TextTheme appTextTheme() => Theme.of(this).textTheme;

  void closeKeyboardIfOpen() {
    FocusScopeNode currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
  }
}

class ValidationUtils {
  ValidationUtils._();
  static String? validateName(String? value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value?.isEmpty ?? true) {
      return "Name is required";
    } else if (!regExp.hasMatch(value ?? '')) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  static String? validateMobile(String? value) {
    String pattern = r'(^\+?[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value?.isEmpty ?? true) {
      return "Mobile phone number is required";
    } else if (!regExp.hasMatch(value ?? '')) {
      return "Invalid Mobile Number";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if ((value?.length ?? 0) < 6) {
      return 'Password must be atleast 6 characters';
    } else {
      return null;
    }
  }

  // static String? validateTextFormFieldForEmptyInput(String? value) {
  //   if ((value?.length ?? 0) < 1) {
  //     return 'Empty input not allowed';
  //   } else {
  //     return null;
  //   }
  // }

  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value ?? '')) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(
      {String? password, String? confirmPassword}) {
    if (password != confirmPassword) {
      return 'Password doesn\'t match';
    } else if (confirmPassword?.isEmpty ?? true) {
      return 'Confirm password is required';
    } else {
      return null;
    }
  }

  static List<TextInputFormatter> numberTextInputFormater = [
    FilteringTextInputFormatter.digitsOnly
  ];
}

class UtilFunctions {
  UtilFunctions._();

  static int calculateAge(DateTime dob) {
    DateTime now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }

  static Future<bool> isResourceFound(String url) async {
    try {
      final Dio dio = Dio();
      final response = await dio.head(url);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 304) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> isPDF(String fileUrl) async {
    try {
      final Dio dio = Dio();
      final response = await dio.head(fileUrl);
      print(response.headers);
      return response.headers.value('content-type') == 'application/pdf';
    } catch (e) {
      return false;
    }
  }
}
