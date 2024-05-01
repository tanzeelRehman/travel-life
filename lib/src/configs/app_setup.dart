import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:starter_app/src/services/local/auth_service.dart';
import 'package:starter_app/src/services/local/connectivity_service.dart';
import 'package:starter_app/src/services/local/data_service.dart';
import 'package:starter_app/src/services/local/keyboard_service.dart';
import 'package:starter_app/src/services/remote/api_service.dart';
import 'package:starter_app/src/services/remote/database_service.dart';
import 'package:starter_app/src/services/remote/supabase_auth_service.dart';
import 'package:starter_app/src/views/email_confirmation/email_confirmation_view.dart';
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
  ],
)
class AppSetup {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
