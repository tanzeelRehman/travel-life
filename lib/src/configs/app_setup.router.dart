// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i23;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i31;
import 'package:starter_app/src/base/enums/group_action.dart' as _i30;
import 'package:starter_app/src/base/enums/group_join.dart' as _i29;
import 'package:starter_app/src/base/enums/group_type.dart' as _i28;
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart'
    as _i24;
import 'package:starter_app/src/models/accessory.dart' as _i27;
import 'package:starter_app/src/models/operating_cost.dart' as _i26;
import 'package:starter_app/src/models/vehicle.dart' as _i25;
import 'package:starter_app/src/views/email_confirmation/email_confirmation_view.dart'
    as _i8;
import 'package:starter_app/src/views/groups/add_member_view.dart' as _i21;
import 'package:starter_app/src/views/groups/all_members_view.dart' as _i22;
import 'package:starter_app/src/views/groups/group_create_view.dart' as _i20;
import 'package:starter_app/src/views/groups/group_home_view.dart' as _i18;
import 'package:starter_app/src/views/groups/group_join_requests_view.dart'
    as _i17;
import 'package:starter_app/src/views/groups/group_join_view.dart' as _i16;
import 'package:starter_app/src/views/groups/group_member_profile_view.dart'
    as _i19;
import 'package:starter_app/src/views/groups/groups_lists_view.dart' as _i14;
import 'package:starter_app/src/views/groups/groups_main_view.dart' as _i13;
import 'package:starter_app/src/views/groups/my_groups_view.dart' as _i15;
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

  static const groupsMainView = '/groups-main-view';

  static const groupsListsView = '/groups-lists-view';

  static const myGroupsView = '/my-groups-view';

  static const groupJoinView = '/group-join-view';

  static const groupJoinRequestsView = '/group-join-requests-view';

  static const groupHomeView = '/group-home-view';

  static const groupMemberProfileView = '/group-member-profile-view';

  static const groupCreateView = '/group-create-view';

  static const addMemberView = '/add-member-view';

  static const allMembersView = '/all-members-view';

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
    groupsMainView,
    groupsListsView,
    myGroupsView,
    groupJoinView,
    groupJoinRequestsView,
    groupHomeView,
    groupMemberProfileView,
    groupCreateView,
    addMemberView,
    allMembersView,
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
    _i1.RouteDef(
      Routes.groupsMainView,
      page: _i13.GroupsMainView,
    ),
    _i1.RouteDef(
      Routes.groupsListsView,
      page: _i14.GroupsListsView,
    ),
    _i1.RouteDef(
      Routes.myGroupsView,
      page: _i15.MyGroupsView,
    ),
    _i1.RouteDef(
      Routes.groupJoinView,
      page: _i16.GroupJoinView,
    ),
    _i1.RouteDef(
      Routes.groupJoinRequestsView,
      page: _i17.GroupJoinRequestsView,
    ),
    _i1.RouteDef(
      Routes.groupHomeView,
      page: _i18.GroupHomeView,
    ),
    _i1.RouteDef(
      Routes.groupMemberProfileView,
      page: _i19.GroupMemberProfileView,
    ),
    _i1.RouteDef(
      Routes.groupCreateView,
      page: _i20.GroupCreateView,
    ),
    _i1.RouteDef(
      Routes.addMemberView,
      page: _i21.AddMemberView,
    ),
    _i1.RouteDef(
      Routes.allMembersView,
      page: _i22.AllMembersView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.SplashView(),
        settings: data,
      );
    },
    _i3.WelcomeView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.WelcomeView(),
        settings: data,
      );
    },
    _i4.RegisterView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.RegisterView(),
        settings: data,
      );
    },
    _i5.LoginView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.LoginView(),
        settings: data,
      );
    },
    _i6.HomeView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.HomeView(),
        settings: data,
      );
    },
    _i7.ProfileView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.ProfileView(),
        settings: data,
      );
    },
    _i8.EmailConfrimationView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.EmailConfrimationView(),
        settings: data,
      );
    },
    _i9.VehicleRegistrationView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.VehicleRegistrationView(),
        settings: data,
      );
    },
    _i10.VehicleDetailView: (data) {
      final args = data.getArgs<VehicleDetailViewArguments>(nullOk: false);
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i10.VehicleDetailView(action: args.action, vehicle: args.vehicle),
        settings: data,
      );
    },
    _i11.OperationalCostDetailView: (data) {
      final args =
          data.getArgs<OperationalCostDetailViewArguments>(nullOk: false);
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.OperationalCostDetailView(
            action: args.action, operatingCost: args.operatingCost),
        settings: data,
      );
    },
    _i12.AccessoryDetailView: (data) {
      final args = data.getArgs<AccessoryDetailViewArguments>(nullOk: false);
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.AccessoryDetailView(
            action: args.action, accessory: args.accessory),
        settings: data,
      );
    },
    _i13.GroupsMainView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.GroupsMainView(),
        settings: data,
      );
    },
    _i14.GroupsListsView: (data) {
      final args = data.getArgs<GroupsListsViewArguments>(nullOk: false);
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i14.GroupsListsView(args.groupType),
        settings: data,
      );
    },
    _i15.MyGroupsView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i15.MyGroupsView(),
        settings: data,
      );
    },
    _i16.GroupJoinView: (data) {
      final args = data.getArgs<GroupJoinViewArguments>(nullOk: false);
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i16.GroupJoinView(args.groupJoin, args.groupName),
        settings: data,
      );
    },
    _i17.GroupJoinRequestsView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i17.GroupJoinRequestsView(),
        settings: data,
      );
    },
    _i18.GroupHomeView: (data) {
      final args = data.getArgs<GroupHomeViewArguments>(nullOk: false);
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i18.GroupHomeView(groupName: args.groupName),
        settings: data,
      );
    },
    _i19.GroupMemberProfileView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i19.GroupMemberProfileView(),
        settings: data,
      );
    },
    _i20.GroupCreateView: (data) {
      final args = data.getArgs<GroupCreateViewArguments>(nullOk: false);
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i20.GroupCreateView(action: args.action),
        settings: data,
      );
    },
    _i21.AddMemberView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i21.AddMemberView(),
        settings: data,
      );
    },
    _i22.AllMembersView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i22.AllMembersView(),
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

  final _i24.VehicleRegistrationAction action;

  final _i25.Vehicle? vehicle;

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
  });

  final _i24.VehicleRegistrationAction action;

  final _i26.OperatingCost? operatingCost;

  @override
  String toString() {
    return '{"action": "$action", "operatingCost": "$operatingCost"}';
  }

  @override
  bool operator ==(covariant OperationalCostDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.action == action && other.operatingCost == operatingCost;
  }

  @override
  int get hashCode {
    return action.hashCode ^ operatingCost.hashCode;
  }
}

