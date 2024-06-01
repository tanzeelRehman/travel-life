import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/group_join.dart';
import 'package:starter_app/src/base/enums/group_type.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class GroupsMainViewModel extends ReactiveViewModel
    with DatabaseViewModel, SupabaseAuthViewModel, DataViewModel {
  // List<Group> forYouGroups = [];

  init() async {
    await getGroupsForYou();
  }

  navigateToGroupLists(GroupType groupType) {
    NavService.navigateToGroupsListsScreen(groupType: groupType);
  }

  navigateToMyGroups() {
    NavService.navigateToMyGroupsScreen();
  }

  navigateToGroupJoin(GroupJoin groupJoin, Group group) {
    NavService.navigateToGroupJoinScreen(
      groupJoin: groupJoin,
      group: group,
    );
  }

  getGroupsForYou() async {
    setBusy(true);
    dataService.forYouGroups = await databaseService.getForYouGroups() ?? [];
    notifyListeners();
    setBusy(false);
  }
}
