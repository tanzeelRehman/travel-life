import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/models/app_user.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class AddMemberViewModel extends ReactiveViewModel
    with SupabaseAuthViewModel, DatabaseViewModel {
  late final Group group;
  init(Group g) {
    group = g;
    notifyListeners();
    getUsersToInvite();
  }

  final TextEditingController searchController = TextEditingController();
  List<AppUser> selectedMembersList = [];
  List<AppUser> allMembersList = [];
  List<AppUser> filterdMembersList = [];

  filterMembersList(String query) {
    if (query.isEmpty) {
      filterdMembersList = allMembersList;
    }
    filterdMembersList = allMembersList.where(
      (element) {
        String elementsFirstName = element.firstname ?? '';

        return elementsFirstName.toLowerCase().contains(
              query.toLowerCase(),
            );
      },
    ).toList();
    notifyListeners();
  }

  getUsersToInvite() async {
    setBusy(true);
    allMembersList = await databaseService.getUsersForInvite(group.id!) ?? [];
    filterdMembersList = allMembersList;
    setBusy(true);
    notifyListeners();
  }

  bool membersIsInList(AppUser member) {
    if (selectedMembersList.contains(member)) {
      print(selectedMembersList.contains(member));
      return true;
    } else {
      print(false);
      return false;
    }
  }

  onClickSendInvites() async {
    // sendInvite();

    if (selectedMembersList.isNotEmpty) {
      selectedMembersList.forEach((element) {
        databaseService.inviteUserToGroup(element.id!, group.id!);
      });
    }
    selectedMembersList.clear();
    notifyListeners();

    await Future.delayed(Duration(seconds: 2));
    NavService.back();

    Constants.customSuccessSnack('Invitation sent to the selected users');
  }

  void addMemberToList(AppUser member) {
    selectedMembersList.add(member);
    notifyListeners();
  }

  void removeMemberToList(AppUser member) {
    selectedMembersList.remove(member);
    notifyListeners();
  }

  // void sendInvite() async {
  //   selectedMembersList.clear();
  //   notifyListeners();
  //   Constants.customSuccessSnack('Invitation sent to all users');
  //   await Future.delayed(Duration(seconds: 2));
  //   // NavService.navigateToGroupHomeScreen(group: group);
  //   NavService.back();
  // }
}