class AccessoryDetailViewArguments {
  const AccessoryDetailViewArguments({
    required this.action,
    this.accessory,
  });

  final _i24.VehicleRegistrationAction action;

  final _i27.Accessory? accessory;

  @override
  String toString() {
    return '{"action": "$action", "accessory": "$accessory"}';
  }

  @override
  bool operator ==(covariant AccessoryDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.action == action && other.accessory == accessory;
  }

  @override
  int get hashCode {
    return action.hashCode ^ accessory.hashCode;
  }
}

class GroupsListsViewArguments {
  const GroupsListsViewArguments({required this.groupType});

  final _i28.GroupType groupType;

  @override
  String toString() {
    return '{"groupType": "$groupType"}';
  }

  @override
  bool operator ==(covariant GroupsListsViewArguments other) {
    if (identical(this, other)) return true;
    return other.groupType == groupType;
  }

  @override
  int get hashCode {
    return groupType.hashCode;
  }
}

class GroupJoinViewArguments {
  const GroupJoinViewArguments({
    required this.groupJoin,
    required this.groupName,
  });

  final _i29.GroupJoin groupJoin;

  final String groupName;

  @override
  String toString() {
    return '{"groupJoin": "$groupJoin", "groupName": "$groupName"}';
  }

  @override
  bool operator ==(covariant GroupJoinViewArguments other) {
    if (identical(this, other)) return true;
    return other.groupJoin == groupJoin && other.groupName == groupName;
  }

