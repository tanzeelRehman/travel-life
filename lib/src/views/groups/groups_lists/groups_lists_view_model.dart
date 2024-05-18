import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/group_type.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';

class GroupsListsViewModel extends ReactiveViewModel
    with DatabaseViewModel, DataViewModel {
  List<Group> groups = [];
  init(GroupType type) async {
    if (type == GroupType.public) {
      groups = dataService.publicGroups;
      await loadPublicGroups();
    } else {
      groups = dataService.privateGroups;
      await loadPrivateGroups();
    }
  }

  navigateToGroupHome(Group group) {
    NavService.navigateToGroupHomeScreen(group: group);
  }

  loadPublicGroups() async {
    setBusy(true);
    dataService.publicGroups = await databaseService.getPublicGroups() ?? [];
    notifyListeners();
    setBusy(false);
  }

  loadPrivateGroups() async {
    setBusy(true);
    dataService.privateGroups = await databaseService.getPrivateGroups() ?? [];
    notifyListeners();
    setBusy(false);
  }
}
