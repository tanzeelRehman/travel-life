import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/group_action.dart';
import 'package:starter_app/src/base/enums/group_join.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/models/invited_group.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';

class MyGroupsViewModel extends ReactiveViewModel
    with DatabaseViewModel, DataViewModel {
  init() async {
    getMyGroups();
    getJoinedGroups();
    getInvites();
  }

  int selectedTab = 0;

  bool invitesLoading = false;
  bool myGroupsLoading = false;
  bool joinedGroupsLoading = false;

  setInvitesLoading(bool v) {
    invitesLoading = v;
    notifyListeners();
  }

  setMyGroupsLoading(bool v) {
    myGroupsLoading = v;
    notifyListeners();
  }

  setJoinedGroupsLoading(bool v) {
    joinedGroupsLoading = v;
    notifyListeners();
  }

  onChangeTab(int v) {
    selectedTab = v;
    notifyListeners();
  }

  navigateToGroupAddPage() {
    NavService.navigateToGroupCreateScreen(
        groupAction: GroupAction.add, group: null);
  }

  navigateToGroupEditPage(Group group) {
    NavService.navigateToGroupCreateScreen(
      groupAction: GroupAction.edit,
      group: group,
    );
  }

  navigateToGroupsHome(Group group) {
    NavService.navigateToGroupHomeScreen(group: group);
  }

  onOpenInviteGroupDetail(InvitedGroup group) {
    NavService.navigateToGroupJoinScreen(
      groupJoin: GroupJoin.accept,
      group: group.group!,
      invitedGroup: group,
    );
  }

  getInvites() async {
    setInvitesLoading(true);
    dataService.invites = await databaseService.getInvitedGroups() ?? [];
    setInvitesLoading(false);
  }

  getMyGroups() async {
    setMyGroupsLoading(true);
    dataService.myGroups = await databaseService.getMyCreatedGroups() ?? [];
    setMyGroupsLoading(false);
  }

  getJoinedGroups() async {
    setJoinedGroupsLoading(true);
    dataService.joinedGroups = await databaseService.getJoinedGroups() ?? [];
    setJoinedGroupsLoading(false);
  }

  onClickAcceptInvite(int groupMemberId) async {
    setBusy(true);

    final res = await databaseService.acceptInviteRequest(groupMemberId);
    if (res) {
      Constants.customSuccessSnack('Invitation accepted');
      getJoinedGroups();
      getInvites();
      setBusy(false);
    }
    setBusy(false);
  }

  onClickRejectInvite(int groupMemberId) async {
    setBusy(true);

    final res = await databaseService.rejectInviteRequest(groupMemberId);
    if (res) {
      Constants.customSuccessSnack('Invitation Rejected');
      getInvites();
    }
    setBusy(false);
  }

  onDisableGroup(int groupId, bool isEnabled) async {
    final res = await databaseService.disableGroup(groupId, isEnabled);
    getMyGroups();
    if (res) {
      getMyGroups();
      getJoinedGroups();
    }
  }

  onClickInvite(Group group) {
    NavService.navigateToInviteMiddleScreen(group: group);
  }

  onClickExplore() {
    NavService.navigateToGroupsMainScreen();
  }

  onClickGroupActivities() {
    NavService.navigateToGroupActivitesScreen();
  }
}
