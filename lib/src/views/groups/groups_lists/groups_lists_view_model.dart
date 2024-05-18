import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/group_type.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';

class GroupsListsViewModel extends ReactiveViewModel with DatabaseViewModel {
  List<Group> groups = [];
  init(GroupType type) async {
    if (type == GroupType.public) {
      await loadPublicGroups();
    } else {
      await loadPrivateGroups();
    }
  }

  navigateToGroupHome(Group group) {
    NavService.navigateToGroupHomeScreen(group: group);
  }

  loadPublicGroups() async {
    setBusy(true);
    groups = await databaseService.getPublicGroups() ?? [];
    notifyListeners();
    setBusy(false);
  }

  loadPrivateGroups() async {
    setBusy(true);
    groups = await databaseService.getPrivateGroups() ?? [];
    notifyListeners();
    setBusy(false);
  }
}
