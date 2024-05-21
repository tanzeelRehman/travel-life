import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/group_join.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class GroupJoinViewModel extends ReactiveViewModel
    with DatabaseViewModel, SupabaseAuthViewModel, DataViewModel {
  TextEditingController? groupDescription;

  int totalMembers = 0;

  late final Group group;

  init(Group g) {
    group = g;

    notifyListeners();
    getTotalMembersCount();
    groupDescription = TextEditingController(
      text: group.description ?? '-----',
    );
    notifyListeners();
  }

  onClickJoinOrRequestJoin(GroupJoin groupJoinMode) {
    if (groupJoinMode == GroupJoin.join) {
      joinGroup();
    } else if (groupJoinMode == GroupJoin.requestJoin) {
      requestToJoinGroup();
    }
  }

  joinGroup() async {
    setBusy(true);
    final res = await databaseService.joinPublicGroup(
      supabaseAuthService.user!.id!,
      group.id!,
    );

    if (res) {
      setBusy(false);

      getGroupsForYou();
      getPublicGroups();
      getPrivateGroups();

      NavService.back(); //TODO: navigate to group home screen instead of this
      Constants.customSuccessSnack('Group joined successfully');
    }
    setBusy(false);
  }

  requestToJoinGroup() async {
    setBusy(true);
    final res = await databaseService.requestToJoinGroup(
      supabaseAuthService.user!.id!,
      group.id!,
    );

    if (res) {
      setBusy(false);

      getGroupsForYou();
      getPublicGroups();
      getPrivateGroups();

      NavService.back();
      Constants.customSuccessSnack('Join request sent successfully');
    }
    setBusy(false);
  }

  getTotalMembersCount() async {
    totalMembers = await databaseService.getTotalGroupMembers(group.id!);
    notifyListeners();
  }

  getGroupsForYou() async {
    dataService.forYouGroups = await databaseService.getForYouGroups() ?? [];
    notifyListeners();
  }

  getPublicGroups() async {
    dataService.publicGroups = await databaseService.getPublicGroups() ?? [];
    notifyListeners();
  }

  getPrivateGroups() async {
    dataService.privateGroups = await databaseService.getPrivateGroups() ?? [];
    notifyListeners();
  }

  onGroupLeave() async {
    setBusy(true);
    final res = await databaseService.leaveOrRemoveUserFromGroup(
      supabaseAuthService.user!.id!,
      group.id!,
    );
    if (res) {
      setBusy(false);

      getGroupsForYou();
      getPublicGroups();
      getPrivateGroups();

      NavService.back();
      Constants.customSuccessSnack('Group left');
    }
    setBusy(false);
  }
}
