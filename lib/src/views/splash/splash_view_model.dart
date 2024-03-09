import 'package:stacked/stacked.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class SplashViewModel extends ReactiveViewModel with SupabaseAuthViewModel {
  init() {
    Future.delayed(
      Duration(seconds: 2),
      () {
        print(supabaseAuthService.userLoggedIn);
        if (supabaseAuthService.userLoggedIn) {
          print('User Logged in');
          NavService.home();
        } else {
          NavService.welcome();
        }
      },
    );
  }
}
