import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';
import 'package:starter_app/src/services/remote/supabase_auth_service.dart';

class EmailConfrimationViewModel extends ReactiveViewModel
    with SupabaseAuthViewModel {
  init() {}

  TextEditingController pinController = TextEditingController();

  onVerify() async {
    // if (pinController.text.length == 6) {
    //   setBusy(true);
    //   try {
    //     final res = await supabaseAuthService.verifyOTP(pinController.text);

    //     if (res == null) {
    //       Constants.customWarningSnack('Something went wrong');
    //       setBusy(false);

    //       return;
    //     }

    //     Constants.customSuccessSnack(
    //       'OTP verified successfully, Welcome ${supabaseAuthService.user?.firstname}!',
    //     );
    //     setBusy(false);

    //     // return;
    //     NavService.home();
    //   } on AuthExcepection catch (e) {
    //     print(e.message);
    //     setBusy(false);

    //     Constants.customWarningSnack(e.message);
    //   } catch (e) {
    //     print(e);
    //     setBusy(false);
    //     Constants.customWarningSnack(e.toString());
    //   }
    // } else {
    //   return;
    // }
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }
}
