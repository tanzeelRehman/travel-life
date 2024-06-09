import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/group_action.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class GroupHomeViewModel extends ReactiveViewModel
    with SupabaseAuthViewModel, DatabaseViewModel, DataViewModel {
  late final Group group;

  int totalMembers = 0;
  init(Group g) {
    group = g;
    notifyListeners();
    getTotalMembersCount();
  }

  navigateToSeeAllMembers() {
    NavService.navigateToAllMemberScreen(group: group);
  }

  navigateToEditGroupDetails() {
    NavService.navigateToGroupCreateScreen(
      groupAction: GroupAction.edit,
      group: group,
    );
  }

  bool isGroupAdmin() {
    return supabaseAuthService.user?.id == group.admin?.id;
  }

  navigateToJoinRequestsScreen() {
    NavService.navigateToGroupJoinRequestsScreen(group: group);
  }

  navigateToInviteScreen() {
    NavService.navigateToInviteMiddleScreen(group: group);
  }

  getTotalMembersCount() async {
    totalMembers = await databaseService.getTotalGroupMembers(group.id!);
    notifyListeners();
  }

  onClickLeaveGroup() async {
    setBusy(true);
    final res = await databaseService.leaveGroup(
      supabaseAuthService.user!.id!,
      group.id!,
    );
    setBusy(false);
    if (res) {
      getMyGroups();
      getJoinedGroups();
      NavService.back();
      Constants.customSuccessSnack('You Left the group', title: 'Group Left');
    }
  }

  getMyGroups() async {
    dataService.myGroups = await databaseService.getMyCreatedGroups() ?? [];
  }

  getJoinedGroups() async {
    dataService.joinedGroups = await databaseService.getJoinedGroups() ?? [];
  }
}
