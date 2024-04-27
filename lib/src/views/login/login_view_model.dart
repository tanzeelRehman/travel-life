import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/models/app_user.dart';
import 'package:starter_app/src/services/local/base/connectivity_view_model.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';
import 'package:starter_app/src/services/remote/supabase_auth_service.dart';

class LoginViewModel extends ReactiveViewModel
    with SupabaseAuthViewModel, ConnectivityViewModel {
  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  final formKey = GlobalKey<FormState>();

  init() {}

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  onLogin() async {
    if (formKey.currentState!.validate()) {
      setBusy(true);
      if (connectivityService.isInternetConnected == false) {
        print('hello im here');
        Constants.customErrorSnack('No internet connection');
        setBusy(false);
        return;
      }
      try {
        AppUser? user = await supabaseAuthService.login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        if (user != null && supabaseAuthService.userLoggedIn) {
          Constants.customSuccessSnack('Welcome back, ${user.firstname}!');
          setBusy(false);
          NavService.home();
        }
        setBusy(false);
      } on AuthExcepection catch (e) {
        setBusy(false);
        print(e);
        Constants.customErrorSnack(e.message);
      } on CustomNoInternetException catch (e) {
        print(e.message);
        Constants.customErrorSnack(e.message);
        setBusy(false);
      } catch (e) {
        setBusy(false);
        print(e);
        Constants.customErrorSnack(e.toString());
      }
    }
  }

  onClickRegister() async {
    NavService.navigateToRegister();
  }

  onClickForgetPassword() {}
}
