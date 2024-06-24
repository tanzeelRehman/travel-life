// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as _i28;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i41;
import 'package:starter_app/src/base/enums/event_action.dart' as _i39;
import 'package:starter_app/src/base/enums/group_action.dart' as _i38;
import 'package:starter_app/src/base/enums/group_join.dart' as _i34;
import 'package:starter_app/src/base/enums/group_type.dart' as _i33;
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart'
    as _i29;
import 'package:starter_app/src/models/accessory.dart' as _i32;
import 'package:starter_app/src/models/event.dart' as _i40;
import 'package:starter_app/src/models/group.dart' as _i35;
import 'package:starter_app/src/models/invited_group.dart' as _i36;
import 'package:starter_app/src/models/operating_cost.dart' as _i31;
import 'package:starter_app/src/models/see_all_members_user.dart' as _i37;
import 'package:starter_app/src/models/vehicle.dart' as _i30;
import 'package:starter_app/src/views/email_confirmation/email_confirmation_view.dart'
    as _i8;
import 'package:starter_app/src/views/events/event_create/event_create_view.dart'
    as _i25;
import 'package:starter_app/src/views/events/event_detail/event_detail_view.dart'
    as _i27;
import 'package:starter_app/src/views/events/events_main/events_main_view.dart'
    as _i26;
import 'package:starter_app/src/views/groups/add_members/add_member_view.dart'
    as _i21;
import 'package:starter_app/src/views/groups/all_members/all_members_view.dart'
    as _i22;
import 'package:starter_app/src/views/groups/group_activities/group_activities_view.dart'
    as _i24;
import 'package:starter_app/src/views/groups/group_create/group_create_view.dart'
    as _i20;
import 'package:starter_app/src/views/groups/group_home/group_home_view.dart'
    as _i18;
import 'package:starter_app/src/views/groups/group_join/group_join_view.dart'
    as _i16;
import 'package:starter_app/src/views/groups/group_join_requests/group_join_requests_view.dart'
    as _i17;
import 'package:starter_app/src/views/groups/group_member_profile/group_member_profile_view.dart'
    as _i19;
import 'package:starter_app/src/views/groups/groups_lists/groups_lists_view.dart'
    as _i14;
import 'package:starter_app/src/views/groups/groups_main/groups_main_view.dart'
    as _i13;
import 'package:starter_app/src/views/groups/invite_middle_screen/invite_middle_screen_view.dart'
    as _i23;
