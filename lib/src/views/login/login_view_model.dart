import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/services/local/base/auth_view_model.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/api_view_model.dart';

class LoginViewModel extends ReactiveViewModel
    with ApiViewModel, AuthViewModel {
  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  final TextEditingController _numberController = TextEditingController();
  TextEditingController get numberController => _numberController;

  final formKey = GlobalKey<FormState>();

  init() {}

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _numberController.dispose();

    super.dispose();
  }

  onLogin() async {
    // if ((formKey.currentState?.validate() ?? false)) {
    //   setBusy(true);
    //   var response = await apiService.userLogin(
    //     _emailController.text,
    //     _passwordController.text,
    //   );
    //   if (response == null) {
    //     setBusy(false);
    //     return;
    //   }
    //   response.when(success: (user) async {
    //     if (user.user?.id != null) {
    //       authService.user = user;
    //       Constants.customSuccessSnack('Welcome back!');
    //     }
    //     NavService.home();
    //     setBusy(false);
    //   }, failure: (error) {
    //     setBusy(false);
    //     return print(error);
    //   });
    // }
    // NavService.home();
  }

  onClickRegister() async {
    NavService.navigateToRegister();
  }

  onClickForgetPassword() {
    // NavService.forgetPassword();
  }
}
