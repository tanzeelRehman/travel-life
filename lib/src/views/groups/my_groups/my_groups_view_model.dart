import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/group_action.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/models/invited_group.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';

class MyGroupsViewModel extends ReactiveViewModel with DatabaseViewModel {
  init() async {
    getMyGroups();
    getJoinedGroups();
    getInvites();
  }

  int selectedTab = 0;

  List<InvitedGroup> invites = [];
  List<Group> myGroups = [];
  List<Group> joinedGroups = [];

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

  navigateToGroupEditPage() {
    NavService.navigateToGroupCreateScreen(groupAction: GroupAction.edit);
  }

  navigateToGroupsHome(Group group) {
    NavService.navigateToGroupHomeScreen(group: group);
  }

  //TODO: make all these lists available in the dataService. invites, mygroups, joinedgorups
  getInvites() async {
    setInvitesLoading(true);
    invites = await databaseService.getInvitedGroups() ?? [];
    setInvitesLoading(false);
  }

  getMyGroups() async {
    setMyGroupsLoading(true);
    myGroups = await databaseService.getMyCreatedGroups() ?? [];
    setMyGroupsLoading(false);
  }

  getJoinedGroups() async {
    setJoinedGroupsLoading(true);
    joinedGroups = await databaseService.getJoinedGroups() ?? [];
    setJoinedGroupsLoading(false);
  }

  onClickAcceptInvite(int groupMemberId) async {
    setBusy(true);

    final res = await databaseService.acceptInviteRequest(groupMemberId);
    if (res) {
      Constants.customSuccessSnack('Invitation accepted');
      getInvites();
    }
    setBusy(false);
  }

  onClickRejectInvite(int groupMemberId) async {
    setBusy(true);

    final res = await databaseService.rejectInviteRequest(groupMemberId);
    if (res) {
      Constants.customSuccessSnack('Invitation accepted');
      getInvites();
    }
    setBusy(false);
  }
}
