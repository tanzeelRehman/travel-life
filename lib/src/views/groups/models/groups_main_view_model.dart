import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/group_join.dart';
import 'package:starter_app/src/base/enums/group_type.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';

class GroupsMainViewModel extends ReactiveViewModel {
  init() {}
  initGroupsList(String groupType) {
    if (groupType == 'Public') {
      print('fetch pub;ic groups');
    } else {
      print('fetch private groups');
    }
  }

  navigateToGroupLists(GroupType groupType) {
    NavService.navigateToGroupsListsScreen(groupType: groupType);
  }

  navigateToMyGroups() {
    NavService.navigateToMyGroupsScreen();
  }

  navigateToGroupJoin(GroupJoin groupJoin, String groupName) {
    NavService.navigateToGroupJoinScreen(
        groupJoin: groupJoin, groupName: groupName);
  }
}
