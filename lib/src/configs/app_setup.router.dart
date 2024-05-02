// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i13;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i18;
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart'
    as _i14;
import 'package:starter_app/src/models/accessory.dart' as _i17;
import 'package:starter_app/src/models/operating_cost.dart' as _i16;
import 'package:starter_app/src/models/vehicle.dart' as _i15;
import 'package:starter_app/src/views/email_confirmation/email_confirmation_view.dart'
    as _i8;
import 'package:starter_app/src/views/home/home_view.dart' as _i6;
import 'package:starter_app/src/views/login/login_view.dart' as _i5;
import 'package:starter_app/src/views/profile/profile_view.dart' as _i7;
import 'package:starter_app/src/views/register/register_view.dart' as _i4;
import 'package:starter_app/src/views/splash/splash_view.dart' as _i2;
import 'package:starter_app/src/views/vehicle_registration/accessory_detail/accessory_detail_view.dart'
    as _i12;
import 'package:starter_app/src/views/vehicle_registration/operational_cost_detail/operational_cost_detail_view.dart'
    as _i11;
import 'package:starter_app/src/views/vehicle_registration/vehicle_detail/vehicle_detail_view.dart'
    as _i10;
import 'package:starter_app/src/views/vehicle_registration/vehicle_registration_view.dart'
    as _i9;
import 'package:starter_app/src/views/welcome/welcome_view.dart' as _i3;

class Routes {
  static const splashView = '/';

  static const welcomeView = '/welcome-view';

  static const registerView = '/register-view';

  static const loginView = '/login-view';

  static const homeView = '/home-view';

  static const profileView = '/profile-view';

  static const emailConfrimationView = '/email-confrimation-view';

  static const vehicleRegistrationView = '/vehicle-registration-view';

  static const vehicleDetailView = '/vehicle-detail-view';

  static const operationalCostDetailView = '/operational-cost-detail-view';

  static const accessoryDetailView = '/accessory-detail-view';