import 'package:starter_app/src/views/groups/my_groups/my_groups_view.dart'
    as _i15;
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

  static const inviteMiddleScreenView = '/invite-middle-screen-view';

  static const groupActivitiesView = '/group-activities-view';

  static const eventCreateView = '/event-create-view';

  static const eventsMainView = '/events-main-view';

  static const eventDetailView = '/event-detail-view';

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
    inviteMiddleScreenView,
    groupActivitiesView,
    eventCreateView,
    eventsMainView,
    eventDetailView,
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
    _i1.RouteDef(
      Routes.inviteMiddleScreenView,
      page: _i23.InviteMiddleScreenView,
    ),
    _i1.RouteDef(
      Routes.groupActivitiesView,
      page: _i24.GroupActivitiesView,
    ),
    _i1.RouteDef(
      Routes.eventCreateView,
      page: _i25.EventCreateView,
    ),
    _i1.RouteDef(
      Routes.eventsMainView,
      page: _i26.EventsMainView,
    ),
    _i1.RouteDef(
      Routes.eventDetailView,
      page: _i27.EventDetailView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.SplashView(),
        settings: data,
      );
    },
    _i3.WelcomeView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.WelcomeView(),
        settings: data,
      );
    },
    _i4.RegisterView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.RegisterView(),
        settings: data,
      );
    },
    _i5.LoginView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.LoginView(),
        settings: data,
      );
    },
    _i6.HomeView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.HomeView(),
        settings: data,
      );
    },
    _i7.ProfileView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.ProfileView(),
        settings: data,
      );
    },
    _i8.EmailConfrimationView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.EmailConfrimationView(),
        settings: data,
      );
    },
    _i9.VehicleRegistrationView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.VehicleRegistrationView(),
        settings: data,
      );
    },
    _i10.VehicleDetailView: (data) {
      final args = data.getArgs<VehicleDetailViewArguments>(nullOk: false);
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i10.VehicleDetailView(action: args.action, vehicle: args.vehicle),
        settings: data,
      );
    },
    _i11.OperationalCostDetailView: (data) {
      final args =
          data.getArgs<OperationalCostDetailViewArguments>(nullOk: false);
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.OperationalCostDetailView(
            action: args.action,
            operatingCost: args.operatingCost,
            vehicle: args.vehicle),
        settings: data,
      );
    },
    _i12.AccessoryDetailView: (data) {
      final args = data.getArgs<AccessoryDetailViewArguments>(nullOk: false);
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.AccessoryDetailView(
            action: args.action,
            accessory: args.accessory,
            vehicle: args.vehicle),
        settings: data,
      );
    },
    _i13.GroupsMainView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.GroupsMainView(),
        settings: data,
      );
    },
    _i14.GroupsListsView: (data) {
      final args = data.getArgs<GroupsListsViewArguments>(nullOk: false);
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i14.GroupsListsView(args.groupType),
        settings: data,
      );
    },
    _i15.MyGroupsView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i15.MyGroupsView(),
        settings: data,
      );
    },
    _i16.GroupJoinView: (data) {
      final args = data.getArgs<GroupJoinViewArguments>(nullOk: false);
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i16.GroupJoinView(args.groupJoin, args.group, args.invitedGroup),
        settings: data,
      );
    },
    _i17.GroupJoinRequestsView: (data) {
      final args = data.getArgs<GroupJoinRequestsViewArguments>(nullOk: false);
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i17.GroupJoinRequestsView(group: args.group),
        settings: data,
      );
    },
    _i18.GroupHomeView: (data) {
      final args = data.getArgs<GroupHomeViewArguments>(nullOk: false);
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i18.GroupHomeView(group: args.group),
        settings: data,
      );
    },
    _i19.GroupMemberProfileView: (data) {
      final args = data.getArgs<GroupMemberProfileViewArguments>(nullOk: false);
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i19.GroupMemberProfileView(
            key: args.key,
            member: args.member,
            isGroupAdmin: args.isGroupAdmin),
        settings: data,
      );
    },
    _i20.GroupCreateView: (data) {
      final args = data.getArgs<GroupCreateViewArguments>(nullOk: false);
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i20.GroupCreateView(action: args.action, group: args.group),
        settings: data,
      );
    },
    _i21.AddMemberView: (data) {
      final args = data.getArgs<AddMemberViewArguments>(nullOk: false);
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i21.AddMemberView(group: args.group),
        settings: data,
      );
    },
    _i22.AllMembersView: (data) {
      final args = data.getArgs<AllMembersViewArguments>(nullOk: false);
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i22.AllMembersView(group: args.group),
        settings: data,
      );
    },
    _i23.InviteMiddleScreenView: (data) {
      final args = data.getArgs<InviteMiddleScreenViewArguments>(nullOk: false);
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i23.InviteMiddleScreenView(group: args.group),
        settings: data,
      );
    },
    _i24.GroupActivitiesView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i24.GroupActivitiesView(),
        settings: data,
      );
    },
    _i25.EventCreateView: (data) {
      final args = data.getArgs<EventCreateViewArguments>(nullOk: false);
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i25.EventCreateView(action: args.action, event: args.event),
        settings: data,
      );
    },
    _i26.EventsMainView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i26.EventsMainView(),
        settings: data,
      );
    },
    _i27.EventDetailView: (data) {
      final args = data.getArgs<EventDetailViewArguments>(nullOk: false);
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i27.EventDetailView(event: args.event),
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

  final _i29.VehicleRegistrationAction action;

  final _i30.Vehicle? vehicle;

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

  final _i29.VehicleRegistrationAction action;

  final _i31.OperatingCost? operatingCost;

  final _i30.Vehicle? vehicle;

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

  final _i29.VehicleRegistrationAction action;

  final _i32.Accessory? accessory;

  final _i30.Vehicle? vehicle;

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

class GroupsListsViewArguments {
  const GroupsListsViewArguments({required this.groupType});

  final _i33.GroupType groupType;

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
    required this.group,
    required this.invitedGroup,
  });

  final _i34.GroupJoin groupJoin;

  final _i35.Group group;

  final _i36.InvitedGroup? invitedGroup;

  @override
  String toString() {
    return '{"groupJoin": "$groupJoin", "group": "$group", "invitedGroup": "$invitedGroup"}';
  }

  @override
  bool operator ==(covariant GroupJoinViewArguments other) {
    if (identical(this, other)) return true;
    return other.groupJoin == groupJoin &&
        other.group == group &&
        other.invitedGroup == invitedGroup;
  }

  @override
  int get hashCode {
    return groupJoin.hashCode ^ group.hashCode ^ invitedGroup.hashCode;
  }
}

