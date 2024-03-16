import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/services/local/base/connectivity_view_model.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';
import 'package:starter_app/src/services/remote/supabase_auth_service.dart';

class RegisterViewModel extends ReactiveViewModel
    with SupabaseAuthViewModel, ConnectivityViewModel {
  init() {}

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController numberController = TextEditingController();

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  onRegister() async {
    if (formKey.currentState!.validate()) {
      setBusy(true);
      try {
        if (!connectivityService.isInternetConnected) {
          Constants.customErrorSnack('No internet connection');
          setBusy(false);
          return;
        }

        final response = await supabaseAuthService.register(
          emailController.text.trim(),
          passwordController.text.trim(),
          firstName: firstNameController.text.trim(),
          phone: numberController.text.trim(),
          lastName: lastNameController.text.trim(),
        );

        if (response == null) {
          Constants.customWarningSnack('Error registering the user');
          setBusy(false);

          return;
        }
        Constants.customSuccessSnack('Welcome ${response.firstname}');

        setBusy(false);

        NavService.home();
      } on AuthExcepection catch (e) {
        print(e.message);
        Constants.customErrorSnack(e.message);

        setBusy(false);
      } on CustomNoInternetException catch (e) {
        print(e.message);
        Constants.customErrorSnack(e.message);

        setBusy(false);
      } catch (e) {
        print(e);
        setBusy(false);

        Constants.customErrorSnack(e.toString());
        return;
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    numberController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }
}
