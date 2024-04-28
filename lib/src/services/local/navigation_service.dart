import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:starter_app/src/base/enums/group_action.dart';
import 'package:starter_app/src/base/enums/group_join.dart';
import 'package:starter_app/src/base/enums/group_type.dart';
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart';
import 'package:starter_app/src/configs/app_setup.locator.dart';
import 'package:starter_app/src/configs/app_setup.router.dart';
import 'package:starter_app/src/models/accessory.dart';
import 'package:starter_app/src/models/operating_cost.dart';
import 'package:starter_app/src/models/vehicle.dart';
import 'package:starter_app/src/views/groups/models/group_create_view_model.dart';

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
        arguments: VehicleDetailViewArguments(
          action: action,
          vehicle: vehicle,
        ),
      );

  static Future<dynamic>? navigateToAccessoryDetail(
          {required VehicleRegistrationAction action, Accessory? accessory}) =>
      _navigationService!.navigateTo(
        Routes.accessoryDetailView,
        arguments: AccessoryDetailViewArguments(
          action: action,
          accessory: accessory,
        ),
      );

  static Future<dynamic>? navigateToOperationalCostDetail(
          {required VehicleRegistrationAction action,
          OperatingCost? operatingCost}) =>
      _navigationService!.navigateTo(
        Routes.operationalCostDetailView,
        arguments: OperationalCostDetailViewArguments(
          action: action,
          operatingCost: operatingCost,
        ),
      );
  //Groups Navigations:
  static Future<dynamic>? navigateToGroupsMainScreen({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.groupsMainView, arguments: arguments);

  static Future<dynamic>? navigateToGroupsListsScreen(
          {required GroupType groupType}) =>
      _navigationService!.navigateTo(Routes.groupsListsView,
          arguments: GroupsListsViewArguments(groupType: groupType));

  static Future<dynamic>? navigateToMyGroupsScreen({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.myGroupsView, arguments: arguments);

  static Future<dynamic>? navigateToGroupJoinScreen(
          {required GroupJoin groupJoin, required String groupName}) =>
      _navigationService!.navigateTo(Routes.groupJoinView,
          arguments: GroupJoinViewArguments(
              groupJoin: groupJoin, groupName: groupName));

  static Future<dynamic>? navigateToGroupJoinRequestsScreen(
          {dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.groupJoinRequestsView, arguments: arguments);

  static Future<dynamic>? navigateToGroupHomeScreen({
    required String groupName,
  }) =>
      _navigationService!.navigateTo(Routes.groupHomeView,
          arguments: GroupHomeViewArguments(groupName: groupName));

  static Future<dynamic>? navigateToGroupMembersProfileScreen(
          {dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.groupMemberProfileView, arguments: arguments);

  static Future<dynamic>? navigateToAddMemberScreen({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.addMemberView, arguments: arguments);

  static Future<dynamic>? navigateToGroupCreateScreen({
    required GroupAction groupAction,
  }) =>
      _navigationService!.navigateTo(Routes.groupCreateView,
          arguments: GroupCreateViewArguments(action: groupAction));
  //TO GO BACK
  static bool back({dynamic arguments}) => _navigationService!.back();
}
