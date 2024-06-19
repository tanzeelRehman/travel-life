import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeViewModel extends ReactiveViewModel with SupabaseAuthViewModel {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final String leonEmail = 'leonjmcnamara@gmail.com';
  init() {
    subjectController.text =
        'Feedback from ${supabaseAuthService.user?.firstname}';
  }

  int selectedDrawerIndex = -1;
  int selectedMenu = -1;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  onClickProfile() {
    NavService.navigateToProfile();
  }

  onClickTripPlanner() {
    NavService.navigateToEventsMainScreen();
  }

  onClickVehicleRegistration() {
    NavService.navigateToVehicleRegistration();
  }

  onClickGroups() {
    print('tap');
    NavService.navigateToMyGroupsScreen();
  }

  onClickMoneyManager() {}
  onClickChats() {}
  onClickEventMoneyManager() {}

  onClickLogout() async {
    await supabaseAuthService.logout();
    NavService.login();
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  onClickSendFeedback() {
    _sendEmail(
      leonEmail,
      subjectController.text,
      messageController.text,
    );
    messageController.clear();
    subjectController.text =
        'Feedback from ${supabaseAuthService.user?.firstname}';
  }

  _sendEmail(String email, String subject, String message) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': subject,
        'body': messageController.text,
      }),
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      Constants.customWarningSnack('could not send email');
    }
  }
}
