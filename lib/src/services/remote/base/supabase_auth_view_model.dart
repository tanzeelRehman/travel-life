import 'package:stacked/stacked.dart';
import 'package:starter_app/src/configs/app_setup.locator.dart';
import 'package:starter_app/src/services/remote/supabase_auth_service.dart';

mixin SupabaseAuthViewModel on ReactiveViewModel {
  SupabaseAuthService _authService = locator<SupabaseAuthService>();

  SupabaseAuthService get supabaseAuthService => _authService;

  @override
  List<ListenableServiceMixin> get listenableServices =>
      super.listenableServices + [_authService];
}
