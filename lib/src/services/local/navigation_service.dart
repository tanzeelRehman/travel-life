import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart';
import 'package:starter_app/src/configs/app_setup.locator.dart';
import 'package:starter_app/src/configs/app_setup.router.dart';
import 'package:starter_app/src/models/vehicle.dart';

class NavService {
  static NavigationService? _navigationService = locator<NavigationService>();
  // key
  static GlobalKey<NavigatorState>? get key => StackedService.navigatorKey;

  // on generate route
  static Route<dynamic>? Function(RouteSettings) get onGenerateRoute =>
      StackedRouter().onGenerateRoute;

  //CLEAR_STACK_AND_SHOW
  static Future<dynamic>? splash({dynamic arguments}) => _navigationService!
      .clearStackAndShow(Routes.splashView, arguments: arguments);

  static Future<dynamic>? login({dynamic arguments}) => _navigationService!
      .clearStackAndShow(Routes.loginView, arguments: arguments);

  static Future<dynamic>? register({dynamic arguments}) => _navigationService!
      .clearStackAndShow(Routes.registerView, arguments: arguments);

  static Future<dynamic>? welcome({dynamic arguments}) => _navigationService!
      .clearStackAndShow(Routes.welcomeView, arguments: arguments);

  static Future<dynamic>? home({dynamic arguments}) => _navigationService!
      .clearStackAndShow(Routes.homeView, arguments: arguments);

  ///////////////////////////NAVIGATE_TO/////////////////////////////////////////

  static Future<dynamic>? navigateToRegister({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.registerView, arguments: arguments);

  static Future<dynamic>? navigateToLogin({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.loginView, arguments: arguments);

  static Future<dynamic>? navigateToProfile({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.profileView, arguments: arguments);

  static Future<dynamic>? navigateToEmailConfirmation({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.emailConfrimationView, arguments: arguments);

  //home view navigations:
  static Future<dynamic>? navigateToVehicleRegistration({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.vehicleRegistrationView, arguments: arguments);

  //Vehicle Registration Navigations:
  static Future<dynamic>? navigateToVehicleDetail(
          {required VehicleRegistrationAction action, Vehicle? vehicle}) =>
      _navigationService!.navigateTo(
        Routes.vehicleDetailView,
        arguments: VehicleDetailViewArguments(action: action, vehicle: vehicle),
      );

  static Future<dynamic>? navigateToAccessoryDetail(
          {required VehicleRegistrationAction action}) =>
      _navigationService!.navigateTo(
        Routes.accessoryDetailView,
        arguments: AccessoryDetailViewArguments(action: action),
      );

  static Future<dynamic>? navigateToOperationalCostDetail(
          {required VehicleRegistrationAction action}) =>
      _navigationService!.navigateTo(
        Routes.operationalCostDetailView,
        arguments: OperationalCostDetailViewArguments(action: action),
      );

  //TO GO BACK
  static bool back({dynamic arguments}) => _navigationService!.back();
}
