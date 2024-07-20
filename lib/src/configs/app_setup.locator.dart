// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/local/auth_service.dart';
import '../services/local/connectivity_service.dart';
import '../services/local/data_service.dart';
import '../services/local/keyboard_service.dart';
import '../services/remote/api_service.dart';
import '../services/remote/database_service.dart';
import '../services/remote/ors/ors_service.dart';
import '../services/remote/supabase_auth_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerSingleton(ConnectivityService());
  locator.registerLazySingleton(() => SupabaseAuthService());
  locator.registerLazySingleton(() => KeyboardService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => DatabaseService());
  locator.registerLazySingleton(() => DataService());
  locator.registerLazySingleton(() => OrsService());
}
