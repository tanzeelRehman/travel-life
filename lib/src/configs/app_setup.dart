import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:starter_app/src/services/local/auth_service.dart';
import 'package:starter_app/src/services/local/connectivity_service.dart';
import 'package:starter_app/src/services/local/data_service.dart';
import 'package:starter_app/src/services/local/keyboard_service.dart';
import 'package:starter_app/src/services/remote/api_service.dart';
import 'package:starter_app/src/services/remote/database_service.dart';
import 'package:starter_app/src/services/remote/ors/ors_service.dart';
import 'package:starter_app/src/services/remote/supabase_auth_service.dart';
import 'package:starter_app/src/views/email_confirmation/email_confirmation_view.dart';
import 'package:starter_app/src/views/events/event_create/event_create_view.dart';
import 'package:starter_app/src/views/events/event_detail/event_detail_view.dart';
import 'package:starter_app/src/views/events/events_main/events_main_view.dart';
import 'package:starter_app/src/views/groups/group_activities/group_activities_view.dart';
import 'package:starter_app/src/views/groups/add_members/add_member_view.dart';
import 'package:starter_app/src/views/groups/all_members/all_members_view.dart';
import 'package:starter_app/src/views/groups/group_create/group_create_view.dart';
import 'package:starter_app/src/views/groups/group_home/group_home_view.dart';
import 'package:starter_app/src/views/groups/group_join_requests/group_join_requests_view.dart';
import 'package:starter_app/src/views/groups/group_join/group_join_view.dart';
import 'package:starter_app/src/views/groups/group_member_profile/group_member_profile_view.dart';
import 'package:starter_app/src/views/groups/groups_lists/groups_lists_view.dart';
import 'package:starter_app/src/views/groups/groups_main/groups_main_view.dart';
import 'package:starter_app/src/views/groups/invite_middle_screen/invite_middle_screen_view.dart';
import 'package:starter_app/src/views/groups/my_groups/my_groups_view.dart';
import 'package:starter_app/src/views/home/home_view.dart';
import 'package:starter_app/src/views/login/login_view.dart';
import 'package:starter_app/src/views/profile/profile_view.dart';
import 'package:starter_app/src/views/register/register_view.dart';
import 'package:starter_app/src/views/splash/splash_view.dart';
import 'package:starter_app/src/views/vehicle_registration/accessory_detail/accessory_detail_view.dart';
import 'package:starter_app/src/views/vehicle_registration/operational_cost_detail/operational_cost_detail_view.dart';
import 'package:starter_app/src/views/vehicle_registration/vehicle_detail/vehicle_detail_view.dart';
import 'package:starter_app/src/views/vehicle_registration/vehicle_registration_view.dart';
import 'package:starter_app/src/views/welcome/welcome_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: WelcomeView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: EmailConfrimationView), //not used for now.
    MaterialRoute(page: VehicleRegistrationView),
    //Vehicle Regsitration Detail Pages
    MaterialRoute(page: VehicleDetailView),
    MaterialRoute(page: OperationalCostDetailView),
    MaterialRoute(page: AccessoryDetailView),
    //! Groups Pages
    MaterialRoute(page: GroupsMainView),
    MaterialRoute(
      page: GroupsListsView,
    ),
    MaterialRoute(page: MyGroupsView),
    MaterialRoute(page: GroupJoinView),
    MaterialRoute(page: GroupJoinRequestsView),
    MaterialRoute(page: GroupHomeView),
    MaterialRoute(page: GroupMemberProfileView),
    MaterialRoute(page: GroupCreateView),
    MaterialRoute(page: AddMemberView),
    MaterialRoute(page: AllMembersView),
    MaterialRoute(page: InviteMiddleScreenView),
    MaterialRoute(page: GroupActivitiesView),
    MaterialRoute(page: EventCreateView),
    MaterialRoute(page: EventsMainView),
    MaterialRoute(page: EventDetailView),
  ],
  dependencies: [
    // Lazy singletons
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    Singleton(classType: ConnectivityService), // changed to singleton
    LazySingleton(classType: SupabaseAuthService),
    LazySingleton(classType: KeyboardService),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: DatabaseService),
    LazySingleton(classType: DataService),
    LazySingleton(classType: OrsService),
  ],
)
class AppSetup {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