  @override
  int get hashCode {
    return groupJoin.hashCode ^ groupName.hashCode;
  }
}

class GroupHomeViewArguments {
  const GroupHomeViewArguments({required this.groupName});

  final String groupName;

  @override
  String toString() {
    return '{"groupName": "$groupName"}';
  }

  @override
  bool operator ==(covariant GroupHomeViewArguments other) {
    if (identical(this, other)) return true;
    return other.groupName == groupName;
  }

  @override
  int get hashCode {
    return groupName.hashCode;
  }
}

class GroupCreateViewArguments {
  const GroupCreateViewArguments({required this.action});

  final _i30.GroupAction action;

  @override
  String toString() {
    return '{"action": "$action"}';
  }

  @override
  bool operator ==(covariant GroupCreateViewArguments other) {
    if (identical(this, other)) return true;
    return other.action == action;
  }

  @override
  int get hashCode {
    return action.hashCode;
  }
}

extension NavigatorStateExtension on _i31.NavigationService {
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
    required _i24.VehicleRegistrationAction action,
    required _i25.Vehicle? vehicle,
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
    required _i24.VehicleRegistrationAction action,
    _i26.OperatingCost? operatingCost,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.operationalCostDetailView,
        arguments: OperationalCostDetailViewArguments(
            action: action, operatingCost: operatingCost),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAccessoryDetailView({
    required _i24.VehicleRegistrationAction action,
    _i27.Accessory? accessory,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.accessoryDetailView,
        arguments:
            AccessoryDetailViewArguments(action: action, accessory: accessory),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGroupsMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.groupsMainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGroupsListsView({
    required _i28.GroupType groupType,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.groupsListsView,
        arguments: GroupsListsViewArguments(groupType: groupType),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMyGroupsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.myGroupsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGroupJoinView({
    required _i29.GroupJoin groupJoin,
    required String groupName,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.groupJoinView,
        arguments:
            GroupJoinViewArguments(groupJoin: groupJoin, groupName: groupName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGroupJoinRequestsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.groupJoinRequestsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGroupHomeView({
    required String groupName,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.groupHomeView,
        arguments: GroupHomeViewArguments(groupName: groupName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGroupMemberProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.groupMemberProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGroupCreateView({
    required _i30.GroupAction action,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.groupCreateView,
        arguments: GroupCreateViewArguments(action: action),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddMemberView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addMemberView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAllMembersView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.allMembersView,
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
    required _i24.VehicleRegistrationAction action,
    required _i25.Vehicle? vehicle,
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
    required _i24.VehicleRegistrationAction action,
    _i26.OperatingCost? operatingCost,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.operationalCostDetailView,
        arguments: OperationalCostDetailViewArguments(
            action: action, operatingCost: operatingCost),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAccessoryDetailView({
    required _i24.VehicleRegistrationAction action,
    _i27.Accessory? accessory,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.accessoryDetailView,
        arguments:
            AccessoryDetailViewArguments(action: action, accessory: accessory),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithGroupsMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.groupsMainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithGroupsListsView({
    required _i28.GroupType groupType,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.groupsListsView,
        arguments: GroupsListsViewArguments(groupType: groupType),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMyGroupsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.myGroupsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithGroupJoinView({
    required _i29.GroupJoin groupJoin,
    required String groupName,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.groupJoinView,
        arguments:
            GroupJoinViewArguments(groupJoin: groupJoin, groupName: groupName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithGroupJoinRequestsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.groupJoinRequestsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithGroupHomeView({
    required String groupName,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.groupHomeView,
        arguments: GroupHomeViewArguments(groupName: groupName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithGroupMemberProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.groupMemberProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithGroupCreateView({
    required _i30.GroupAction action,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.groupCreateView,
        arguments: GroupCreateViewArguments(action: action),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddMemberView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addMemberView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAllMembersView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.allMembersView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
