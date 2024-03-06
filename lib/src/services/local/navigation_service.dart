import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:starter_app/src/configs/app_setup.locator.dart';
import 'package:starter_app/src/configs/app_setup.router.dart';

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

  //NAVIGATE_TO

  static Future<dynamic>? navigateToRegister({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.registerView, arguments: arguments);

  static Future<dynamic>? navigateToLogin({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.loginView, arguments: arguments);

  //TO GO BACK
  static bool back({dynamic arguments}) => _navigationService!.back();
}