  static const all = <String>{
    splashView,
    welcomeView,
    registerView,
    loginView,
    homeView,
    profileView,
    emailConfrimationView,
    vehicleRegistrationView,
    vehicleDetailView,
    operationalCostDetailView,
    accessoryDetailView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashView,
      page: _i2.SplashView,
    ),
    _i1.RouteDef(
      Routes.welcomeView,
      page: _i3.WelcomeView,
    ),
    _i1.RouteDef(
      Routes.registerView,
      page: _i4.RegisterView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i5.LoginView,
    ),
    _i1.RouteDef(
      Routes.homeView,
      page: _i6.HomeView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i7.ProfileView,
    ),
    _i1.RouteDef(
      Routes.emailConfrimationView,
      page: _i8.EmailConfrimationView,
    ),
    _i1.RouteDef(
      Routes.vehicleRegistrationView,
      page: _i9.VehicleRegistrationView,
    ),
    _i1.RouteDef(
      Routes.vehicleDetailView,
      page: _i10.VehicleDetailView,
    ),
    _i1.RouteDef(
      Routes.operationalCostDetailView,
      page: _i11.OperationalCostDetailView,
    ),
    _i1.RouteDef(
      Routes.accessoryDetailView,
      page: _i12.AccessoryDetailView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.SplashView(),
        settings: data,
      );
    },
    _i3.WelcomeView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.WelcomeView(),
        settings: data,
      );
    },
    _i4.RegisterView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.RegisterView(),
        settings: data,
      );
    },
    _i5.LoginView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.LoginView(),
        settings: data,
      );
    },
    _i6.HomeView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.HomeView(),
        settings: data,
      );
    },
    _i7.ProfileView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.ProfileView(),
        settings: data,
      );
    },
    _i8.EmailConfrimationView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.EmailConfrimationView(),
        settings: data,
      );
    },
    _i9.VehicleRegistrationView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.VehicleRegistrationView(),
        settings: data,
      );
    },
    _i10.VehicleDetailView: (data) {
      final args = data.getArgs<VehicleDetailViewArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i10.VehicleDetailView(action: args.action, vehicle: args.vehicle),
        settings: data,
      );
    },
    _i11.OperationalCostDetailView: (data) {
      final args =
          data.getArgs<OperationalCostDetailViewArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.OperationalCostDetailView(
            action: args.action,
            operatingCost: args.operatingCost,
            vehicle: args.vehicle),
        settings: data,
      );
    },
    _i12.AccessoryDetailView: (data) {
      final args = data.getArgs<AccessoryDetailViewArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.AccessoryDetailView(
            action: args.action,
            accessory: args.accessory,
            vehicle: args.vehicle),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class VehicleDetailViewArguments {
  const VehicleDetailViewArguments({
    required this.action,
    required this.vehicle,
  });

  final _i14.VehicleRegistrationAction action;

  final _i15.Vehicle? vehicle;

  @override
  String toString() {
    return '{"action": "$action", "vehicle": "$vehicle"}';
  }

  @override
  bool operator ==(covariant VehicleDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.action == action && other.vehicle == vehicle;
  }

  @override
  int get hashCode {
    return action.hashCode ^ vehicle.hashCode;
  }
}

class OperationalCostDetailViewArguments {
  const OperationalCostDetailViewArguments({
    required this.action,
    this.operatingCost,
    this.vehicle,
  });

  final _i14.VehicleRegistrationAction action;

  final _i16.OperatingCost? operatingCost;

  final _i15.Vehicle? vehicle;

  @override
  String toString() {
    return '{"action": "$action", "operatingCost": "$operatingCost", "vehicle": "$vehicle"}';
  }

  @override
  bool operator ==(covariant OperationalCostDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.action == action &&
        other.operatingCost == operatingCost &&
        other.vehicle == vehicle;
  }

  @override
  int get hashCode {
    return action.hashCode ^ operatingCost.hashCode ^ vehicle.hashCode;
  }
}

class AccessoryDetailViewArguments {
  const AccessoryDetailViewArguments({
    required this.action,
    this.accessory,
    this.vehicle,
  });

  final _i14.VehicleRegistrationAction action;

  final _i17.Accessory? accessory;

  final _i15.Vehicle? vehicle;

  @override
  String toString() {
    return '{"action": "$action", "accessory": "$accessory", "vehicle": "$vehicle"}';
  }

  @override
  bool operator ==(covariant AccessoryDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.action == action &&
        other.accessory == accessory &&
        other.vehicle == vehicle;
  }

  @override
  int get hashCode {
    return action.hashCode ^ accessory.hashCode ^ vehicle.hashCode;
  }
}

extension NavigatorStateExtension on _i18.NavigationService {
  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToWelcomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.welcomeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEmailConfrimationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.emailConfrimationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToVehicleRegistrationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.vehicleRegistrationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToVehicleDetailView({
    required _i14.VehicleRegistrationAction action,
    required _i15.Vehicle? vehicle,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.vehicleDetailView,
        arguments: VehicleDetailViewArguments(action: action, vehicle: vehicle),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOperationalCostDetailView({
    required _i14.VehicleRegistrationAction action,
    _i16.OperatingCost? operatingCost,
    _i15.Vehicle? vehicle,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.operationalCostDetailView,
        arguments: OperationalCostDetailViewArguments(
            action: action, operatingCost: operatingCost, vehicle: vehicle),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAccessoryDetailView({
    required _i14.VehicleRegistrationAction action,
    _i17.Accessory? accessory,
    _i15.Vehicle? vehicle,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.accessoryDetailView,
        arguments: AccessoryDetailViewArguments(
            action: action, accessory: accessory, vehicle: vehicle),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithWelcomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.welcomeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEmailConfrimationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.emailConfrimationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithVehicleRegistrationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.vehicleRegistrationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithVehicleDetailView({
    required _i14.VehicleRegistrationAction action,
    required _i15.Vehicle? vehicle,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.vehicleDetailView,
        arguments: VehicleDetailViewArguments(action: action, vehicle: vehicle),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOperationalCostDetailView({
    required _i14.VehicleRegistrationAction action,
    _i16.OperatingCost? operatingCost,
    _i15.Vehicle? vehicle,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.operationalCostDetailView,
        arguments: OperationalCostDetailViewArguments(
            action: action, operatingCost: operatingCost, vehicle: vehicle),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAccessoryDetailView({
    required _i14.VehicleRegistrationAction action,
    _i17.Accessory? accessory,
    _i15.Vehicle? vehicle,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.accessoryDetailView,
        arguments: AccessoryDetailViewArguments(
            action: action, accessory: accessory, vehicle: vehicle),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
