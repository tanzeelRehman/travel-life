import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';

class GroupJoinViewModel extends ReactiveViewModel {
  TextEditingController? groupDescription;

  init(Group group) {
    groupDescription = TextEditingController(
      text: group.description ?? '-----',
    );
    notifyListeners();
  }

  navigateToSeeAllMembers() {
    NavService.navigateToAllMemberScreen();
  }

  onJoin() {
    Constants.customSuccessSnack('Request send to admin to join grpup');
    NavService.back();
  }
}
