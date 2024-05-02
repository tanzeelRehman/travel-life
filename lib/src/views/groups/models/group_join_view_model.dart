import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';

class GroupJoinViewModel extends ReactiveViewModel {
  init() {}
  TextEditingController groupDescription = TextEditingController(
      text:
          'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available');
  navigateToSeeAllMembers() {
    NavService.navigateToAllMemberScreen();
  }

  onJoin() {
    Constants.customSuccessSnack('Request send to admin to join grpup');
    NavService.back();
  }
}