class GroupJoinRequestsViewArguments {
  const GroupJoinRequestsViewArguments({required this.group});

  final _i35.Group group;

  @override
  String toString() {
    return '{"group": "$group"}';
  }

  @override
  bool operator ==(covariant GroupJoinRequestsViewArguments other) {
    if (identical(this, other)) return true;
    return other.group == group;
  }

  @override
  int get hashCode {
    return group.hashCode;
  }
}

class GroupHomeViewArguments {
  const GroupHomeViewArguments({required this.group});

  final _i35.Group group;

  @override
  String toString() {
    return '{"group": "$group"}';
  }

  @override
  bool operator ==(covariant GroupHomeViewArguments other) {
    if (identical(this, other)) return true;
    return other.group == group;
  }

  @override
  int get hashCode {
    return group.hashCode;
  }
}

class GroupMemberProfileViewArguments {
  const GroupMemberProfileViewArguments({
    this.key,
    required this.member,
    required this.isGroupAdmin,
  });

  final _i28.Key? key;

  final _i37.SeeAllMembersUser member;

  final bool isGroupAdmin;

  @override
  String toString() {
    return '{"key": "$key", "member": "$member", "isGroupAdmin": "$isGroupAdmin"}';
  }

  @override
  bool operator ==(covariant GroupMemberProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.member == member &&
        other.isGroupAdmin == isGroupAdmin;
  }

  @override
  int get hashCode {
    return key.hashCode ^ member.hashCode ^ isGroupAdmin.hashCode;
  }
}

class GroupCreateViewArguments {
  const GroupCreateViewArguments({
    required this.action,
    required this.group,
  });

  final _i38.GroupAction action;

  final _i35.Group? group;

  @override
  String toString() {
    return '{"action": "$action", "group": "$group"}';
  }

  @override
  bool operator ==(covariant GroupCreateViewArguments other) {
    if (identical(this, other)) return true;
    return other.action == action && other.group == group;
  }

  @override
  int get hashCode {
    return action.hashCode ^ group.hashCode;
  }
}

class AddMemberViewArguments {
  const AddMemberViewArguments({required this.group});

  final _i35.Group group;

  @override
  String toString() {
    return '{"group": "$group"}';
  }

  @override
  bool operator ==(covariant AddMemberViewArguments other) {
    if (identical(this, other)) return true;
    return other.group == group;
  }

  @override
  int get hashCode {
    return group.hashCode;
  }
}

class AllMembersViewArguments {
  const AllMembersViewArguments({required this.group});

  final _i35.Group group;

  @override
  String toString() {
    return '{"group": "$group"}';
  }

  @override
  bool operator ==(covariant AllMembersViewArguments other) {
    if (identical(this, other)) return true;
    return other.group == group;
  }

  @override
  int get hashCode {
    return group.hashCode;
  }
}

class InviteMiddleScreenViewArguments {
  const InviteMiddleScreenViewArguments({required this.group});

  final _i35.Group group;

  @override
  String toString() {
    return '{"group": "$group"}';
  }

  @override
  bool operator ==(covariant InviteMiddleScreenViewArguments other) {
    if (identical(this, other)) return true;
    return other.group == group;
  }

  @override
  int get hashCode {
    return group.hashCode;
  }
}

class EventCreateViewArguments {
  const EventCreateViewArguments({
    required this.action,
    required this.event,
  });

  final _i39.EventAction action;

  final _i40.Event? event;

  @override
  String toString() {
    return '{"action": "$action", "event": "$event"}';
  }

  @override
  bool operator ==(covariant EventCreateViewArguments other) {
    if (identical(this, other)) return true;
    return other.action == action && other.event == event;
  }

  @override
  int get hashCode {
    return action.hashCode ^ event.hashCode;
  }
}

class EventDetailViewArguments {
  const EventDetailViewArguments({required this.event});

  final _i40.Event event;

  @override
  String toString() {
    return '{"event": "$event"}';
  }

  @override
  bool operator ==(covariant EventDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.event == event;
  }

  @override
  int get hashCode {
    return event.hashCode;
  }
}

extension NavigatorStateExtension on _i41.NavigationService {
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
    required _i29.VehicleRegistrationAction action,
    required _i30.Vehicle? vehicle,
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
    required _i29.VehicleRegistrationAction action,
    _i31.OperatingCost? operatingCost,
    _i30.Vehicle? vehicle,
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
    required _i29.VehicleRegistrationAction action,
    _i32.Accessory? accessory,
    _i30.Vehicle? vehicle,
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
    required _i33.GroupType groupType,
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
    required _i34.GroupJoin groupJoin,
    required _i35.Group group,
    required _i36.InvitedGroup? invitedGroup,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.groupJoinView,
        arguments: GroupJoinViewArguments(
            groupJoin: groupJoin, group: group, invitedGroup: invitedGroup),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGroupJoinRequestsView({
    required _i35.Group group,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.groupJoinRequestsView,
        arguments: GroupJoinRequestsViewArguments(group: group),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGroupHomeView({
    required _i35.Group group,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.groupHomeView,
        arguments: GroupHomeViewArguments(group: group),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGroupMemberProfileView({
    _i28.Key? key,
    required _i37.SeeAllMembersUser member,
    required bool isGroupAdmin,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.groupMemberProfileView,
        arguments: GroupMemberProfileViewArguments(
            key: key, member: member, isGroupAdmin: isGroupAdmin),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGroupCreateView({
    required _i38.GroupAction action,
    required _i35.Group? group,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.groupCreateView,
        arguments: GroupCreateViewArguments(action: action, group: group),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddMemberView({
    required _i35.Group group,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addMemberView,
        arguments: AddMemberViewArguments(group: group),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAllMembersView({
    required _i35.Group group,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.allMembersView,
        arguments: AllMembersViewArguments(group: group),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToInviteMiddleScreenView({
    required _i35.Group group,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.inviteMiddleScreenView,
        arguments: InviteMiddleScreenViewArguments(group: group),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGroupActivitiesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.groupActivitiesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEventCreateView({
    required _i39.EventAction action,
    required _i40.Event? event,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.eventCreateView,
        arguments: EventCreateViewArguments(action: action, event: event),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEventsMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.eventsMainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEventDetailView({
    required _i40.Event event,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.eventDetailView,
        arguments: EventDetailViewArguments(event: event),
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
    required _i29.VehicleRegistrationAction action,
    required _i30.Vehicle? vehicle,
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
    required _i29.VehicleRegistrationAction action,
    _i31.OperatingCost? operatingCost,
    _i30.Vehicle? vehicle,
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
    required _i29.VehicleRegistrationAction action,
    _i32.Accessory? accessory,
    _i30.Vehicle? vehicle,
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
    required _i33.GroupType groupType,
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
    required _i34.GroupJoin groupJoin,
    required _i35.Group group,
    required _i36.InvitedGroup? invitedGroup,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.groupJoinView,
        arguments: GroupJoinViewArguments(
            groupJoin: groupJoin, group: group, invitedGroup: invitedGroup),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithGroupJoinRequestsView({
    required _i35.Group group,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.groupJoinRequestsView,
        arguments: GroupJoinRequestsViewArguments(group: group),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithGroupHomeView({
    required _i35.Group group,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.groupHomeView,
        arguments: GroupHomeViewArguments(group: group),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithGroupMemberProfileView({
    _i28.Key? key,
    required _i37.SeeAllMembersUser member,
    required bool isGroupAdmin,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.groupMemberProfileView,
        arguments: GroupMemberProfileViewArguments(
            key: key, member: member, isGroupAdmin: isGroupAdmin),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithGroupCreateView({
    required _i38.GroupAction action,
    required _i35.Group? group,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.groupCreateView,
        arguments: GroupCreateViewArguments(action: action, group: group),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddMemberView({
    required _i35.Group group,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addMemberView,
        arguments: AddMemberViewArguments(group: group),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAllMembersView({
    required _i35.Group group,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.allMembersView,
        arguments: AllMembersViewArguments(group: group),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithInviteMiddleScreenView({
    required _i35.Group group,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.inviteMiddleScreenView,
        arguments: InviteMiddleScreenViewArguments(group: group),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithGroupActivitiesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.groupActivitiesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEventCreateView({
    required _i39.EventAction action,
    required _i40.Event? event,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.eventCreateView,
        arguments: EventCreateViewArguments(action: action, event: event),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEventsMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.eventsMainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEventDetailView({
    required _i40.Event event,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.eventDetailView,
        arguments: EventDetailViewArguments(event: event),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
